/// https://github.com/openbsd/src/blob/master/include/link_elf.h
module core.sys.openbsd.sys.link_elf;

version (OpenBSD):
extern (C):
nothrow:
import core.sys.posix.sys.types;
public import core.sys.openbsd.sys.exec_elf;

template ElfW(string type) // Needed in rt.
{
    mixin("alias Elf"~__ELF_NATIVE_CLASS.stringof~"_"~type~" ElfW;");
}

struct link_map
{
    caddr_t           l_addr;    /* Base address of library */
    const(char)*      l_name;    /* Absolute path to library */
    void*             l_ld;      /* pointer to _DYNAMIC */
    link_map*         l_next;
    link_map*         l_prev;
}

struct dl_phdr_info
{
    Elf_Addr           dlpi_addr;
    const(char)*       dlpi_name;
    const(Elf_Phdr)*   dlpi_phdr;
    Elf_Half           dlpi_phnum;
}

private alias int function(dl_phdr_info*, size_t, void *) dl_iterate_phdr_cb;
private alias int function(dl_phdr_info*, size_t, void *) @nogc dl_iterate_phdr_cb_ngc;

extern int dl_iterate_phdr(dl_iterate_phdr_cb __callback, void*__data);
extern int dl_iterate_phdr(dl_iterate_phdr_cb_ngc __callback, void*__data) @nogc;
void* dl_unwind_find_exidx(const void*, int) @nogc;
