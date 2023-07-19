library(giacR)

equations <-
  "x = 3*u + 3*u*v^2 - u^3, y = 3*v + 3*u^2*v - v^3, z = 3*u^2 - 3*v^2"
variables <- "u, v"

giac <- Giac$new(Sys.which("chrome"))

giac$implicitization(equations = equations, variables = variables)



giac$close()

equations <-
  "x = 3*u + 3*u*v^2 - u^3, y = 3*v + 3*u^2*v - v^3, z = 3*u^2 - 3*v^2"
variables <- "u, v"
constants <- relations <- ""

if(nchar(trimws(constants)) > 0L) {
  symbols <- paste0(variables, ", ", constants)
} else{
  symbols <- variables
}
relations  <- trimws(strsplit(relations, ",")[[1L]])
relations  <- vapply(relations, subtraction, character(1L))
equations  <- trimws(strsplit(equations, ",")[[1L]])
#generators <- paste0(c(relations, equations), collapse = ", ")
coordinates <- toString(vapply(equations, function(eq) {
  trimws(strsplit(eq, "=")[[1L]][1L])
}, character(1L)))
#symbols <- paste0(coordinates, ", ", symbols)
equations  <- paste0(
  vapply(equations, giacR:::subtraction, character(1L)), collapse = ", "
)
equations <- paste0(c(relations, equations), collapse  = ", ")

symbols <- paste0(symbols, ", ", coordinates)
body <- paste0("[", equations, "], [", symbols, "]")
command <- sprintf("gbasis(%s, plex)", body)
gbasis <- giac$execute(command)
gbasis

variables <- trimws(strsplit(variables, ",")[[1L]])
command <- paste0(
  "apply(expr -> ", paste0(vapply(variables, function(s) {
    sprintf("has(expr, %s)==0", s)
  }, character(1L)),
  collapse = " and "), ", ", gbasis, ")")
free <- jsonlite::fromJSON(giac$execute(command))
gbasis <- strsplit(sub("\\]$", "", sub("^\\[", "", gbasis)), ",")[[1L]]
gbasis[free]
