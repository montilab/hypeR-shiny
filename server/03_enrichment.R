reactive_enrichment <- eventReactive(input$enrichment_do, {
    data <- oracle.data()
    gsets <- genesets()

    lmhyp <- lapply(data, hypeR, gsets, 
      test="hypergeometric", 
      background=input$enrichment_bg, 
      fdr=input$enrichment_thresh,
      plotting=FALSE,
      quiet=TRUE)

    html <- div(class="container")
    for (experiment in names(lmhyp)) {
      div <- rctbl_build(lmhyp[[experiment]])
      html <- htmltools::tagAppendChild(html, div(tags$h5(glue("{experiment}"))))
      html <- htmltools::tagAppendChild(html, div)
      html <- htmltools::tagAppendChild(html, tags$br())
    }
    return(html)
})

output$enrichment <- renderUI({
  reactive_enrichment()
})