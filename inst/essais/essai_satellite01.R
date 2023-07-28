
library(giacR)
giac <- Giac$new()

equations <-
  "x = A*cost*cos2t - sint*sin2t, y = A*sint*cos2t + cost*sin2t, z = B*cos2t"
relations <-
  "A^2 + B^2 = 1, cost^2 + sint^2 = 1, cos2t = cost^2 - sint^2, sin2t = 2*sint*cost"
variables <- "cost, sint, cos2t, sin2t"
constants <- "A, B"

command <-
  "gbasis([x - A*cost*cos2t + sint*sin2t, y - A*sint*cos2t - cost*sin2t, z - B*cos2t, A^2 + B^2 - 1, cost^2 + sint^2 - 1, cos2t - cost^2 + sint^2, sin2t - 2*sint*cost], [x, y, z, A, B, cost, sint, cos2t, sin2t])"

# equations <-
#   "x = A*cost*(cost^2 - sint^2) - sint*2*sint*cost, y = A*sint*(cost^2 - sint^2) + cost*2*sint*cost, z = B*(cost^2 - sint^2)"
# relations <-
#   "A^2 + B^2 = 1, cost^2 + sint^2 = 1"
# variables <- "cost, sint"
# constants <- "A, B"


giac$implicitization(
  equations, relations, variables, constants, timeout = 120000
)

giac$close()
