require 'ffi'

module GoExample
  module LibC
    extend FFI::Library
    ffi_lib FFI::Library::LIBC
    attach_function :free, [:pointer], :void
  end

  extend FFI::Library
  ffi_lib File.expand_path("./mylib.so", File.dirname(__FILE__))

  # use :blocking => true to allow MRI to switch threads
  attach_function :reverseString, [:string], :strptr, :blocking => true

  def self.reverse_string(string)
    result, ptr = reverseString(string)
    # release C-land memory allocated by Go when you no longer need it
    LibC.free(ptr)
    result
  end
end

# ffi deals with the C memory passed to go by itself
puts GoExample.reverse_string("Reversed!")
