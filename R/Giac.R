#' @title R6 class to access to Giac
#'
#' @description Creates an object allowing to execute Giac commands.
#'
#' @export
#' @importFrom R6 R6Class
#' @import chromote
Giac <- R6Class(
  "Giac",

  cloneable = FALSE,

  private = list(
    "session" = NULL
  ),

  public = list(

    #' @description Create a new \code{Giac} instance.
    #' @param chromePath path to the Chrome executable (or Chromium, Brave,
    #'   etc); if \code{find_chrome()} does not work, you can set the
    #'   environment variable \code{CHROMOTE_CHROME} to the path and it will
    #'   work
    #' @return A \code{Giac} object.
    "initialize" = function(chromePath = find_chrome()) {
      if(is.null(chromePath)) {
        stop("Set the path to a Chrome executable.")
      }
      chrm <- Chrome$new(
        path = chromePath,
        args = "--disable-gpu --headless --remote-debugging-port=9222"
      )
      chromote <- Chromote$new(browser = chrm)
      session  <- ChromoteSession$new(parent = chromote)
      ids <- session$Page$navigate("about:blank")
      jsfile <- system.file("giacwasm.js", package = "giacR")
      script <- paste0(readLines(jsfile), collapse = "\n")
      . <- session$Runtime$evaluate(script)
      . <- session$Runtime$evaluate("
var UI = {
  Datestart: Date.now(),
  ready: false,
  warnpy: false
};
Module.onRuntimeInitialized = function() {
  UI.ready = true;
;};
")
      . <- session$Runtime$evaluate(
        "var docaseval = Module.cwrap('caseval', 'string', ['string']);"
      )
      ready <- session$Runtime$evaluate("UI.ready")$result$value
      while(!ready) {
        ready <- session$Runtime$evaluate("UI.ready")$result$value
      }
      private[["session"]] <- session
    },


    #' @description Execute a Giac command.
    #' @param command the command to be executed given as a character string
    #' @return The result of the command in a character string.
    #'
    #' @examples
    #' if(!is.null(find_chrome)) {
    #'   giac <- Giac$new()
    #'   giac$execute("2 + 3/7")
    #'   giac$close()
    #' }
    "execute" = function(command) {
      evaluate <- private[["session"]]$Runtime$evaluate(
        sprintf("docaseval('%s')", command)
      )
      if(evaluate[["result"]][["type"]] != "string") {
        stop("An error occured.")
      }
      evaluate[["result"]][["value"]]
    },


    #' @description Close a Giac session
    #' @return \code{TRUE} or \code{FALSE}, whether the session has been closed.
    "close" = function() {
      private[["session"]]$close()
    }

  )
)
