proc error* (errorMessage: string): int {.discardable.} =
  echo errorMessage
  return 1
