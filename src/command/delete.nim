import system, os, osproc

import ../path

# delete repo.git
proc deleteRepo (repo: string): int {.discardable.} =
  echo "Repo: " & repo
  removeDir repo
  return 0

# delete prod
proc deleteProd (repo, prod: string): int {.discardable.} =
  echo "Prod: " & prod
  discard execProcess("docker-compose down --rmi all", prod)
  removeDir prod
  return 0

proc delete* (argc: int; arg: seq[string]): int {.discardable.} =
  let
    repoName = arg[1]
    repo = path.toRepo / repoName & ".git"
    prod = getProdPath repoName

  deleteRepo repo
  deleteProd repo, prod

  return 0
