library(giacR)

giac <- Giac$new(Sys.which("chrome"))


giac$execute(
  "apply(simplify, solve([x^2+y+z=1, x+y^2+z=1, x+y+z^2=1], [x, y, z]))"
)

giac$close()
