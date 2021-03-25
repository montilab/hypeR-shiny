tabPanel("[1] Signature",
  includeCSS("www/style.css"),
  includeScript("www/helpers.js"),
  fluidRow(
    column(4,
      textInput("experiment_label", tags$b("Experiment Label"), placeholder="E.g. Knockout Experiment"),
      textInput("signature_label", tags$b("Signature Label"), placeholder="E.g. Downregulated Genes"),
      textAreaInput("signature", 
        label=tags$b("Signature"),
        rows=8,
        cols=120,
        placeholder="ACHE,ADGRG1,AMOT,CDK5R1,CRMP1,DPYSL2,ETS2,GLI1,HEY1,HEY2,UNC5C,VEGFA,VLDLR",
        resize="both"),
      actionButton("signature_add", "Add Signature")
    ),
    column(8,
      htmlOutput("data_preview"),
    )
  )
)