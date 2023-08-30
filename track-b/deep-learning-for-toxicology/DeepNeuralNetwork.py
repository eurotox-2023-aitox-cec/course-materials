#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
script to build a deep neural network using data from "submitScriptOrig.py"
output: graphic of the model ("DNN_model.png") and training & validation plots ("DNN_training.png")
'''

import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split, KFold
import sklearn.metrics 
from sklearn.metrics import confusion_matrix, roc_auc_score, roc_curve, accuracy_score, precision_recall_curve, auc, f1_score
from tensorflow.keras import models, layers, utils, backend as K
import tensorflow as tf
import statistics

from plot_NN import *
#from submitScriptOrig import GET_DATA #Remark: Everything in submitScriptOrig.py that is not in a function will be executed!

def Recall(y_true, y_pred):
    true_positives = K.sum(K.round(K.clip(y_true * y_pred, 0, 1)))
    possible_positives = K.sum(K.round(K.clip(y_true, 0, 1)))
    recall = true_positives / (possible_positives + K.epsilon())
    return recall

def Precision(y_true, y_pred):
    true_positives = K.sum(K.round(K.clip(y_true * y_pred, 0, 1)))
    predicted_positives = K.sum(K.round(K.clip(y_pred, 0, 1)))
    precision = true_positives / (predicted_positives + K.epsilon())
    return precision

def F1(y_true, y_pred):
    precision = Precision(y_true, y_pred)
    recall = Recall(y_true, y_pred)
    return 2*((precision*recall)/(precision+recall+K.epsilon()))

def create_model(n_features):
    """
    Creates a simple (mostly) unoptimized neural network with three hidden and dropout layers.
    """
    model = models.Sequential(name="DeepNN", layers=[
        ### hidden layer 1
        layers.Dense(name="h1", input_dim=n_features,
                     units=int(round((n_features)/2)), 
                     activation='relu'),
        layers.Dropout(name="drop1", rate=0.2),
        ### hidden layer 2
        layers.Dense(name="h2", units=int(round((n_features)/4)), 
                     activation='relu'),
        layers.Dropout(name="drop2", rate=0.2),
        ### hidden layer 3
        layers.Dense(name="h3", units=int(round((n_features+10)/8)), 
                     activation='relu'),
        layers.Dropout(name="drop3", rate=0.2),
        layers.Dense(name="output", units=1, activation='sigmoid')
    ])
    # compile the neural network
    model.compile(optimizer='SGD', loss='mean_absolute_error', 
                  metrics=['accuracy',F1])#,Recall,Precision])
    return model

def train_DNN(fps, act):
    '''
    Train and validate the model.
    '''
    fpsIndList = [i for i in range(0,len(fps))] 
    trainFpsInds, testFpsInds, y_train, y_val = train_test_split(fpsIndList, act, test_size=0.10, stratify=act)
    x_train = np.array([fps[x] for i,x in enumerate(trainFpsInds)])
    x_val = np.array([fps[x] for i,x in enumerate(testFpsInds)])
    n_features = x_train.shape[1]
    model = create_model(n_features)
    model.summary()
    #configuration
    bs = 32
    ep = 1000
    #plot
    utils.plot_model(model, to_file='DNN_model.png', show_shapes=True, show_layer_names=True)
    #### train model ####
    training = model.fit(x=x_train, y=np.array(y_train), batch_size=bs, epochs=ep, verbose=0, validation_data=(x_val, np.array(y_val)))
    #### results ####
    print("Training DNN")
    print("Training Accuracy: ", round(max(training.history['accuracy']), 3))
    print("Training F1: ", round(max(training.history['F1']), 3))
    print("Validation Accuracy: ", round(max(training.history['val_accuracy']), 3))
    print("Validation F1: ", round(max(training.history['val_F1']), 3))
    #### plot ####
    metrics = [k for k in training.history.keys() if ("loss" not in k) and ("val" not in k)]    
    fig, ax = plt.subplots(nrows=1, ncols=2, sharey=True, figsize=(40,12))
    ## training    
    ax[0].set(title="Training")    
    ax11 = ax[0].twinx()    
    ax[0].plot(training.history['loss'], color='black')    
    ax[0].set_xlabel('Epochs')    
    ax[0].set_ylabel('Loss', color='black')    
    for metric in metrics:        
        ax11.plot(training.history[metric], label=metric)    
    ax11.set_ylabel("Score", color='steelblue')    
    ax11.legend()
    ## validation    
    ax[1].set(title="Validation")    
    ax22 = ax[1].twinx()    
    ax[1].plot(training.history['val_loss'], color='black')    
    ax[1].set_xlabel('Epochs')    
    ax[1].set_ylabel('Loss', color='black')    
    for metric in metrics:          
        ax22.plot(training.history['val_'+metric], label=metric)    
    ax22.set_ylabel("Score", color="steelblue")  
    plt.savefig('DNN_training.png', dpi=200)
    plt.close()
    return training.model

def test_DNN(model, fps, act):
    '''
    Test DNN using external data set.
    '''
    fps = np.array(fps)
    act = np.array(act)
    res = model.predict(fps)
    compare = pd.DataFrame({'is_TRUE':np.where(act==1, True, False), 'prediction':np.where(res[:, 0]>0.75, True, False), 'prediction_value':res.tolist()})
    tn, fp, fn, tp = confusion_matrix(compare['is_TRUE'], compare['prediction'], labels=[0, 1]).ravel()
    print("External Validation DNN")
    print('AUC:', round(roc_auc_score(act, res[:, 0]), 3))
    print('Accuracy:', round((tp+tn)/(tp+fp+tn+fn), 3))
    print('Sensitivity:', round(tp/(tp+fn), 3))
    print('False negative Rate:', round(fn/(tp+fn), 3))
    print('Specificity:', round(tn/(tn+fp), 3))
    print('False positive Rate:', round(fp/(tn+fp), 3))
    precision, recall, thresholds = precision_recall_curve(compare['is_TRUE'], compare['prediction'])
    area = sklearn.metrics.auc(recall, precision)
    f1 = f1_score(compare['is_TRUE'], compare['prediction'])
    print(f'F1: %0.3f' % f1)
    fpr, tpr, thresholds = roc_curve(compare['is_TRUE'], compare['prediction'])
    res = [round(roc_auc_score(act, res[:, 0]), 3), round((tp/(tp+fn) + tn/(tn+fp))/2, 3), round((tp+tn)/(tp+fp+tn+fn), 3), round(tp/(tp+fn), 3), round(tn/(tn+fp), 3), f1]
    #plt.figure()
    #plt.plot(fpr, tpr)
    #plt.title('ROC curve')
    #plt.xlabel('False Positive Rate')
    #plt.ylabel('True Positive Rate')
    #plt.savefig('DNN_externalValidation_ROCcurve.png', dpi=200)
    #plt.close()
    return res, compare

def k_fold_DNN(k, x, y):
    '''
    K-Fold cross validation for DNN.

    '''
    x = np.array(x)
    y = np.array(y)
    kfold = KFold(n_splits=k, shuffle=True, random_state=42)
    auc = []
    bacc =[]
    acc = []
    sens = []
    fnr = []
    spec = []
    fpr = []
    auprc = []
    f1 = []
    for train_index, test_index in kfold.split(x):
        kfold_x_train, kfold_x_test = x[train_index], x[test_index]
        kfold_y_train, kfold_y_test = y[train_index], y[test_index]
        model = create_model(x.shape[1])
        model.fit(kfold_x_train, kfold_y_train, batch_size=32, epochs=1000, verbose=0)
        y_pred = model.predict(kfold_x_test)
        y_pred = np.where(y_pred[:, 0]>0.75, 1, 0)
        kfold_y_test = tf.constant(kfold_y_test)
        accuracy = accuracy_score(kfold_y_test, y_pred)
        tn, fp, fn, tp = confusion_matrix(kfold_y_test, y_pred, labels=[0, 1]).ravel()
        precision, recall, thresholds = precision_recall_curve(kfold_y_test, y_pred)
        area = sklearn.metrics.auc(recall, precision)
        auc.append(roc_auc_score(kfold_y_test, y_pred))
        bacc.append((tp/(tp+fn) + tn/(tn+fp))/2)
        acc.append(accuracy)
        sens.append(tp/(tp+fn))
        fnr.append(fn/(tp+fn))
        spec.append(tn/(tn+fp))
        fpr.append(fp/(tn+fp))
        auprc.append(area)
        f1.append(f1_score(kfold_y_test, y_pred))
    kfold_res = pd.DataFrame(list(zip(auc, bacc, acc, sens, fnr, spec, fpr, auprc, f1)), columns=['AUC', 'Balanced_Accuracy', 'Accuracy', 'Sensitivity', 'FNR', 'Specificity', 'FPR', 'AUC_PR', 'F1'])
    print(k, 'Fold Cross Validation DNN')
    print('AUC:', round(statistics.mean(auc), 3))
    print('Accuracy:', round(statistics.mean(acc), 3))
    print('Sensitivity:', round(statistics.mean(sens), 3))
    print('False negative Rate:', round(statistics.mean(fnr), 3))
    print('Specificity:', round(statistics.mean(spec), 3))
    print('False positive Rate:', round(statistics.mean(fpr), 3))
    print('Area Under PR Curve(AP):', round(statistics.mean(auprc), 3))
    print('F1:', round(statistics.mean(f1), 3))
    return kfold_res

### run the model ###
#global dataSet
#global sampling
#dataSet = "AhR" 
#sampling = "kMedoids2" 
#trainFps, trainAct = GET_DATA(dataSet,sampling=sampling)
#train_DNN(trainFps, trainAct)