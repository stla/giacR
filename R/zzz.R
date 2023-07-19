#' @importFrom pingr is_online
#' @importFrom pingr is_up
NULL

.onLoad <- function(libname, pkgname) {

  has_internet  <- pingr::is_online()
  fourier_is_up <- pingr::is_up("www-fourier.univ-grenoble-alpes.fr")
  no_giac       <- !.giac_is_installed()

  if(no_giac && (!has_internet || !fourier_is_up)) {
    message(
      "Giac is not installed and there's no internet connection or the ",
      "website is not reachable."
    )
  }

  if(fourier_is_up && no_giac) {
    message("Downloading Giac.")
    .giac_download()
  }

}
