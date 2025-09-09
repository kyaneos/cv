#!/usr/bin/env Rscript

# Justin Moran's CV Generator
# Main script to generate CV with date-based filenames

# Load required libraries
library(rmarkdown)

cat("🎯 Justin Moran's CV Generator\n")
cat("================================\n\n")

# Create date-based filename
current_date <- format(Sys.Date(), "%Y-%m-%d")
web_filename <- paste0("cv_", current_date, ".html")
pdf_filename <- paste0("cv_", current_date, "_pdf.html")

# Check if we need to create new dated files (only if date changed)
should_create_dated_files <- function() {
  latest_exists <- file.exists(file.path("generated", "latest.html"))
  if (!latest_exists) return(TRUE)
  
  # Check if latest file is from today
  existing_files <- list.files("generated", pattern = paste0("^cv_", current_date, ".*\\.html$"))
  return(length(existing_files) == 0)
}

# Clean up old CV files (keep last 5 dates)
cleanup_old_files <- function() {
  cv_files <- list.files("generated", pattern = "^cv_\\d{4}-\\d{2}-\\d{2}.*\\.html$", full.names = TRUE)
  if (length(cv_files) > 10) {  # Keep last 10 files (5 web + 5 pdf versions)
    # Sort by modification time (newest first)
    cv_files <- cv_files[order(file.mtime(cv_files), decreasing = TRUE)]
    # Remove older files
    old_files <- cv_files[11:length(cv_files)]
    file.remove(old_files)
    cat("🧹 Cleaned up", length(old_files), "old CV files\n")
  }
}

# Check if Google Sheets data is accessible
tryCatch({
  library(googlesheets4)
  gs4_deauth()
  test_data <- read_sheet("https://docs.google.com/spreadsheets/d/1Kd-qv6oxFzKKzvim2TdFYXslB398zdJ6tKX1Dur064M", 
                         sheet = "entries", range = "A1:B2", col_types = "c")
  cat("✅ Google Sheets data accessible\n")
}, error = function(e) {
  cat("❌ Error accessing Google Sheets:", e$message, "\n")
  cat("Please check your internet connection and sheet permissions\n")
  stop("Cannot proceed without data access")
})

# Check if we need to create dated files
create_dated <- should_create_dated_files()

# Generate Strayer-style CV (recommended)
cat("\n📄 Generating CV for", current_date, "...\n")

if (create_dated) {
  cat("📅 Creating new dated versions...\n")
  # Generate dated versions
  rmarkdown::render(
    'templates/justin_moran_cv_strayer_style.Rmd',
    params = list(pdf_mode = FALSE),
    output_dir = 'generated/',
    output_file = web_filename
  )

  rmarkdown::render(
    'templates/justin_moran_cv_strayer_style.Rmd',
    params = list(pdf_mode = TRUE),
    output_dir = 'generated/',
    output_file = pdf_filename
  )
} else {
  cat("📝 Date unchanged, updating latest versions only...\n")
}

# Always update latest versions
latest_web <- file.path("generated", "latest.html")
latest_pdf <- file.path("generated", "latest_pdf.html")

# Generate latest versions
rmarkdown::render(
  'templates/justin_moran_cv_strayer_style.Rmd',
  params = list(pdf_mode = FALSE),
  output_dir = 'generated/',
  output_file = "latest.html"
)

rmarkdown::render(
  'templates/justin_moran_cv_strayer_style.Rmd',
  params = list(pdf_mode = TRUE),
  output_dir = 'generated/',
  output_file = "latest_pdf.html"
)

# Clean up old files after generating new ones
if (create_dated) cleanup_old_files()

cat("✅ HTML versions generated successfully!\n")

# List recent CV files
recent_files <- list.files("generated", pattern = "^cv_\\d{4}-\\d{2}-\\d{2}.*\\.html$")
if (length(recent_files) > 0) {
  recent_files <- sort(recent_files, decreasing = TRUE)[1:min(6, length(recent_files))]
  cat("\n📁 Recent CV files:\n")
  for (file in recent_files) {
    cat("  -", file, "\n")
  }
}

# Manual PDF generation instructions
cat("\n📋 To generate PDF:\n")
cat("1. Open 'generated/latest.html' in your browser\n")
cat("2. Press Cmd+P (Print)\n") 
cat("3. Select 'Save as PDF'\n")
cat("4. Choose 'More settings' → Margins: None → Layout: Portrait\n")
cat("5. Save as 'CV_", current_date, ".pdf'\n")

cat("\n🎉 CV generation complete!\n")
cat("\nFiles created:\n")
cat("- generated/", web_filename, " (dated web version)\n")
cat("- generated/", pdf_filename, " (dated PDF version)\n")
cat("- generated/latest.html (symlink to current version)\n")
cat("- generated/latest_pdf.html (symlink to PDF version)\n")
cat("\n💡 Always use 'latest.html' for the most current version!\n")