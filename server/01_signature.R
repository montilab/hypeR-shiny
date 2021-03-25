get.delim <- function(text) {
    delims <- c(",", "\t", "\t| +", ";", " ")
    for (sep in delims) {
        if (grepl(sep, text, fixed=TRUE)) {
            return(sep)
        }
    }
    return(delims[[1]])
}

# Adding signatures
observeEvent(input$signature_add, {
    data <- oracle.data()

    sep <- get.delim(input$signature)
    signature <- input$signature %>%
                 stringr::str_split(pattern=sep, simplify=TRUE) %>%
                 as.vector()
    
    experiment_label <- input$experiment_label
    signature_label <- input$signature_label

    if (!(experiment_label %in% names(data))) {
      data[[experiment_label]] <- list()
    }
    data[[experiment_label]][[signature_label]] <- signature

    oracle$data <- data
})

# Deleting signatures
observeEvent(input$jsValue, {
    data <- oracle.data()
    message <- jsonlite::fromJSON(input$jsValue)
    type <- message$type
    experiment <- message$experiment
    signature <- message$signature
    if (type == "signature") {
      data[[experiment]][[signature]] <- NULL
      if (length(data[[experiment]]) == 0) {
        data[[experiment]] <- NULL
      }
    }
    oracle$data <- data
})

# Js magic
output$data_preview <- renderUI({
    data <- oracle.data()
    e <- 1

    # Outer container
    html_outer <- div(class="container")

    for (experiment_label in names(data)) {
      experiment <- data[[experiment_label]]

      # Collabsible experiment container
      html_inner <- div(class="container", id="id_1")
      collapse <- div(class="btn btn-primary btn-sm", 
                      role="button",
                     `data-toggle`="collapse", 
                     `data-target`=glue("#e{e}"), "▼")
      html_inner <- htmltools::tagAppendChild(html_inner, collapse)
      header <- div(class="h5", style="display: inline-block;", experiment_label)
      html_inner <- htmltools::tagAppendChild(html_inner, header)

      # Deletable signatures within an experiment
      content <- div(class="collapse show", id=glue("e{e}"))
      content <- htmltools::tagAppendChild(content, tags$br())
      for (signature_label in names(experiment)) {
        signature <- experiment[[signature_label]]
        if (length(signature) > 10) {
          signature <- signature[1:10]
        }
        delete <- div(class="btn btn-danger btn-sm btn-circle",
                      onClick="invoke(this)",
                      `data-type`="signature",
                      `data-experiment`=glue("{experiment_label}"),
                      `data-signature`=glue("{signature_label}"),
                      "x")

        signature_preview <- div(delete, tags$b(signature_label), tags$p(HTML(paste0(signature))))
        content <- htmltools::tagAppendChild(content, signature_preview)
      }

      html_inner <- htmltools::tagAppendChild(html_inner, content)
      html_outer <- htmltools::tagAppendChild(html_outer, html_inner)
      html_outer <- htmltools::tagAppendChild(html_outer, tags$br())
      e <- e+1 # Increment experiment number
    }
    return(html_outer)
})
