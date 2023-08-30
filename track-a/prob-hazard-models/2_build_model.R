pacman::p_load(arrow, biobricks, tidyverse, glue, torch, zeallot)

# Define the dimensions
input_dim <- length(allowed_chars)
latent_dim <- 50
value_dim <- 1  # Assuming the value tensor is a 1D tensor per SMILES string
hidden_dim <- 128
lstm_output_dim <- 64 

# Encoder
encoder <- nn_module(
  "encoder",
  initialize = function() {
    self$lstm <- nn_lstm(input_dim, lstm_output_dim, batch_first = TRUE)
    self$fc_mu <- nn_linear(lstm_output_dim, latent_dim)
    self$fc_logvar <- nn_linear(lstm_output_dim, latent_dim)
  },
  forward = function(x, c) {
    output <- self$lstm(x)[[1]]
    # Taking the last output from the LSTM
    last_output <- output[ , dim(output)[2], ]
    mu <- self$fc_mu(last_output)
    logvar <- self$fc_logvar(last_output)
    list(mu, logvar)
  }
)


# Reparameterization Trick
reparameterize <- function(mu, logvar) {
  std <- torch_exp(0.5 * logvar)
  eps <- 0.01*torch_randn_like(std)
  mu + eps * std
}

# Decoder with Repeated Latent Variable
decoder <- nn_module(
  "decoder",
  initialize = function(seq_len) {
    self$lstm <- nn_lstm(input_size = latent_dim + value_dim, hidden_size = hidden_dim, batch_first = TRUE)
    self$fc_out <- nn_linear(hidden_dim, input_dim)
    self$seq_len <- seq_len
  },
  forward = function(z, c) {
    zc <- torch_cat(list(z, c), dim = 2)
    zc_rep <- zc$unsqueeze(2)$expand(c(-1, self$seq_len, -1))
    output <- self$lstm(zc_rep)[[1]]
    x <- torch_sigmoid(self$fc_out(output))
    x
  }
)

# GRU-based Decoder
decoder <- nn_module(
  "decoder",
  initialize = function(seq_len) {
    self$lstm <- nn_lstm(input_size = latent_dim + value_dim + length(allowed_chars), hidden_size = hidden_dim, batch_first = TRUE)
    self$fc_out <- nn_linear(hidden_dim, input_dim)
    self$seq_len <- seq_len
  },
  forward = function(z, c, masked_x) {
    zc <- torch_cat(list(z, c), dim = 2)
    zc_rep <- zc$unsqueeze(2)$expand(c(-1, self$seq_len, -1))
    smi_zc_rep <- torch_cat(list(masked_x,zc_rep), dim=3)
      
    output <- self$lstm(smi_zc_rep)[[1]]
    x <- torch_sigmoid(self$fc_out(output))
    x
  }
)



# Combined CVAE Model

cvae <- nn_module(
  "cvae",
  initialize = function() {
    self$encoder <- encoder()
    self$decoder <- decoder(smiles_tensor$shape[2])
  },
  forward = function(x, c) {
    c(mu, logvar) %<-% self$encoder(x, c)
    z <- reparameterize(mu, logvar)

    x_recon <- self$decoder(z, c)
    list(x_recon, mu, logvar)
  }
)

# Loss function (Assuming binary cross-entropy for reconstruction loss)
cvae_loss <- function(x_recon, x, mu, logvar) {
  bce <- nnf_binary_cross_entropy(x_recon, x, reduction = 'mean') 
  
  kld <- -0.5 * torch_sum(1 + logvar - mu^2 - torch_exp(logvar), dim = 1)
  
  loss <- torch_mean(bce + kld)
  loss
}

# Initialize model and optimizer
model <- cvae()
optimizer <- optim_adam(model$parameters, lr = 0.001)

# LET'S TRAIN!
for(epoch in 1:10) {
  optimizer$zero_grad()
  
  c(x_recon, mu, logvar) %<-% model(smiles_tensor, values_tensor)
  loss <- cvae_loss(x_recon, smiles_tensor, mu, logvar)
  
  loss$backward()
  optimizer$step()
  
  cat('Epoch:', epoch, 'Loss:', as.numeric(loss), '\n')
}
