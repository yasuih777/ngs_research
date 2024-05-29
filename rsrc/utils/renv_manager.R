args <- commandArgs(trailingOnly=TRUE)

if (args[1] == "status") {
  renv::status()
} else if (args[1] == "snapshot") {
  renv::snapshot()
} else if (args[1] == "restore") {
  renv::restore()
} else if (args[1] == "clean") {
  renv::clean()
} else {
  print("Undefined command")
}
