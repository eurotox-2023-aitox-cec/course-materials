pacman::p_load(arrow, biobricks, tidyverse, glue, torch)

# Load chemharmony!
chemharmony <- biobricks::bbload("chemharmony")
chemharmony

# What are some of the bigger pids?
chemharmony$activities |> count(pid, value) |> collect() |> arrange(desc(n))
chemharmony$properties |> filter(pid=="80009751-2460-4318-8ba3-fd6b057998b7") |> collect()
jsonlite::fromJSON(.Last.value$data)

chembl <- biobricks::bbload("chembl")
chembl$assays |> filter(assay_id == 2144902) |> collect() |> 
  pivot_longer(everything(), values_transform = as.character) |>
  print(n=24)

# Build a malaria testing training set
activities <- chemharmony$activities |> 
  filter(pid == "80009751-2460-4318-8ba3-fd6b057998b7") |> head(1000) |> 
  collect() |> select(smiles, binary_value) 

activities |> count(binary_value)

# Transform smiles and values into torch tensors.
maxlength <- { nchar(activities$smiles) |> max() } + 5
unique_chars <- unique(unlist(strsplit(as.character(activities$smiles), "")))
allowed_chars <- c("^", unique_chars, "$")

tokenize_smiles <- function(insmiles_chars){
  one_hot_matrix <- matrix(0, nrow=maxlength, ncol=length(allowed_chars))
  char_idx <- insmiles_chars |> map_int(~ which(allowed_chars==.))
  for(i in seq_along(char_idx)){ one_hot_matrix[i+1, char_idx[i]] <- 1 }
  return(one_hot_matrix)
}

values_tensor <- torch_tensor(activities$binary_value, dtype = torch_float())
values_tensor <- values_tensor |> torch_unsqueeze(2) 
smiles_shape <- c(nrow(activities), maxlength, length(allowed_chars)) 
smiles_tensor <- torch_zeros(smiles_shape, dtype = torch_float())

smiles_chars <- strsplit(activities$smiles,"")
purrr::walk(seq_len(nrow(activities)), function(i) {
  one_hot_matrix <- tokenize_smiles(c("^",smiles_chars[[i]],"$"))
  one_hot_tensor <- torch_tensor(one_hot_matrix, dtype = torch_long())
  smiles_tensor[i, , ] <- one_hot_tensor
}, .progress=TRUE)

torch_save(smiles_tensor, "smiles_tensor.pt")
torch_save(values_tensor, "value_tensor.pt")

