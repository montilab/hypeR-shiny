tabPanel("[2] Genesets",
  includeCSS("www/reactable.css"),
  fluidRow(
    column(4,
      hypeR::genesets_UI("genesets")
    ),
    column(8,
      uiOutput("table"),
    )
  )
)