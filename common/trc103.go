package main

import (
	"syscall"
)

func main() {
	// Check PtracePokeText implementation for more details
	addr := uintptr(1 << 32) // addr%sizeofPtr == 0
	data := []byte{          // len(data) > sizeofPtr
		0xca, 0xfe, 0xba, 0xbe,
		0xde, 0xad, 0xc0, 0xde,
		0xed,
	}

	// As this is using own pid with a request different of PTRACE_TRACEME,
	// it is a useless call which only triggers the detection of the TRC-103.
	_, _ = syscall.PtracePokeText(syscall.Getpid(), addr, data)
}
