# Function: tidy check deseq input  ----
tidy_check = function(countdata, metadata) {
  # We assume first column will contain the row names (tidy = T in DESeqDataSetFromMatrix)
  names_count = names(countdata)[-1]
  # Not obligatory for DEseq2, but we want row names in the first column
  names_meta = metadata[[1]]
  # Test if the names from the count and metadata are identical (same entries, same order)
  identical = identical(names_count, names_meta)
  # If not identical, do we have the same entries (ignores duplicates)
  setequal = identical || setequal(names_count, names_meta)
  # Test for duplicates (in theory, but very unlikely, this can also happen if identical is true)
  has_duplicates = anyDuplicated(names_meta) > 0
  # If the names are not identical, but we're looking at the same entries without duplicates,
  # then the problem is the order of the entries
  problem_is_order = !identical && setequal && !has_duplicates
  # List possibilities to test
  input = list(identical = identical, setequal = setequal, has_duplicates = has_duplicates, problem_is_order = problem_is_order)

  if(input$identical & input$setequal & !input$has_duplicates & !input$problem_is_order){
    return(TRUE)
  } else {
    print(input)
    return(FALSE)
  }
}


# Function: Get low cpm probes ----
get_low_cpm_probes <- function(countdata, metadata, exclude){

  if(!has_rownames(countdata)){
    countdata <- countdata %>%
      column_to_rownames(var = names(countdata %>% dplyr::select(where(is.character))))
  }

  if(!all(c("sample_name", "mean_id") %in% colnames(metadata))){
    stop("Metadata must contain columns sample_name and mean_id")
  }

  countdata <- countdata %>% select(-contains(paste(c(exclude, collapse = "|"))))

  countdata <- data.frame(ifelse(test = countdata >= 1, yes = 1, no = 0)) %>%
    mutate(across(where(is.numeric), ~as.logical(.x)))

  countdata <- countdata %>%
    rownames_to_column(var = "probe_id") %>%
    pivot_longer(cols = where(is.logical), names_to = "sample_name") %>%
    left_join(x = metadata %>%
                dplyr::select(sample_name, mean_id) %>%
                group_by(mean_id) %>%
                mutate(n = n()) %>%
                ungroup(),
              by = "sample_name") %>%
    group_by(mean_id, n, probe_id) %>%
    summarise(value = sum(value), .groups = "drop") %>%
    filter(value <= n * 0.75)

  n_mean_id <- length(unique(countdata$mean_id))

  countdata %>%
    group_by(probe_id) %>%
    count() %>%
    filter(n == n_mean_id) %>%
    pull(probe_id) %>%
    unique()
}


runEnrichR = function(genes){

  enrichR = enrichr(genes = genes, databases = c(
    # "BioCarta_2016",
                                                       # "HumanCyc_2016",
                                                       "KEGG_2019_Human",
                                                       # "Reactome_2016",
                                                       "WikiPathways_2019_Human",
                                                       # "InterPro_Domains_2019",
                                                       "GO_Molecular_Function_2018",
                                                       "GO_Cellular_Component_2018",
                                                       "GO_Biological_Process_2018"))

  enrichR = rbindlist(enrichR, idcol = T)
  names(enrichR)[1:2] = c("database", "source")
  return(enrichR)
}
