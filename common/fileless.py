import ctypes, os, platform, subprocess

if platform.machine() == 'x86_64':
    sys_memfd_create = 319
elif platform.machine() == 'aarch64':
    sys_memfd_create = 279
else:
    raise Exception('Unsupported architecture')

MFD_CLOEXEC = 1

# get absolute path for binary
binary = 'uname'
try:
    output = subprocess.check_output(["which", binary])
    binary = output.decode().strip()
except Exception as e:
    raise e

print binary

# load binary content
with open(binary, 'rb') as f:
    content = f.read()

libc = ctypes.CDLL(None)
argv = ctypes.pointer((ctypes.c_char_p * 0)( * []))
syscall = libc.syscall
fexecve = libc.fexecve

print syscall
print fexecve

# create memory file descriptor and write binary content to it
fd = syscall(sys_memfd_create, '', MFD_CLOEXEC)
os.write(fd, content)

# execute binary from memory
fexecve(fd, argv, argv)
