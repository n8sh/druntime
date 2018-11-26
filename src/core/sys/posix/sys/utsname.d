
// Interface to <sys/utsname.h>

module core.sys.posix.sys.utsname;

version (OSX)
    version = Darwin;
else version (iOS)
    version = Darwin;
else version (TVOS)
    version = Darwin;
else version (WatchOS)
    version = Darwin;

version (Posix):
extern(C):
nothrow:
@nogc:

version (CRuntime_Glibc)
{
    private enum utsNameLength = 65;

    struct utsname
    {
        char[utsNameLength] sysname;
        char[utsNameLength] nodename;
        char[utsNameLength] release;
        char[utsNameLength] version_;
        // TODO Deprecate after version_ has been in an official release.
        alias update = version_;
        char[utsNameLength] machine;

        char[utsNameLength] __domainname;
    }

    int uname(utsname* __name);
}
else version (Darwin)
{
    private enum utsNameLength = 256;

    struct utsname
    {
        char[utsNameLength] sysname;
        char[utsNameLength] nodename;
        char[utsNameLength] release;
        char[utsNameLength] version_;
        // TODO Deprecate after version_ has been in an official release.
        alias update = version_;
        char[utsNameLength] machine;
    }

    int uname(utsname* __name);
}
else version (FreeBSD)
{
    //private enum SYS_NMLN = 32;       // old FreeBSD 1.1 ABI
    private enum SYS_NMLN = 256;

    struct utsname
    {
        char[SYS_NMLN] sysname;
        char[SYS_NMLN] nodename;
        char[SYS_NMLN] release;
        char[SYS_NMLN] version_;
        // TODO Deprecate after version_ has been in an official release.
        alias update = version_;
        char[SYS_NMLN] machine;
    }

    int __xuname(int, void*);
    int uname()(utsname* __name) { return __xuname(SYS_NMLN, cast(void*) __name); }
}
else version (NetBSD)
{
    private enum utsNameLength = 256;

    struct utsname
    {
        char[utsNameLength] sysname;
        char[utsNameLength] nodename;
        char[utsNameLength] release;
        char[utsNameLength] version_;
        // TODO Deprecate after version_ has been in an official release.
        alias update = version_;
        char[utsNameLength] machine;
    }

    int uname(utsname* __name);
}
else version (OpenBSD)
{
    // https://github.com/openbsd/src/blob/master/sys/sys/utsname.h
    private enum SYS_NMLN = 256;

    struct utsname
    {
        char[SYS_NMLN] sysname  = 0;  /* Name of this OS. */
        char[SYS_NMLN] nodename = 0;  /* Name of this network node. */
        char[SYS_NMLN] release  = 0;  /* Release level. */
        char[SYS_NMLN] version_ = 0;  /* Version level. */
        // TODO Deprecate after version_ has been in an official release.
        alias update = version_;
        char[SYS_NMLN] machine  = 0;  /* Hardware type. */
    };
}
else version (DragonFlyBSD)
{
    private enum utsNameLength = 32;

    struct utsname
    {
        char[utsNameLength] sysname;
        char[utsNameLength] nodename;
        char[utsNameLength] release;
        char[utsNameLength] version_;
        // TODO Deprecate after version_ has been in an official release.
        alias update = version_;
        char[utsNameLength] machine;
    }

    int uname(utsname* __name);
}
else version (Solaris)
{
    private enum SYS_NMLN = 257;

    struct utsname
    {
        char[SYS_NMLN] sysname;
        char[SYS_NMLN] nodename;
        char[SYS_NMLN] release;
        // The field name is version but version is a keyword in D.
        char[SYS_NMLN] _version;
        char[SYS_NMLN] machine;
    }

    int uname(utsname* __name);
}
else version (CRuntime_Bionic)
{
    private enum SYS_NMLN = 65;

    struct utsname
    {
        char[SYS_NMLN] sysname;
        char[SYS_NMLN] nodename;
        char[SYS_NMLN] release;
        // The field name is version but version is a keyword in D.
        char[SYS_NMLN] _version;
        char[SYS_NMLN] machine;
        char[SYS_NMLN] domainname;
    }

    int uname(utsname*);
}
else version (CRuntime_Musl)
{
    private enum SYS_NMLN = 65;

    struct utsname
    {
        char[SYS_NMLN] sysname;
        char[SYS_NMLN] nodename;
        char[SYS_NMLN] release;
        char[SYS_NMLN] _version;
        char[SYS_NMLN] machine;
        char[SYS_NMLN] domainname;
    }

    int uname(utsname*);
}
else version (CRuntime_UClibc)
{
    private enum utsNameLength = 65;

    struct utsname
    {
        char[utsNameLength] sysname;
        char[utsNameLength] nodename;
        char[utsNameLength] release;
        char[utsNameLength] version_;
        char[utsNameLength] machine;
        char[utsNameLength] domainname;
    }

    int uname(utsname*);
}
else version (Haiku)
{
    // https://github.com/haiku/haiku/blob/master/headers/posix/sys/utsname.h
    private enum _SYS_NAMELEN = 32;

    struct utsname
    {
        char[_SYS_NAMELEN] sysname = 0;
        char[_SYS_NAMELEN] nodename = 0;
        char[_SYS_NAMELEN] release = 0;
        char[_SYS_NAMELEN] version_ = 0;
        // TODO Deprecate after version_ has been in an official release.
        alias update = version_;
        char[_SYS_NAMELEN] machine = 0;
    }
}
else
{
    static assert(false, "unsupported system");
}
