library(giacR)
giac <- Giac$new()

# gb = FullSimplify[
#   GroebnerBasis[{x == (r + (t + d Cos[a]) Cos[b]) Cos[c],
#     y == (r + (t + d Cos[a]) Cos[b]) Sin[c],
#     z == (t + d Cos[a]) Sin[b], w == d Sin[a],
#     Cos[c]^2 + Sin[c]^2 == 1, Cos[b]^2 + Sin[b]^2 == 1,
#     Cos[a]^2 + Sin[a]^2 == 1}, {x, y, z, w},
#     {Cos[c], Sin[c], Cos[b], Sin[b], Cos[a], Sin[a]}]]

equations <- "x = (1 + (5 + 10*CosA)*CosB)*CosC, y = (1 + (5 + 10*CosA)*CosB)*SinC, z = (5+10*CosA)*SinB, w = 10*SinA"
relations <- "CosA^2 + SinA^2 = 1, CosB^2 + SinB^2 = 1, CosC^2 + SinC^2 = 1"
variables <- "CosA, SinA, CosB, SinB, CosC, SinC"
constants <- ""

imp <- giac$implicitization(equations, relations, variables, constants)

# right-isoclinic rotation in 4D space
# xi is the angle of rotation
rotate4d <- function(alpha, beta, xi, vec){
  a <- cos(xi)
  b <- sin(alpha) * cos(beta) * sin(xi)
  c <- sin(alpha) * sin(beta) * sin(xi)
  d <- cos(alpha) * sin(xi)
  x <- vec[, 1L]; y <- vec[, 2L]; z <- vec[, 3L]; w <- vec[, 4L]
  cbind(
    a*x - b*y - c*z - d*w,
    a*y + b*x + c*w - d*z,
    a*z - b*w + c*x + d*y,
    a*w + b*z - c*y + d*x
  )
}

f <- function(xyz, w0, xi){
  rxyzw <- rotate4d(pi/4, pi/4, xi, cbind(xyz, w0))
  x <- rxyzw[, 1L]
  y <- rxyzw[, 2L]
  z <- rxyzw[, 3L]
  w <- rxyzw[, 4L]
  x^8+4*x^6*y^2+6*x^4*y^4+4*x^2*y^6+y^8+4*x^6*z^2+12*x^4*y^2*z^2+12*x^2*y^4*z^2+4*y^6*z^2+6*x^4*z^4+12*x^2*y^2*z^4+6*y^4*z^4+4*x^2*z^6+4*y^2*z^6+z^8+4*x^6*w^2+12*x^4*y^2*w^2+12*x^2*y^4*w^2+4*y^6*w^2+12*x^4*z^2*w^2+24*x^2*y^2*z^2*w^2+12*y^4*z^2*w^2+12*x^2*z^4*w^2+12*y^2*z^4*w^2+4*z^6*w^2+6*x^4*w^4+12*x^2*y^2*w^4+6*y^4*w^4+12*x^2*z^2*w^4+12*y^2*z^2*w^4+6*z^4*w^4+4*x^2*w^6+4*y^2*w^6+4*z^2*w^6+w^8-504*x^6-1512*x^4*y^2-1512*x^2*y^4-504*y^6-1504*x^4*z^2-3008*x^2*y^2*z^2-1504*y^4*z^2-1496*x^2*z^4-1496*y^2*z^4-496*z^6-1304*x^4*w^2-2608*x^2*y^2*w^2-1304*y^4*w^2-2592*x^2*z^2*w^2-2592*y^2*z^2*w^2-1288*z^4*w^2-1096*x^2*w^4-1096*y^2*w^4-1088*z^2*w^4-296*w^6+74256*x^4+148512*x^2*y^2+74256*y^4+146496*x^2*z^2+146496*y^2*z^2+72256*z^4+97696*x^2*w^2+97696*y^2*w^2+94912*z^2*w^2+32656*w^4-2869504*x^2-2869504*y^2-2666496*z^2-1591296*w^2+28901376
}

# make grid ####
n <- 150L
x <- seq(-16, 16, len = n)
y <- seq(-16, 16, len = n)
z <- seq(-16, 16, len = n)
Grid <- expand.grid(X = x, Y = y, Z = z)

# run the marching cubes ####
library(rmarchingcubes)
voxel <- array(f(Grid, w0 = 5, xi = 2*pi/3), dim = c(n, n, n))
cont <- contour3d(voxel, level = 0, x = x, y = y, z = z)

# plot ####
library(rgl)
mesh <- tmesh3d(
  vertices = t(cont[["vertices"]]),
  indices  = t(cont[["triangles"]]),
  normals  = cont[["normals"]],
  homogeneous = FALSE
)
open3d(windowRect = c(50, 50, 562, 562), zoom = 0.8)
shade3d(mesh, color = "maroon", alpha = 0.3)



giac$close()


