
library(giacR)
giac <- Giac$new()

equations <-
  "x = A*cost*cos3t - sint*sin3t, y = A*sint*cos3t + cost*sin3t, z = B*cos3t"
relations <- paste0(
  "A^2+B^2 = 1, cost^2 + sint^2 = 1, ",
  "cos3t = 4*cost^3-3*cost, sin3t = (4*cost^2-1)*sint, ",
  "cos3t^2 + sin3t^2 = 1"
)
variables <- "cost, sint, cos3t, sin3t"
constants <- "A, B"

command <-
  "gbasis([x - A*cost*cos3t + sint*sin3t, y - A*sint*cos3t - cost*sin3t, z - B*cos3t, cos3t - 4*cost^3+3*cost, sin3t - (4*cost^2-1)*sint, cost^2 + sint^2 - 1, A^2 + B^2 - 1], [x, y, z, A, B, cos3t, cost, sin3t, sint])"

command <-
  "gbasis([x - A*cost*(4*cost^3-3*cost) + sint*(4*cost^2-1)*sint, y - A*sint*(4*cost^3-3*cost) - cost*(4*cost^2-1)*sint, z - B*(4*cost^3-3*cost), cost^2 + sint^2 - 1, A^2 + B^2 - 1], [cost, sint, A, B, z, y, x], tdeg)"

giac$execute(command, timeout = 120000) -> result

strsplit(result, ",")[[1]]

command <-
  "gbasis([x - 3/5*cost*(4*cost^3-3*cost) + sint*(4*cost^2-1)*sint, y - 3/5*sint*(4*cost^3-3*cost) - cost*(4*cost^2-1)*sint, z - 4/5*(4*cost^3-3*cost), cost^2 + sint^2 - 1], [cost, sint, z, y, x])"

giac$execute(command) -> result

strsplit(result, ",")[[1]]

# equations <-
#   "x = A*cost*(cost^2 - sint^2) - sint*2*sint*cost, y = A*sint*(cost^2 - sint^2) + cost*2*sint*cost, z = B*(cost^2 - sint^2)"
# relations <-
#   "A^2 + B^2 = 1, cost^2 + sint^2 = 1"
# variables <- "cost, sint"
# constants <- "A, B"

equations <-
  "z = B*(4*cost^3-3*cost), y = A*sint*(4*cost^3-3*cost) + cost*(4*cost^2-1)*sint, x = A*cost*(4*cost^3-3*cost) - sint*(4*cost^2-1)*sint"
relations <- paste0(
  "cost^2 + sint^2 = 1, A^2 + B^2 = 1"
)
variables <- "cost, sint"
constants <- "A, B"

giac$implicitization(
  equations, relations, variables, constants, timeout = 120000
)



equations <-
  "x5 = x4*x1*(4*x1^3-3*x1) - x2*(4*x1^2-1)*x2, x6 = x4*x2*(4*x1^3-3*x1) + x1*(4*x1^2-1)*x2, x7 = x3*(4*x1^3-3*x1)"
relations <- paste0(
  "x1^2 + x2^2 = 1, x3^2 + x4^2 = 1"
)
variables <- "x1, x2"
constants <- "x3, x4"

giac$implicitization(
  equations, relations, variables, constants, timeout = 120000
)

equations <-
  "x = 3/5*cost*(4*cost^3-3*cost) - sint*(4*cost^2-1)*sint, y = 3/5*sint*(4*cost^3-3*cost) + cost*(4*cost^2-1)*sint, z = 4/5*(4*cost^3-3*cost)"
relations <- paste0(
  "cost^2 + sint^2 = 1"
)
variables <- "sint, cost"

giac$implicitization(
  equations, relations, variables, timeout = 120000
)


equations <-
  "x = A*cost*(4*cost^3-3*cost) - sint*(4*cost^2-1)*sint, y = A*sint*(4*cost^3-3*cost) + cost*(4*cost^2-1)*sint, z = B*(4*cost^3-3*cost)"
relations <- paste0(
  "A^2 + B^2 = 1, cost^2 + sint^2 = 1, cos3t^2 + sin3t^2 = 1"
)
variables <- "cost, sint"
constants <- "A, B"

giac$implicitization(
  equations, relations, variables, timeout = 120000
)



giac$close()


####

command <-
  "gbasis([x - A*cost*(4*cost^3-3*cost) + sint*(4*cost^2-1)*sint, y - A*sint*(4*cost^3-3*cost) - cost*(4*cost^2-1)*sint, z - B*(4*cost^3-3*cost), cost^2 + sint^2 - 1, A^2 + B^2 - 1], [cost, sint, A, B, x, y, z])"
command <- gsub("B", "b", gsub("A", "a", command))
result <- giac$execute(command, timeout = 120000)
strsplit(result, ",")[[1]]

command <- paste0(
  "gbasis([x - a*u*(4*u^3-3*u) + v*(4*u^2-1)*v, ",
  "y - a*v*(4*u^3-3*u) - u*(4*u^2-1)*v, ",
  "z - b*(4*u^3-3*u), u^2 + v^2 - 1, a^2 + b^2 - 1], ",
  "[v, u, x, y, z, a, b])"
)
result <- giac$execute(command, timeout = 120000)
length(strsplit(result, ",")[[1]])

command <- paste0(
  "gbasis([x - a*cost*(4*cost^3-3*cost) + sint*(4*cost^2-1)*sint, ",
   "y - a*sint*(4*cost^3-3*cost) - cost*(4*cost^2-1)*sint, ",
   "z - b*(4*cost^3-3*cost), cost^2 + sint^2 - 1, a^2 + b^2 - 1], ",
   "[cost, sint, x, y, z, a, b])"
)
result <- giac$execute(command, timeout = 120000)
length(strsplit(result, ",")[[1]])
# 29

command <- paste0(
  "gbasis([x - a*cost*(4*cost^3-3*cost) + sint*(4*cost^2-1)*sint, ",
  "y - a*sint*(4*cost^3-3*cost) - cost*(4*cost^2-1)*sint, ",
  "z - b*(4*cost^3-3*cost), cost^2 + sint^2 - 1, a^2 + b^2 - 1], ",
  "[cost, sint, x, y, z, b, a])"
)
result <- giac$execute(command, timeout = 120000)
length(strsplit(result, ",")[[1]])
# 32

command <- paste0(
  "gbasis([u - a*x1*(4*x1^3-3*x1) + x*(4*x1^2-1)*x, ",
  "v - a*x*(4*x1^3-3*x1) - x1*(4*x1^2-1)*x, ",
  "w - b*(4*x1^3-3*x1), x1^2 + x^2 - 1, a^2 + b^2 - 1], ",
  "[x1, x, w, v, u, b, a])"
)
result <- giac$execute(command, timeout = 120000)
length(strsplit(result, ",")[[1]])
grepl("x", strsplit(result, ",")[[1]])
grepl("y", strsplit(result, ",")[[1]])


command <-
  "gbasis([x7 - x3*x1*(4*x1^3-3*x1) + x2*(4*x1^2-1)*x2, x6 - x3*x2*(4*x1^3-3*x1) - x1*(4*x1^2-1)*x2, x5 - x4*(4*x1^3-3*x1), x1^2 + x2^2 - 1, x3^2 + x4^2 - 1], [x7, x6, x5, x4, x3, x2, x1])"
result <- giac$execute(command, timeout = 120000)
length(strsplit(result, ",")[[1]])
grepl("x1", strsplit(result, ",")[[1]])
grepl("x2", strsplit(result, ",")[[1]])


command <-
  "gbasis([y1 - y5*y7*(4*y7^3-3*y7) + (4*y7^2-1)*y6^2, y2 - y5*y6*(4*y7^3-3*y7) - y7*(4*y7^2-1)*y6, y3 - y4*(4*y7^3-3*y7), y7^2 + y6^2 - 1, y5-5/13, y4-12/13], [y7, y6, y5, y4, y3, y2, y1])"
result <- giac$execute(command, timeout = 120000)
length(strsplit(result, ",")[[1]])
grepl("y6", strsplit(result, ",")[[1]])
grepl("y7", strsplit(result, ",")[[1]])

