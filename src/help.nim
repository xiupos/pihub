proc version* () {.discardable.} =
  echo "PiHub v0.2.0"

proc help* () {.discardable.} =
  echo "\nUsage:  pihub COMMAND [repo_name]\n"
  echo "Command:"
  echo "  list     List repositories"
  echo "  create   Create new repository"
  echo "  delete   Delete repository"
