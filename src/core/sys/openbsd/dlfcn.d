/**
 * D header file for OpenBSD.
 *
 * https://github.com/openbsd/src/blob/master/include/dlfcn.h
 */
module core.sys.openbsd.dlfcn;

public import core.sys.posix.dlfcn;

version (OpenBSD):
extern (C):
nothrow:

static assert(RTLD_LAZY   == 1);
static assert(RTLD_NOW    == 2);
static assert(RTLD_GLOBAL == 0x100);
static assert(RTLD_LOCAL  == 0);
enum RTLD_TRACE           =  0x200;

enum RTLD_NEXT    = cast(void *)-1;
enum RTLD_DEFAULT = cast(void *)-2;
enum RTLD_SELF    = cast(void *)-3;

enum DL_GETERRNO     = 1;
enum DL_SETTHREADLCK = 2;
enum DL_SETBINDLCK   = 3;
enum DL_REFERENCE    = 4;

enum DL_LAZY         = RTLD_LAZY;

int dlctl(void*, int, void*);
