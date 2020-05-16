import system, os, osproc, strutils, sequtils, sugar

import ../path

proc listRepo (repoPath: string): seq[string] =
  execProcess("ls | grep '.git'", repoPath)
    .split(".git\n")
    .filter(x => x != "")

proc list* (argc: int; arg: seq[string]): int {.discardable.} =
  let repoPath = path.toRepo
  echo "Repo: " & repoPath
  for repoName in listRepo(repoPath):
    echo "  " & repoName
  return 0
