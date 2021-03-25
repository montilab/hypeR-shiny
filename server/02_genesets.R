genesets <- hypeR::genesets_Server("genesets", clean=TRUE)

output$table <- renderUI({
    gsets <- genesets()
    
    df <- data.frame(Geneset=names(gsets), Symbols=sapply(gsets, function(x) paste(head(x,5), collapse=",")))
    tbl <- reactable(df,
                     rownames=FALSE,
                     compact=TRUE, 
                     fullWidth=TRUE,
                     defaultPageSize=20,
                     defaultColDef=colDef(headerClass="rctbl-header"),
                     style=list(backgroundColor="#EFEFEF"),
                     showPageSizeOptions=TRUE,
                     rowStyle=list(cursor="pointer"))
    
    dat <- htmltools::div(class="rctbl-obj-teeny", tbl)
    return(dat)
})