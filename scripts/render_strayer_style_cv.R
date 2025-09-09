# Script to render Justin Moran's CV with Strayer's design

# Load required libraries
library(rmarkdown)
library(pagedown)

# Render CV to HTML (for web viewing)
rmarkdown::render(
  'justin_moran_cv_strayer_style.Rmd',
  params = list(pdf_mode = FALSE),
  output_file = 'justin_moran_cv_strayer_style.html'
)

# Render CV to PDF 
rmarkdown::render(
  'justin_moran_cv_strayer_style.Rmd',
  params = list(pdf_mode = TRUE),
  output_file = 'justin_moran_cv_strayer_style_web.html'
)

cat("CV rendered successfully!\n")
cat("Files created:\n")
cat("- justin_moran_cv_strayer_style.html (web version)\n") 
cat("- justin_moran_cv_strayer_style_web.html (PDF-ready version)\n")
cat("\nTo create PDF, run:\n")
cat('"/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" --headless --disable-gpu --print-to-pdf="Justin_Moran_CV_Strayer_Style.pdf" --virtual-time-budget=5000 "file:///Users/kyaneos/Desktop/cv/justin_moran_cv_strayer_style.html"\n')