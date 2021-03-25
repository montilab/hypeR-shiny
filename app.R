library(hypeR)
library(shiny)
library(shinyjs)
library(shinythemes)
library(bslib)
library(glue)
library(jsonlite)
library(htmltools)
library(reactable)
library(magrittr)
source(file.path("data", "oracle.R"), local=TRUE)

theme <- bs_theme(version=4,
    bg = "#EFEFEF", fg = "#171c28", primary = "#2f3b54", 
    secondary = "#6679a4", success = "#bae67e", info = "#5ccfe6", 
    warning = "#ffae57", danger = "#ef6b73", base_font = font_google("Source Code Pro"), 
    code_font = font_google("Roboto Mono"), `enable-rounded` = TRUE, 
    spacer = "0.5rem", bootswatch = "pulse")

ui <- navbarPage(
    theme = theme,
    title="hypeR",
    source(file.path("ui", "01_signature.R"), local=TRUE)$value,
    source(file.path("ui", "02_genesets.R"), local=TRUE)$value,
    source(file.path("ui", "03_enrichment.R"), local=TRUE)$value
)

server <- function(input, output, session) {
    source(file.path("server", "01_signature.R"), local=TRUE)$value
    source(file.path("server", "02_genesets.R"), local=TRUE)$value
    source(file.path("server", "03_enrichment.R"), local=TRUE)$value   
}

DEV <- FALSE
opt <- list()
if (DEV) {
    opt <- list(shiny.autoreload=TRUE, launch.browser=TRUE)
}
shinyApp(ui=ui, server=server, options=opt)