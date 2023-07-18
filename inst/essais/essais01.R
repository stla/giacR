library(giacR)
giac <- Giac$new(Sys.which("chrome"))

giac$execute("det([[1, 2, 3], [3/4, a, b], [c, 4, 5]])")


giac$close()
