require 'ffi'

module GoExample
  module LibC
    extend FFI::Library
    ffi_lib FFI::Library::LIBC
    attach_function :free, [:pointer], :void
  end

  extend FFI::Library
  ffi_lib File.expand_path("./mylib.so", File.dirname(__FILE__))
  attach_function :reverseString, [:string], :strptr, :blocking => true

  def self.reverse_string(string)
    result, ptr = reverseString(string)
    LibC.free(ptr)
    result
  end
end

puts GoExample.reverse_string("Reversed!")
