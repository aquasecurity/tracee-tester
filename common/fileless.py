import ctypes, os, platform

if platform.machine() == 'x86_64':
    sys_memfd_create = 319
elif platform.machine() == 'aarch64':
    sys_memfd_create = 279
else:
    raise Exception('Unsupported architecture')

libc = ctypes.CDLL(None)
argv = ctypes.pointer((ctypes.c_char_p * 0)( * []))
syscall = libc.syscall
fexecve = libc.fexecve

print syscall
print fexecve

with open('/usr/bin/uname', 'rb') as f:
    content = f.read()

fd = syscall(sys_memfd_create, "", 0)
os.write(fd, content)

fexecve(fd, argv, argv)
