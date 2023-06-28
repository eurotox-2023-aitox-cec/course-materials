## render book
## run this code to render the bookdown project locally for the workshop 
## "Machine Learning with R" 
base_folder <- here::here(
  "track-a",
  "machine-learning-with-r"
)

bookdown::render_book(base_folder)

