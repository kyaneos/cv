# Justin Moran's CV Repository

This repository contains two CV systems:

## 📄 Static CV (Main) - [kyaneos.github.io/cv](https://kyaneos.github.io/cv/)
A professional data-driven CV built with R and datadrivencv, inspired by Nick Strayer's design.

## 🚀 Interactive CV - [kyaneos.github.io/cv/interactive](https://kyaneos.github.io/cv/interactive/)
A modern interactive CV website with dark/light mode, animations, and dynamic content.

## 📋 Table of Contents
- [📄 Static CV (Data-Driven)](#-static-cv-data-driven) - R-based CV generation with Google Sheets
- [🚀 Interactive CV](#-interactive-cv-1) - Modern web CV with animations
- [🚀 Deployment Options](#-deployment-options) - GitHub Pages & hosting info
- [📚 References & Attribution](#-references--attribution) - Credits and inspiration

---

# 📄 Static CV (Data-Driven)

The main CV system using R and datadrivencv for professional, maintainable CV generation.

## 🚀 Quick Start

### 1. Generate Your CV
```bash
# Main generation script (recommended)
Rscript generate_cv.R

# Or use specific scripts
Rscript scripts/render_strayer_style_cv.R
```

### 2. View Your CV
- **Live version**: [kyaneos.github.io/cv](https://kyaneos.github.io/cv/)
- **Local web version**: Open `generated/latest.html` in your browser
- **PDF version**: Print the HTML to PDF using your browser
- **Dated versions**: Files are saved as `cv_YYYY-MM-DD.html` in `generated/`

### 3. Update Content
- Edit your [Google Sheets data](https://docs.google.com/spreadsheets/d/1Kd-qv6oxFzKKzvim2TdFYXslB398zdJ6tKX1Dur064M)
- Re-run the generation script

## 📁 File Structure

```
cv/
├── README.md                           # This documentation
├── generate_cv.R                       # ⭐ Main CV generation script
├── google_sheets_data.txt              # Template data for Google Sheets
│
├── templates/                          # CV templates
│   ├── justin_moran_cv_strayer_style.Rmd  # ⭐ Main CV template (Strayer design)
│   └── cv_basic.Rmd                    # Basic CV template
│
├── scripts/                            # Generation scripts
│   ├── render_strayer_style_cv.R       # Strayer-style CV generator
│   └── render_basic_cv.R               # Basic CV generator
│
├── generated/                          # Output files (auto-generated)
│   ├── latest.html                     # ⭐ Current web CV (symlink)
│   ├── latest_pdf.html                 # Current PDF-optimized version (symlink)
│   ├── cv_YYYY-MM-DD.html              # Date-stamped web versions
│   ├── cv_YYYY-MM-DD_pdf.html          # Date-stamped PDF versions
│   └── *.pdf                           # PDF versions
│
└── datadrivencv/                       # CV framework
    ├── CV_printing_functions.R         # Core CV functions
    ├── dd_cv.css                       # CV styling
    └── cv.Rmd                          # Original Strayer template
```

## 🎯 Features

- **Data-driven**: Content stored in Google Sheets for easy updates
- **Professional design**: Inspired by Nick Strayer's CV layout
- **Academic format**: Sections optimized for research positions
- **Responsive**: Works on desktop and mobile devices
- **Easy maintenance**: Update data in sheets, regenerate instantly
- **Automatic file management**: Date-stamped versions with old file cleanup

## 🎨 Academic Sections

- **Currently**: Active research positions
- **Education and Training**: Academic background and past positions  
- **Manuscripts**: Publications and in-preparation works
- **Open Scientific Software**: Research tools and applications
- **Technical Skills**: Programming, research, and domain expertise

## 📊 Google Sheets Data Structure

Your CV data is stored in 4 sheets:

### Sheet 1: "entries"
| section | title | institution | location | start | end | description | in_resume |
|---------|--------|-------------|----------|-------|-----|-------------|-----------|
| currently | Research Scientist | Sciminds @ UCSD | La Jolla CA | 2025 | Present | Lead projects... | TRUE |

### Sheet 2: "language_skills"
| skill | level | details |
|-------|-------|---------|
| Python | 4 | Data analysis, web development |

### Sheet 3: "text_blocks"
| loc | text |
|-----|------|
| intro | Recent UCSD Psychology graduate... |

### Sheet 4: "contact_info"
| loc | icon | contact |
|-----|------|---------|
| main | fas fa-envelope | jmoran@ucsd.edu |

**Data Source**: [Google Sheets CV Data](https://docs.google.com/spreadsheets/d/1Kd-qv6oxFzKKzvim2TdFYXslB398zdJ6tKX1Dur064M)

### Formatting Tips
- **Line breaks**: Use `<br>` in Google Sheets cells for line breaks
- **HTML formatting**: You can use basic HTML formatting in Google Sheets (e.g., `<strong>text</strong>` for bold)
- **Multiple descriptions**: Use separate columns `description_1`, `description_2`, etc. for automatic bullet points

## 🔧 Customization Guide

### 📝 Adding/Editing Content

**Edit your Google Sheets data** (easiest method):
- **Main CV content**: [Google Sheets CV Data](https://docs.google.com/spreadsheets/d/1Kd-qv6oxFzKKzvim2TdFYXslB398zdJ6tKX1Dur064M)
- Add new entries to the `entries` sheet
- Update skills in the `language_skills` sheet  
- Modify contact info in the `contact_info` sheet
- Edit intro text in the `text_blocks` sheet

### 📋 Adding New Sections

Edit `templates/justin_moran_cv_strayer_style.Rmd`:

1. **Add a new section** anywhere in the Main section:
```markdown
New Section Name {data-icon=your-icon}
--------------------------------------------------------------------------------

```{r}
CV <- CV |> print_section('your_section_name')
```
```

2. **Add the corresponding data** to your Google Sheets `entries` sheet:
   - Set `section` column to `your_section_name`
   - Add your entries with the new section name

3. **Available FontAwesome icons**: laptop, graduation-cap, book, code, suitcase, briefcase, award, star, etc.

### 🎨 Changing Section Titles

In `templates/justin_moran_cv_strayer_style.Rmd`, modify the section headers:

```markdown
<!-- Change this line -->
Education and Training {data-icon=graduation-cap data-concise=true}
<!-- To something like -->
Academic Background {data-icon=university data-concise=true}
```

### 📑 Adding Margin Notes (Aside Blocks)

Add contextual information next to any section:

```markdown
Your Section {data-icon=icon}
--------------------------------------------------------------------------------

::: aside
```{r}
if(params$pdf_mode){
  cat("This appears in the margin in PDF mode - helpful context about this section")
} else {
  cat("This appears in the sidebar in web mode - can include links or additional info")
}
```
:::

```{r}
CV <- CV |> print_section('your_section')
```
```

### 🎭 Modifying the Sidebar

Edit the **Aside** section in `templates/justin_moran_cv_strayer_style.Rmd`:

#### Change Contact Info:
- Edit the `contact_info` sheet in Google Sheets
- Icons use FontAwesome format: `fas fa-envelope`, `fab fa-linkedin`, etc.

#### Modify Skills Display:
- Edit the `language_skills` sheet in Google Sheets  
- `level` column: 1-5 scale for skill bars
- `details` column: description text

#### Add Custom Sidebar Content:
```markdown
New Sidebar Section {#custom-section}
--------------------------------------------------------------------------------

```{r}
cat("Your custom sidebar content here")
```
```

### 🎨 Styling Customization

#### Colors and Fonts
Edit `datadrivencv/dd_cv.css`:

```css
/* Main color scheme */
:root {
  --main-color: #2c3e50;        /* Change primary color */
  --accent-color: #3498db;      /* Change accent color */  
  --text-color: #333;           /* Change text color */
}

/* Fonts */
body {
  font-family: 'Georgia', serif; /* Change main font */
}
```

#### Section Spacing
```css
/* Adjust spacing between sections */
.section {
  margin-bottom: 2em; /* Change section spacing */
}
```

#### PDF-Specific Styling
```css
@media print {
  /* Styles that only apply to PDF */
  .section {
    page-break-inside: avoid; /* Prevent sections from breaking across pages */
  }
}
```

### 📊 Advanced Data Management

#### Adding New Data Types
1. **Create new sheet** in Google Sheets (e.g., "awards")
2. **Add to CV_printing_functions.R**:
```r
cv$awards <- read_gsheet(sheet_id = "awards")
```
3. **Create print function** for the new data type
4. **Add section** to your template

#### Filtering Content  
Use the `in_resume` column in `entries` sheet:
- `TRUE`: Appears in both CV and resume versions
- `FALSE`: Only appears in full CV

#### Custom Entry Types
Add new `section` values in your Google Sheets:
- `publications` - for academic papers
- `awards` - for honors and awards  
- `presentations` - for talks and posters
- `volunteer` - for volunteer work

### 🔧 Layout Modifications

#### Two-Column Layout for Sections
```markdown
::: {.col-container}
::: {.col-left}
Content for left column
:::
::: {.col-right}  
Content for right column
:::
:::
```

#### Page Breaks
Force page breaks in PDF:
```markdown
<!-- These breaks force a new page -->
<br>
<br>
<br>
```

#### Custom HTML Elements
```markdown
<div class="highlight-box">
Important information in a highlighted box
</div>
```

### 🚀 Advanced Customization Examples

#### Add Publications Section:
1. **Google Sheets**: Add entries with `section = "publications"`
2. **Template**: 
```markdown
Publications {data-icon=book-open}
--------------------------------------------------------------------------------

::: aside
```{r}
cat("Peer-reviewed publications and conference proceedings")
```
:::

```{r}
CV <- CV |> print_section('publications')
```
```

#### Custom Skills Section:
```markdown
Programming Languages {data-icon=code}
--------------------------------------------------------------------------------

```{r}
# Custom skills display
skills_data <- CV$skills |> filter(skill_type == "programming")
for(i in 1:nrow(skills_data)) {
  cat(paste0("**", skills_data$skill[i], "**: ", skills_data$details[i], "\n\n"))
}
```
```

### 🎯 Pro Tips

- **Test changes**: Run `Rscript generate_cv.R` after each modification
- **Backup**: Keep a copy of your working template before major changes
- **Version control**: Use git to track changes to your templates
- **Responsive design**: Test both web and PDF versions after styling changes
- **Print preview**: Always check PDF output for proper formatting

## 🛠 Technical Requirements

### R Packages
```r
install.packages(c(
  'rmarkdown',
  'pagedown', 
  'googlesheets4',
  'readr',
  'stringr',
  'dplyr',
  'tidyr',
  'lubridate',
  'glue'
))
```

### System Dependencies
- **R** (>= 4.0)
- **Pandoc** (for document conversion)
- **Modern web browser** (for PDF generation)

## 📝 Usage Notes

### Updating Content
1. Edit your [Google Sheets data](https://docs.google.com/spreadsheets/d/1Kd-qv6oxFzKKzvim2TdFYXslB398zdJ6tKX1Dur064M)
2. Run `Rscript generate_cv.R`
3. Files are automatically updated in `generated/` with date-stamped filenames
4. Use `generated/latest.html` for the most current version

### PDF Generation
**Recommended method** (for best results):
1. Open `generated/latest.html` in your browser
2. Press Cmd+P (macOS) or Ctrl+P (Windows)
3. Select "Save as PDF"
4. Choose "More settings" → Margins: None → Layout: Portrait
5. Save as desired filename

### File Management
- **Current versions**: Always use `generated/latest.html` and `generated/latest_pdf.html`
- **Dated versions**: Files are automatically saved as `cv_YYYY-MM-DD.html`
- **Automatic cleanup**: Old files are automatically removed (keeps 10 most recent)
- **Recent files**: The script displays the 6 most recent files when run

### Troubleshooting
- **Google Sheets access**: Ensure sheet is set to "Anyone with link can view"
- **Missing packages**: Install all required R packages listed above
- **Generation errors**: Check that Google Sheets has all 4 required sheets with correct names

## 📚 References & Attribution

This CV system builds upon the excellent work by **Nick Strayer**:

- **datadrivencv framework**: https://github.com/nstrayer/datadrivencv
- **Documentation**: https://nickstrayer.me/datadrivencv/
- **Design inspiration**: https://nickstrayer.me/cv/

### Key Features Adapted
- Professional sidebar layout with contact info and skills
- Section icons using FontAwesome
- Aside blocks for contextual information
- Clean academic styling
- Data-driven content management from Google Sheets

---

# 🚀 Interactive CV

The interactive CV is located in the `interactive/` directory and provides:

## ✨ Features
- **Dark/Light mode toggle** with smooth transitions
- **Scroll animations** - sections fade in as you scroll
- **Interactive skills** - click categories to filter skills
- **Responsive design** - works on desktop and mobile
- **Modern styling** - clean, professional appearance

## 🔧 Customization
To modify the interactive CV:

1. **Edit content**: Modify `interactive/index.html` directly
2. **Styling**: Update the CSS in the `<style>` section
3. **Functionality**: Modify JavaScript in the `<script>` section
4. **Template**: Use `interactive/cv-template.html` as a starting template

## 🌐 Live URLs
- **Main**: [kyaneos.github.io/cv/interactive](https://kyaneos.github.io/cv/interactive/)
- **Template**: [kyaneos.github.io/cv/interactive/cv-template.html](https://kyaneos.github.io/cv/interactive/cv-template.html)

---

## 🚀 Deployment Options

### GitHub Pages (Current Setup)
- **Static CV**: Automatically deployed to `https://kyaneos.github.io/cv/`
- **Interactive CV**: Automatically deployed to `https://kyaneos.github.io/cv/interactive/`

### Personal Website
- Upload HTML files from `generated/` folder for static CV
- Upload `interactive/` folder for interactive CV
- Update links as needed

## 🤝 Contributing

This is a personal CV repository, but feel free to:
- Fork for your own use
- Submit issues for bugs
- Suggest improvements
- Share adaptations

---

**Last updated**: September 2025  
**Built with**: datadrivencv, R, RMarkdown, Google Sheets  
**Inspired by**: Nick Strayer's CV design and framework