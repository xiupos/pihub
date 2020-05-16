import system, os, streams

const
  repoPathEnv = "REPO_PATH"
  prodPathEnv = "PROD_PATH"

let
  defaultRepoPath = getEnv("HOME")
  defaultProdPath = getEnv("HOME") / "prod"
  toRepo* = getEnv(repoPathEnv, defaultRepoPath)
  toProd* = getEnv(prodPathEnv, defaultProdPath)

proc getProdPath* (repoName: string): string =
  let
    repo = toRepo / repoName & ".git"
    dotPihubPath = repo / ".pihub"
  var  dotPihub = newFileStream dotPihubPath
  result = dotPihub.readLine
  dotPihub.close
