# Predictive Toxicology
Scripts and data to compare the influence of different sampling methods on predictive toxicology using Random Forests and Deep Neural Networks (DNN). 

The following are the different data sampling methods as used in this study:

• No Sampling: All the data were used without any manipulation, so called ‘original dataset’.

• Random Under Sampling (RandUS): The data points from the majority class are removed randomly.

• Augmented Random Under Sampling (AugRandomUS): Random under sampling in general removes instances of the dataset randomly. In this modified version, the randomness was reduced by utilizing a specifically calculated fingerprint called most common features (MCF) that incorporates all the common features in the data set. The features in this fingerprint are derived from MACCS fingerprints1 and Morgan fingerprints respectively. To produce this fingerprint the overall average frequency of all the features in the majority class is computed. Then, for each bit position of the fingerprint the relative frequency of ones in the complete data set is computed. If the relative frequency of a bit position is higher than the average frequency the respective bit position and the frequency is saved. Following the average number of features per fingerprint of the majority class is used to specify the number of the features per fingerprint of the MCF fingerprint, whereas the features themselves are specified by the saved features having the highest relative frequencies. Subsequently iteration is performed that is completed as soon as the majority data set is reduced to the size of the minority data set. In each step, a number of samples being the most similar to the MCF fingerprint are collected in a list. Then a number of instances is randomly chosen from the list and removed from the data set. Thereafter, a new MCF fingerprint is computed and the iteration is continued (Figure 1). In this way, the samples most similar to the MCF fingerprint are removed; the loss of variance of the majority set is decreased. In addition, the loss of information is reduced by removing a limited number of samples per calculated MCF fingerprints.

• Random over sampling (RandOS): Data points from the minority class are randomly chosen and added to the existing minority class.

• Augmented Random Over Sampling (AugRandOS): Random oversampling in this case also follows the same principle mentioned under the augmented random under sampling before. Only difference in this case, in each iteration step a list of samples most dissimilar to the MCF fingerprint is created. A part of the list is chosen randomly to be duplicated and added to the original data set. Since the samples most dissimilar to MCF are duplicated the loss of variance is relatively low. Both steps are repeated until the minority class consists of as many samples as the majority class.

• K-Medoids Under Sampling (kMedoids1): K-medoids is a clustering algorithm that is used to under sample the original majority class. A medoid is itself an instance of the majority class utilized as a cluster center that has the minimum average dissimilarity between itself and all majority data points in its cluster. The number of medoids is equal to the number of majority class instances. A sample is assigned to that cluster with which center it shares the highest similarity based on Tanimoto coefficient (Willett, 2003). For each of the medoids the sum of the similarities between itself and all samples belonging to its cluster is calculated. The algorithm tries to maximize the combination of these sums by performing iteration. The iteration is limited to 100 steps, in each of the iterations new medoids are randomly chosen and the overall sum of Tanimoto similarities is calculated. The set of medoids producing the highest sum is used as under sampled majority class. By means of clustering by similarity, this approach creates a subset of which each individual data point represents a group of structurally related molecules, in turn reducing the information lost by under sampling.

• K-Medoids Under Sampling (kMedoids2): Similarly to kMedoids1 this method starts with randomly choosing n samples as medoids, where n is equal to the number of data points in the minority class. For each of the chosen medoids, a total number of 30 iterations are assigned. In each iterative step, a medoid is exchanged with a random majority class sample, new clusters are computed and the cost is calculated using Tanimoto coefficient. The final set of medoids is chosen based on the maximum sum of similarities.

• Synthetic Minority Over-Sampling Technique-using Tanimoto Coefficient (SMOTETC): The SMOTE method creates synthetic samples of the minority class to balance the overall data set. Depending on the amount of oversampling a number of samples of the minority class are chosen. For each of those, the k-nearest neighbors are identified, utilizing the Tanimoto coefficient as similarity measure (Willett, 2003). The feature values of the new synthetic data points are set to the value occurring in the majority of the chosen sample and two of its k-nearest neighbors.

• Synthetic Minority Over-Sampling Technique-using Value Difference Metric (SMOTEVDM): This method is also based on SMOTE, but the k- nearest neighbors are chosen using the Value Difference Metric (VDM) as similarity measure. The VDM defines the distance between analogous feature values over all input feature vectors. More detailed information on the algorithm for computing VDM can be found here (Sugimura et al., 2008).

Publication: https://www.frontiersin.org/articles/10.3389/fchem.2018.00362/full

# Installation
To run the Scripts, a recent version of Python 3 is needed. Linux and macOS typically have python already installed.
- Installation guide: https://realpython.com/installing-python/.

If you want to use an IDE I recommend PyCharm: https://www.jetbrains.com/de-de/pycharm/ (Video: https://www.youtube.com/watch?v=56bPIGf4us0)
## python packages
Multiple Python packages are needed to execute the scripts. To install Python packages use 'pip install \<package\>' in the terminal/cmd/powershell. E.g. 'pip install numpy'
- numpy
- pandas
- rdkit
- joblib
- sklearn
- openpyxl
- matplotlib
- tkinter
- tensorflow
## Run the Script
To run the script, just download the repository as .zip, unzip it and run 'submitScriptOrig.py' either by typing 'python3 submitScriptOrig.py' in your terminal/cmd/rosettashell or by clicking on 'Run file' in Spyder/PyCharm. The algorithm creates multiple output directory with sampled data, result in tables and plots.

Different sampling methods can be tested by changing the sampling variable in 'submitScriptOrig.py' (line 69). The default sampling method is randOS. 
