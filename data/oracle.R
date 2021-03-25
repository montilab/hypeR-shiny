# The oracle manages reactive data (server side)
oracle <- reactiveValues(
    data = list()
)
# Helper functions for communicating with the oracle
oracle.get <- function(x) {
    oracle[[x]]
}
oracle.data <- function() {
    oracle.get("data")
}
