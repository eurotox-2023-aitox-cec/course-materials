pacman::p_load(httr, jsonlite, ggplot2, grid, reticulate)

# Import necessary Python modules via reticulate
Chem <- import("rdkit.Chem")
Draw <- import("rdkit.Chem.Draw")
PIL_Image <- import("PIL.Image")
PIL_ImageDraw <- import("PIL.ImageDraw")


chemsim <- function(inchi,label,k,method){
  url <- "https://api.insilica.co/service/run/chemsim/predict"
  res <- GET(glue("{url}?inchi={inchi}&label={label}&k={k}&method={method}"))
  parsed <- jsonlite::fromJSON(content(res,"text"))
  list(
    weights = parsed$weights,
    analogue_smiles = parsed$analogue_smiles,
    analogue_values = parsed$analogue_values,
    prediction = parsed$prediction
  )
}

generate_analogues <- function(label,inchi,k=5){
  
  # Define the methods
  methods <- c("morgan", "vae", "contrastive_vae")
  all_mols <- list()
  all_values <- c()
  
  # Fetch the data for each method
  for (method in methods) {
    res <- chemsim(inchi, label, k, method)
    
    # Add the main InChI molecule for each row, followed by its k analogues
    mols <- c(Chem$MolFromInchi(inchi), lapply(res$analogue_smiles, Chem$MolFromSmiles))
    all_mols <- c(all_mols, list(mols))
    
    # Add the analogue values; '0' for the main molecule
    all_values <- c(all_values, 0, res$analogue_values)
  }
  
  # Flatten the list of mols to a single list
  all_mols <- unlist(all_mols)
  
  return(list(all_mols=all_mols, all_values=all_values))
}

create_image <- function(analogue_info, path="analogues.png"){
  
  all_mols <- analogue_info$all_mols
  all_values <- analogue_info$all_values
  
  # Create a grid image using RDKit
  img <- Draw$MolsToGridImage(all_mols, molsPerRow=6L, subImgSize=c(200L,200L))
  
  # Convert RDKit Image to PIL Image
  img_pil <- PIL_Image$new("RGB", img$size)
  img_pil$paste(img)
  
  # Create an overlay with colors
  overlay <- PIL_Image$new("RGBA", img_pil$size, tuple(255L, 255L, 255L, 0L))
  draw <- PIL_ImageDraw$Draw(overlay)
  
  # Extract image dimensions
  dims <- img_pil$size
  n_rows <- ceiling(length(all_values) / 6)  # Calculate the number of rows
  cell_width <- dims[[1]] %/% 6  # Divide by number of columns (6 in this case)
  cell_height <- dims[[2]] %/% n_rows  # Divide by the number of rows
  
  # Draw colored rectangles based on analogue values
  for(i in seq_along(all_values)) {
    row <- (i - 1) %/% 6  # Note the change here, divide by 6 columns
    col <- (i - 1) %% 6  # Modulo 6 columns
    x1 <- col * cell_width
    y1 <- row * cell_height
    x2 <- x1 + cell_width
    y2 <- y1 + cell_height
    
    coords <- tuple(x1, y1, x2, y2)
    
    if (col == 0) {
      color <- tuple(128L, 128L, 0L, 64L) # Mix of red and green
    } else {
      color <- if(all_values[[i]] == 1) { 
        tuple(255L, 0L, 0L, 64L)
      } else { 
        tuple(0L, 255L, 0L, 64L)
      }
    }
    
    draw$rectangle(coords, fill=color)
  }
  
  # Merge the two images
  img_pil$paste(overlay, mask=overlay)
  img_pil$save(path)
}

# Aspirin
analogue_info <- generate_analogues(label=25, "InChI=1S/C9H8O4/c1-6(10)13-8-5-3-2-4-7(8)9(11)12/h2-5H,1H3,(H,11,12)")
create_image(analogue_info, "analogues_1.png")

# Thalidomide
analogue_info <- generate_analogues(label=25, "InChI=1S/C13H10N2O4/c16-10-6-5-9(11(17)14-10)15-12(18)7-3-1-2-4-8(7)13(15)19/h1-4,9H,5-6H2,(H,14,16,17)")
create_image(analogue_info, "analogues_2.png")

# Isobutyl Methacrylate
analogue_info <- generate_analogues(label=25, "InChI=1S/C8H14O2/c1-6(2)5-10-8(9)7(3)4/h6H,3,5H2,1-2,4H3  ")
create_image(analogue_info, "analogues_3.png")