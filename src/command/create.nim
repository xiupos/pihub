import system, os, osproc, streams

import ../path

# create repo.git
proc createRepo (repo: string): int {.discardable.} =
  echo "Repo: " & repo
  createDir repo
  discard execProcess("git init --bare", repo)
  return 0

# create prod
proc createProd (repo, prod: string): int {.discardable.} =
  echo "Prod: " & prod
  createDir prod
  discard execProcess("git clone " & repo & " .", prod)
  return 0

# create repo.git/.pihub
proc createDotPihub (repo, prod: string): int {.discardable.} =
  let dotPihubPath = repo / ".pihub"
  var dotPihub = newFileStream(dotPihubPath, fmWrite)
  dotPihub.writeLine prod
  dotPihub.close
  return 0

# create repo.git/hooks/post-receive
proc createHooks (repo, prod: string): int {.discardable.} =
  let
    hooksPath = repo / "hooks"
    postReceivePath = hooksPath / "post-receive"
  var postReceive = newFileStream(postReceivePath, fmWrite)
  postReceive.writeLine "#!/bin/sh"
  postReceive.writeLine ""
  postReceive.writeLine "cd " & prod
  postReceive.writeLine "git --git-dir=.git pull"
  postReceive.writeLine "docker-compose build"
  postReceive.writeLine "docker-compose pull"
  postReceive.writeLine "docker-compose up -d"
  postReceive.close
  discard execProcess "chmod +x " & postReceivePath
  return 0

# init repo.git
proc initRepo (repo, prod: string): int {.discardable.} =
  createDotPihub repo, prod
  createHooks repo, prod
  return 0

# TODO: bareな.git内にpihub.ymlを追加, prodPathをそこで保存する.
proc create* (argc: int; arg: seq[string]): int {.discardable.} =
  let
    repoName = arg[1]
    prodName = arg[1]
    repo = path.toRepo / repoName & ".git"
    prod = if argc > 2: arg[2] / prodName else: path.toProd / prodName

  createRepo repo
  createProd repo, prod
  initRepo repo, prod

  return 0
