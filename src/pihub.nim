import system, os

import help, error
import command/create
import command/delete
import command/list

let
  argc = paramCount()
  argv = commandLineParams()

if isMainModule:
  if argc == 0: help()
  else:
    case argv[0]
    of "create":
      system.programResult = create(argc, argv)

    of "delete":
      system.programResult = delete(argc, argv)

    of "list":
      system.programResult = list(argc, argv)

    of "help", "-h", "--help":
      help()
      system.programResult = 0

    of "version", "-v", "--version":
      version()
      system.programResult = 0

    else:
      system.programResult = error "Invalid command: " & argv[0]
