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


body <-
  "[x - (3*u + 3*u*v^2 - u^3), y - (3*v + 3*u^2*v - v^3), z - (3*u^2 - 3*v^2)], [u, v, x, y, z]"
command <- sprintf("gbasis(%s, plex)", body)
giac$execute(command)
# "[-3*u^2+3*v^2+z,6*u*v^2-u*z+9*u-3*x,9*u*v*y-2*u*z^2+18*u*z-9*v^2*x-6*x*z,-4*u*v*z+3*u*y-3*v*x,-9*u*x-6*v^2*z+9*v*y-z^2+9*z,-27*u*y^2+8*u*z^3-72*u*z^2+36*v^2*x*z+27*v*x*y+24*x*z^2,-2*v^3-v*z-3*v+y,243*v^2*x^2-243*v^2*y^2-1296*v^2*z-108*v*y*z^2+324*v*y*z+108*x^2*z+648*x^2+135*y^2*z-648*y^2-4*z^4+48*z^3+108*z^2-1944*z,54*v^2*y*z+27*v*x^2-27*v*y^2+8*v*z^3+72*v*z^2-9*y*z^2-27*y*z,18*v^2*z^2+54*v^2*z-54*v*y*z-27*x^2+27*y^2+z^3-18*z^2+81*z,-2187*v*x^4-69984*v*x^2-8748*v*y^4*z+2187*v*y^4-648*v*y^2*z^4-3240*v*y^2*z^3+11664*v*y^2*z^2-139968*v*y^2*z+69984*v*y^2+192*v*z^6+3456*v*z^5+15552*v*z^4-20736*v*z^3-186624*v*z^2+729*x^4*y-5832*x^2*y^3+189*x^2*y*z^3+7047*x^2*y*z^2+23328*x^2*y*z-69984*x^2*y+5103*y^5+945*y^3*z^3-1215*y^3*z^2-5832*y^3*z+69984*y^3-8*y*z^6-288*y*z^5-216*y*z^4-5184*y*z^3-93312*y*z^2+279936*y*z,-4374*v*x^2*y-8748*v*y^3*z+4374*v*y^3-648*v*y*z^4-5184*v*y*z^3-17496*v*y*z^2+729*x^4-5832*x^2*y^2+189*x^2*z^3+2430*x^2*z^2-2187*x^2*z+5103*y^4+945*y^2*z^3-972*y^2*z^2+19683*y^2*z-8*z^6+72*z^5+648*z^4-5832*z^3,27*v*x^2*z+81*v*x^2+135*v*y^2*z-81*v*y^2+8*v*z^4+96*v*z^3+216*v*z^2+81*x^2*y-81*y^3-12*y*z^3-324*y*z,8748*v*y^3*z^2+648*v*y*z^5+5832*v*y*z^4+17496*v*y*z^3+17496*v*y*z^2-729*x^4*z-2187*x^4+5832*x^2*y^2*z+4374*x^2*y^2-189*x^2*z^4-2997*x^2*z^3-5103*x^2*z^2+6561*x^2*z-5103*y^4*z-2187*y^4-945*y^2*z^4+81*y^2*z^3-16767*y^2*z^2-6561*y^2*z+8*z^7-48*z^6-864*z^5+3888*z^4+17496*z^3,-19683*x^6+59049*x^4*y^2-10935*x^4*z^3-118098*x^4*z^2+59049*x^4*z-59049*x^2*y^4-56862*x^2*y^2*z^3-118098*x^2*y^2*z-1296*x^2*z^6-34992*x^2*z^5-174960*x^2*z^4+314928*x^2*z^3+19683*y^6-10935*y^4*z^3+118098*y^4*z^2+59049*y^4*z+1296*y^2*z^6-34992*y^2*z^5+174960*y^2*z^4+314928*y^2*z^3+64*z^9-10368*z^7+419904*z^5]"
command <- sprintf("gbasis(%s)", body)
giac$execute(command)
# "[8*z^5+729*u*x^3-1458*v*x^2*y+1458*u*x*y^2-729*v*y^3-135*x^2*z^2-2592*v*y*z^2+135*y^2*z^2-96*z^4-2025*x^2*z+7776*v*y*z+567*y^2*z-360*z^3+11664*u*x+3888*x^2-11664*v*y-3888*y^2+7776*z^2-23328*z,8*u*z^3-54*u*x^2+81*v*x*y-27*u*y^2-72*u*z^2+18*x*z^2+54*x*z,8*v*z^3+27*v*x^2-81*u*x*y+54*v*y^2+72*v*z^2-18*y*z^2+54*y*z,6*u*v^2-u*z+9*u-3*x,2*v^3+v*z+3*v-y,9*u*v*x-9*v^2*y-2*v*z^2-18*v*z+3*y*z,9*v^2*x-9*u*v*y+2*u*z^2-18*u*z+6*x*z,4*u*v*z+3*v*x-3*u*y,6*v^2*z+9*u*x-9*v*y+z^2-9*z,27*u*x*z+27*v*y*z+2*z^3+81*u*x+27*x^2-81*v*y-27*y^2-162*z,3*u^2-3*v^2-z]"
