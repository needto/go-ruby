package main

// #include <stdlib.h>
import "C"

import (
  "fmt"
)

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}

//export reverseString
func reverseString(input *C.char) *C.char {
  // converts passed string pointer to go string
  stringToReverse := C.GoString(input)
  fmt.Printf("Go says: reversing string %s\n", stringToReverse)

  // converts Go string to a C string
  reversedCString := C.CString(reverse(stringToReverse))
  return reversedCString
}

func main() {
  // to test with go run main.go
  fmt.Printf("Reversing string in Go: %s\n", reverse("Hello!"))
}
