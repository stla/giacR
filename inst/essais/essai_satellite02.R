
library(giacR)
giac <- Giac$new()

equations <-
  "x = A*cost*cos3t - sint*sin3t, y = A*sint*cos3t + cost*sin3t, z = B*cos3t"
relations <- paste0(
  "A^2 + B^2 = 1, cost^2 + sint^2 = 1, ",
  "cos3t = 4*cost^3-3*cost, sin3t = (4*cost^2-1)*sint"
)
variables <- "cost, sint, cos3t, sin3t"
constants <- "A, B"

command <-
  "gbasis([x - A*cost*cos3t + sint*sin3t, y - A*sint*cos3t - cost*sin3t, z - B*cos3t, cos3t - 4*cost^3+3*cost, sin3t - (4*cost^2-1)*sint, cost^2 + sint^2 - 1, A^2 + B^2 - 1], [x, y, z, A, B, cos3t, cost, sin3t, sint])"

command <-
  "gbasis([x - A*cost*(4*cost^3-3*cost) + sint*(4*cost^2-1)*sint, y - A*sint*(4*cost^3-3*cost) - cost*(4*cost^2-1)*sint, z - B*(4*cost^3-3*cost), cost^2 + sint^2 - 1, A^2 + B^2 - 1], [cost, sint, A, B, z, y, x], with_cocoa=true)"

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
  "z = A*cost*(4*cost^3-3*cost) - sint*(4*cost^2-1)*sint, y = A*sint*(4*cost^3-3*cost) + cost*(4*cost^2-1)*sint, x = B*(4*cost^3-3*cost)"
relations <- paste0(
  "cost^2 + sint^2 = 1, A^2 + B^2 = 1"
)
variables <- "cost, sint"
constants <- "A, B"

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

giac$close()
