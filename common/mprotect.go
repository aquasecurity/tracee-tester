package main

import (
	"syscall"
)

func main() {
	// alert = ALERT_MPROT_W_REM
	// Protection changed from W+E to E!

	length := uintptr(syscall.Getpagesize())

	// Allocate page with PROT_READ, PROT_WRITE and PROT_EXEC
	addr, _, errno := syscall.Syscall6(syscall.SYS_MMAP,
		0, // let the kernel choose an aligned address
		length,
		syscall.PROT_READ|syscall.PROT_WRITE|syscall.PROT_EXEC,
		syscall.MAP_PRIVATE|syscall.MAP_ANONYMOUS,
		0, // fd, ignored
		0, // offset, ignored
	)
	if errno != 0 {
		panic(errno.Error())
	}

	// Change page protection to PROT_READ | PROT_EXEC
	_, _, errno = syscall.Syscall(syscall.SYS_MPROTECT,
		addr,
		length,
		syscall.PROT_READ|syscall.PROT_EXEC,
	)
	if errno != 0 {
		panic(errno.Error())
	}
}
