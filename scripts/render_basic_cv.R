# Script to render Justin Moran's CV

# Install required packages if not already installed
required_packages <- c("pagedown", "googlesheets4", "readr", "stringr", "glue", "dplyr")

for(package in required_packages) {
  if(!requireNamespace(package, quietly = TRUE)) {
    install.packages(package, repos='https://cran.rstudio.com/')
  }
}

# Load required libraries
library(rmarkdown)
library(pagedown)

# Render CV to HTML (for web viewing)
rmarkdown::render(
  'justin_moran_cv.Rmd',
  params = list(pdf_mode = FALSE),
  output_file = 'justin_moran_cv.html'
)

# Render CV to PDF 
rmarkdown::render(
  'justin_moran_cv.Rmd',
  params = list(pdf_mode = TRUE),
  output_file = 'justin_moran_cv_web.html'
)

# Convert HTML to PDF using pagedown
pagedown::chrome_print(
  'justin_moran_cv_web.html',
  output = 'Justin_Moran_CV_DataDriven.pdf'
)

cat("CV rendered successfully!\n")
cat("Files created:\n")
cat("- justin_moran_cv.html (web version)\n") 
cat("- Justin_Moran_CV_DataDriven.pdf (PDF version)\n")