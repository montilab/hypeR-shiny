tabPanel("[3] Enrichment",
  includeCSS("www/reactable.css"),
  fluidRow(
    column(2,
      numericInput("enrichment_thresh", "Threshold", 0.05),
      numericInput("enrichment_bg", "Background", 36000),
      actionButton("enrichment_do", "Do Enrichment")
    ),
    column(10,
      uiOutput("enrichment")
    )
  )
)