library(giacR)
giac <- Giac$new(Sys.which("chrome"))

giac$execute("det([[1, 2, 3], [3/4, a, b], [c, 4, 5]])")

giac$execute(
  "apply(expr -> has(expr, u)==0 and has(expr, v)==0, [x^2 + u, y^2 + v])"
)

equations <- "x = a*cost, y = b*sint"
relations <- "cost^2 + sint^2 = 1"
variables <- "cost, sint"
constants <- "a, b"

symbols <- paste0(variables, ", ", constants)
relations  <- trimws(strsplit(relations, ",")[[1L]])
relations  <- vapply(relations, subtraction, character(1L))
equations  <- trimws(strsplit(equations, ",")[[1L]])
generators <- paste0(c(relations, equations), collapse = ", ")
coordinates <- toString(vapply(equations, function(eq) {
  trimws(strsplit(eq, "=")[[1L]][1L])
}, character(1L)))
symbols <- paste0(symbols, ", ", coordinates)
equations  <- paste0(
  vapply(equations, subtraction, character(1L)), collapse = ", "
)
equations <- paste0(relations, ", ", equations)
body <- paste0("[", equations, "], [", symbols, "]")
command <- sprintf("gbasis(%s)", body)

gbasis <- giac$execute(command)

#exprs   <- "[x^2 + u, y^2 + v]"
variables <- trimws(strsplit(variables, ",")[[1L]])
command <- paste0("apply(expr -> ", paste0(vapply(variables, function(s) {
  sprintf("has(expr, %s)==0", s)
}, character(1L)), collapse = " and "), ", ", gbasis, ")")
free <- jsonlite::fromJSON(giac$execute(command))
gbasis <- strsplit(sub("\\]$", "", sub("^\\[", "", gbasis)), ",")[[1L]]
free
gbasis[free]




giac$close()

