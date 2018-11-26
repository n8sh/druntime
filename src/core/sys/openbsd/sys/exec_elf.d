/// https://raw.githubusercontent.com/openbsd/src/master/sys/sys/exec_elf.h
module core.sys.openbsd.sys.exec_elf;

version (MIPS64) version (LittleEndian) version = MIPS64LittleEndian;

alias ubyte Elf_Byte;

alias uint   Elf32_Addr;
alias uint   Elf32_Off;
alias int    Elf32_Sword;
alias uint   Elf32_Word;
alias ushort Elf32_Half;

alias ulong Elf64_Addr;
alias ulong Elf64_Off;
alias int   Elf64_Shalf;

version (Alpha)
{
 alias long  Elf64_Sword;
 alias ulong Elf64_Word;
}
else
{
 alias int Elf64_Sword;
 alias uint Elf64_Word;
}

alias long Elf64_Sxword;
alias ulong Elf64_Xword;

alias uint Elf64_Half;
alias ushort Elf64_Quarter;

/*
 * e_ident[] identification indexes
 * See http://www.sco.com/developers/gabi/latest/ch4.eheader.html
 */
enum EI_MAG0       = 0;
enum EI_MAG1       = 1;
enum EI_MAG2       = 2;
enum EI_MAG3       = 3;
enum EI_CLASS      = 4;
enum EI_DATA       = 5;
enum EI_VERSION    = 6;
enum EI_OSABI      = 7;
enum EI_ABIVERSION = 8;
enum EI_PAD        = 9;
enum EI_NIDENT     = 16;

/* e_ident[] magic number */
enum ELFMAG0 =  0x7f;
enum ELFMAG1 =  'E';
enum ELFMAG2 =  'L';
enum ELFMAG3 =  'F';
enum ELFMAG  =  "\177ELF";
enum SELFMAG =  4;

/* e_ident[] file class */
enum ELFCLASSNONE = 0;
enum ELFCLASS32   = 1;
enum ELFCLASS64   = 2;
enum ELFCLASSNUM  = 3;

/* e_ident[] data encoding */
enum ELFDATANONE = 0;
enum ELFDATA2LSB = 1;
enum ELFDATA2MSB = 2;
enum ELFDATANUM  = 3;

/* e_ident[] Operating System/ABI */
enum ELFOSABI_SYSV     =  0;
enum ELFOSABI_HPUX     =  1;
enum ELFOSABI_NETBSD   =  2;
enum ELFOSABI_LINUX    =  3;
enum ELFOSABI_HURD     =  4;
enum ELFOSABI_86OPEN   =  5;
enum ELFOSABI_SOLARIS  =  6;
enum ELFOSABI_MONTEREY =  7;
enum ELFOSABI_IRIX     =  8;
enum ELFOSABI_FREEBSD  =  9;
enum ELFOSABI_TRU64    = 10;
enum ELFOSABI_MODESTO  = 11;
enum ELFOSABI_OPENBSD  = 12;
enum ELFOSABI_ARM      = 97;
enum ELFOSABI_STANDALONE = 255;

/* e_ident */
bool IS_ELF(T)(scope ref const Elf32_Ehdr ehdr)
{
	return ehdr.e_ident[EI_MAG0] == ELFMAG0 &&
		   ehdr.e_ident[EI_MAG1] == ELFMAG1 &&
           ehdr.e_ident[EI_MAG2] == ELFMAG2 &&
           ehdr.e_ident[EI_MAG3] == ELFMAG3;
}

/* ELF Header */
struct Elf32_Ehdr
{
    ubyte[EI_NIDENT] e_ident;;
    Elf32_Half       e_type;
    Elf32_Half       e_machine;
    Elf32_Word       e_version;
    Elf32_Addr       e_entry;
    Elf32_Off        e_phoff;
    Elf32_Off        e_shoff;
    Elf32_Word       e_flags;
    Elf32_Half       e_ehsize;
    Elf32_Half       e_phentsize;
    Elf32_Half       e_phnum;
    Elf32_Half       e_shentsize;
    Elf32_Half       e_shnum;
    Elf32_Half       e_shstrndx;
}

struct Elf64_Ehdr
{
    ubyte[EI_NIDENT] e_ident;
    Elf64_Quarter    e_type;
    Elf64_Quarter    e_machine;
    Elf64_Half       e_version;
    Elf64_Addr       e_entry;
    Elf64_Off        e_phoff;
    Elf64_Off        e_shoff;
    Elf64_Half       e_flags;
    Elf64_Quarter    e_ehsize;
    Elf64_Quarter    e_phentsize;
    Elf64_Quarter    e_phnum;
    Elf64_Quarter    e_shentsize;
    Elf64_Quarter    e_shnum;
    Elf64_Quarter    e_shstrndx;
}

/* e_type */
enum ET_NONE =  0;
enum ET_REL  =  1;
enum ET_EXEC =  2;
enum ET_DYN  =  3;
enum ET_CORE =  4;
enum ET_NUM  =  5;
enum ET_LOPROC = 0xff00;
enum ET_HIPROC = 0xffff;

/* e_machine */
enum EM_NONE =  0;
enum EM_M32  =  1;
enum EM_SPARC = 2;
enum EM_386  =  3;
enum EM_68K  =  4;
enum EM_88K  =  5;
enum EM_486  =  6;
enum EM_860  =  7;
enum EM_MIPS =  8;
/*
 * Don't know if EM_MIPS_RS4_BE,
 * EM_SPARC64, EM_PARISC,
 * or EM_PPC are ABI compliant
 */
enum EM_MIPS_RS4_BE = 10;
enum EM_SPARC64     = 11;
enum EM_PARISC      = 15;
enum EM_SPARC32PLUS = 18;
enum EM_PPC         = 20;
enum EM_PPC64       = 21;
enum EM_ARM         = 40;
enum EM_ALPHA       = 41;
enum EM_SH          = 42;
enum EM_SPARCV9     = 43;
enum EM_IA_64       = 50;
enum EM_AMD64       = 62;
enum EM_X86_64      = EM_AMD64;
enum EM_VAX         = 75;
enum EM_AARCH64    = 183;

/* Non-standard */
enum EM_ALPHA_EXP = 0x9026;  /* DEC ALPHA */

enum EM_NUM = 22;  /* number of machine types */

/* Version */
enum EV_NONE    = 0;
enum EV_CURRENT = 1;
enum EV_NUM     = 2;

/* Magic for e_phnum: get real value from sh_info of first section header */
enum PN_XNUM = 0xffff;

/* Section Header */
struct Elf32_Shdr
{
    Elf32_Word      sh_name;
    Elf32_Word      sh_type;
    Elf32_Word     sh_flags;
    Elf32_Addr      sh_addr;
    Elf32_Off     sh_offset;
    Elf32_Word      sh_size;
    Elf32_Word      sh_link;
    Elf32_Word      sh_info;
    Elf32_Word sh_addralign;
    Elf32_Word   sh_entsize;
} ;

struct Elf64_Shdr
{
    Elf64_Half       sh_name;
    Elf64_Half       sh_type;
    Elf64_Xword     sh_flags;
    Elf64_Addr       sh_addr;
    Elf64_Off      sh_offset;
    Elf64_Xword      sh_size;
    Elf64_Half       sh_link;
    Elf64_Half       sh_info;
    Elf64_Xword sh_addralign;
    Elf64_Xword   sh_entsize;
}

/* Special Section Indexes */
enum SHN_UNDEF     = 0;
enum SHN_LORESERVE = 0xff00;
enum SHN_LOPROC    = 0xff00;
enum SHN_HIPROC    = 0xff1f;
enum SHN_ABS       = 0xfff1;
enum SHN_COMMON    = 0xfff2;
enum SHN_XINDEX    = 0xffff;
enum SHN_HIRESERVE = 0xffff;

/* sh_type */
enum SHT_NULL     =  0;;
enum SHT_PROGBITS =  1;
enum SHT_SYMTAB   =  2;
enum SHT_STRTAB   =  3;
enum SHT_RELA     =  4;
enum SHT_HASH     =  5;
enum SHT_DYNAMIC  =  6;
enum SHT_NOTE     =  7;
enum SHT_NOBITS   =  8;
enum SHT_REL      =  9;
enum SHT_SHLIB    = 10;
enum SHT_DYNSYM   = 11;
enum SHT_NUM      = 12;
enum SHT_SYMTAB_SHNDX = 18;
enum SHT_LOOS   = 0x60000000;
enum SHT_HIOS   = 0x6fffffff;
enum SHT_LOPROC = 0x70000000;
enum SHT_HIPROC = 0x7fffffff;
enum SHT_LOUSER = 0x80000000;
enum SHT_HIUSER = 0xffffffff;

enum SHT_GNU_HASH = 0x6ffffff6;

/* Section names */
enum ELF_BSS           = ".bss";
enum ELF_DATA          = ".data";
enum ELF_CTF           = ".SUNW_ctf";
enum ELF_DEBUG         = ".debug";
enum ELF_DYNAMIC       = ".dynamic";
enum ELF_DYNSTR        = ".dynstr";
enum ELF_DYNSYM        = ".dynsym";
enum ELF_FINI          = ".fini";
enum ELF_GOT           = ".got";
enum ELF_HASH          = ".hash";
enum ELF_INIT          = ".init";
enum ELF_REL_DATA      = ".rel.data";
enum ELF_REL_FINI      = ".rel.fini";
enum ELF_REL_INIT      = ".rel.init";
enum ELF_REL_DYN       = ".rel.dyn";
enum ELF_REL_RODATA    = ".rel.rodata";
enum ELF_REL_TEXT      = ".rel.text";
enum ELF_RODATA        = ".rodata";
enum ELF_SHSTRTAB      = ".shstrtab";
enum ELF_STRTAB        = ".strtab";
enum ELF_SYMTAB        = ".symtab";
enum ELF_TEXT          = ".text";
enum ELF_OPENBSDRANDOMDATA = ".openbsd.randomdata"; /* constant randomdata */


/* Section Attribute Flags - sh_flags */
enum SHF_WRITE            =  0x1;
enum SHF_ALLOC            =  0x2;
enum SHF_EXECINSTR        =  0x4;
enum SHF_MERGE            =  0x10;
enum SHF_STRINGS          =  0x20;
enum SHF_INFO_LINK        =  0x40;
enum SHF_LINK_ORDER       =  0x80;
enum SHF_OS_NONCONFORMING = 0x100;
enum SHF_GROUP            = 0x200;
enum SHF_TLS              = 0x400;
enum SHF_COMPRESSED       = 0x800;
enum SHF_MASKOS      = 0x0ff00000;
enum SHF_MASKPROC    = 0xf0000000;
     /*  specific section attributes */

/* Symbol Table Entry */
struct Elf32_Sym
{
    Elf32_Word st_name;
    Elf32_Addr st_value;
    Elf32_Word st_size;
    ubyte st_info;
    ubyte st_other;
    Elf32_Half st_shndx;
}

struct Elf64_Sym
{
    Elf64_Half st_name;
    Elf_Byte st_info;
    Elf_Byte st_other;
    Elf64_Quarter st_shndx;
    Elf64_Xword st_value;
    Elf64_Xword st_size;
}

/* Symbol table index */
enum STN_UNDEF = 0;

/* Extract symbol info - st_info */
auto ELF32_ST_BIND(T)   (in T x)         { return cast(ubyte) ((x) >> 4); }
auto ELF32_ST_TYPE(T)   (in T x)         { return cast(uint) (x & 0xf);   }
auto ELF32_ST_INFO(B, T)(in B b, in T t) { return (b << 4) + (t & 0xf);   }

alias ELF64_ST_BIND = ELF32_ST_BIND;
alias ELF64_ST_TYPE = ELF32_ST_TYPE;
alias ELF64_ST_INFO = ELF32_ST_INFO;

/* Symbol Binding - ELF32_ST_BIND - st_info */
enum STB_LOCAL  =  0;
enum STB_GLOBAL =  1;
enum STB_WEAK   =  2;
enum STB_NUM    =  3;
enum STB_LOPROC = 13;
enum STB_HIPROC = 15;

/* Symbol type - ELF32_ST_TYPE - st_info */
enum STT_NOTYPE  =  0;
enum STT_OBJECT  =  1;
enum STT_FUNC    =  2;
enum STT_SECTION =  3;
enum STT_FILE    =  4;
enum STT_TLS     =  6;
enum STT_LOPROC  = 13;
enum STT_HIPROC  = 15;

/* Extract symbol visibility - st_other */
auto ELF_ST_VISIBILITY(T)(in T v)  { return v & 0x3; }
alias ELF_ST_VISIBILITY ELF32_ST_VISIBILITY;
alias ELF_ST_VISIBILITY ELF64_ST_VISIBILITY;

enum STV_DEFAULT   = 0;
enum STV_INTERNAL  = 1;
enum STV_HIDDEN    = 2;
enum STV_PROTECTED = 3;

/* Relocation entry with implicit addend */
struct Elf32_Rel
{
    Elf32_Addr r_offset;
    Elf32_Word r_info;
}

/* Relocation entry with explicit addend */
struct Elf32_Rela
{
    Elf32_Addr  r_offset;
    Elf32_Word  r_info;
    Elf32_Sword r_addend;
}

/* Extract relocation info - r_info */
auto ELF32_R_SYM (T)   (in T i)         { return i >> 8;                   }
auto ELF32_R_TYPE(T)   (in T i)         { return cast(ubyte) i;            }
auto ELF32_R_INFO(S, T)(in S s, in T t) { return (s << 8) + cast(ubyte) t; }

struct Elf64_Rel
{
    Elf64_Xword r_offset;
    Elf64_Xword r_info;
}

struct Elf64_Rela
{
   Elf64_Xword  r_offset;
   Elf64_Xword  r_info;
   Elf64_Sxword r_addend;
}

version (MIPS64LittleEndian)
{
  /*
   * The 64-bit MIPS ELF ABI uses a slightly different relocation format
   * than the regular ELF ABI: the r_info field is split into several
   * pieces (see gnu/usr.bin/binutils-2.17/include/elf/mips.h for details).
   */
   import core.bitop : bswap;
   auto ELF64_R_TYPE() (ulong info)       { return cast(ulong) bswap(cast(uint) (info >> 32));    }
   auto ELF64_R_SYM () (ulong info)       { return info & 0xFFFFFFFF;                             }
   auto ELF64_R_INFO() (ulong s, ulong t) { return ((cast(ulong) bswap(cast(uint) t)) << 32) + cast(uint) s; }
}
else
{
   auto ELF64_R_SYM ()  (ulong info)       { return info >> 32;               }
   auto ELF64_R_TYPE()  (ulong info)       { return info & 0xFFFFFFFF;        }
   auto ELF64_R_INFO()  (ulong s, ulong t) { return (s << 32) + cast(uint) t; }
}

/* Program Header */
struct Elf32_Phdr
{
    Elf32_Word   p_type;
    Elf32_Off  p_offset;
    Elf32_Addr  p_vaddr;
    Elf32_Addr  p_paddr;
    Elf32_Word p_filesz;
    Elf32_Word  p_memsz;
    Elf32_Word  p_flags;
    Elf32_Word  p_align;
}

struct Elf64_Phdr
{
    Elf64_Half    p_type;
    Elf64_Half   p_flags;
    Elf64_Off   p_offset;
    Elf64_Addr   p_vaddr;
    Elf64_Addr   p_paddr;
    Elf64_Xword p_filesz;
    Elf64_Xword  p_memsz;
    Elf64_Xword  p_align;
}

/* Segment types - p_type */
enum PT_NULL    = 0;
enum PT_LOAD    = 1;
enum PT_DYNAMIC = 2;
enum PT_INTERP  = 3;
enum PT_NOTE    = 4;
enum PT_SHLIB   = 5;
enum PT_PHDR    = 6;
enum PT_TLS     = 7;
enum PT_LOOS   = 0x60000000;
enum PT_HIOS   = 0x6fffffff;
enum PT_LOPROC = 0x70000000;
enum PT_HIPROC = 0x7fffffff;

enum PT_GNU_EH_FRAME = 0x6474e550;
enum PT_GNU_RELRO    = 0x6474e552;

enum PT_OPENBSD_RANDOMIZE = 0x65a3dbe6;
enum PT_OPENBSD_WXNEEDED  = 0x65a3dbe7;
enum PT_OPENBSD_BOOTDATA  = 0x65a41be6;

/* Segment flags - p_flags */
enum PF_X         = 0x1;
enum PF_W         = 0x2;
enum PF_R         = 0x4;
enum PF_MASKPROC = 0xf0000000;
     /*  specific segment flags */

/* Dynamic structure */
struct Elf32_Dyn
{
  Elf32_Sword   d_tag;
  union _d_un
  {
      Elf32_Word d_val;
      Elf32_Addr d_ptr;
  } _d_un d_un;
}

struct Elf64_Dyn
{
  Elf64_Sword   d_tag;
  union _d_un
  {
      Elf64_Word d_val;
      Elf64_Addr d_ptr;
  } _d_un d_un;
}

/* Dynamic Array Tags - d_tag */
enum DT_NULL            =  0;
enum DT_NEEDED          =  1;
enum DT_PLTRELSZ        =  2;
enum DT_PLTGOT          =  3;
enum DT_HASH            =  4;
enum DT_STRTAB          =  5;
enum DT_SYMTAB          =  6;
enum DT_RELA            =  7;
enum DT_RELASZ          =  8;
enum DT_RELAENT         =  9;
enum DT_STRSZ           = 10;
enum DT_SYMENT          = 11;
enum DT_INIT            = 12;
enum DT_FINI            = 13;
enum DT_SONAME          = 14;
enum DT_RPATH           = 15;
enum DT_SYMBOLIC        = 16;
enum DT_REL             = 17;
enum DT_RELSZ           = 18;
enum DT_RELENT          = 19;
enum DT_PLTREL          = 20;
enum DT_DEBUG           = 21;
enum DT_TEXTREL         = 22;
enum DT_JMPREL          = 23;
enum DT_BIND_NOW        = 24;
enum DT_INIT_ARRAY      = 25;
enum DT_FINI_ARRAY      = 26;
enum DT_INIT_ARRAYSZ    = 27;
enum DT_FINI_ARRAYSZ    = 28;
enum DT_RUNPATH         = 29;
enum DT_FLAGS           = 30;
enum DT_ENCODING        = 31;
enum DT_PREINIT_ARRAY   = 32;
enum DT_PREINIT_ARRAYSZ = 33;
enum DT_LOOS  = 0x6000000d;
enum DT_HIOS  = 0x6ffff000;
enum DT_LOPROC = 0x70000000;
enum DT_HIPROC = 0x7fffffff;

/* some other useful tags */
enum DT_GNU_HASH = 0x6ffffef5;
enum DT_RELACOUNT = 0x6ffffff9;
enum DT_RELCOUNT = 0x6ffffffa;
enum DT_FLAGS_1      = 0x6ffffffb;

/* Dynamic Flags - DT_FLAGS .dynamic entry */
enum DF_ORIGIN       = 0x00000001;
enum DF_SYMBOLIC     = 0x00000002;
enum DF_TEXTREL      = 0x00000004;
enum DF_BIND_NOW     = 0x00000008;
enum DF_STATIC_TLS   = 0x00000010;

/* Dynamic Flags - DT_FLAGS_1 .dynamic entry */
enum DF_1_NOW = 0x00000001;
enum DF_1_GLOBAL = 0x00000002;
enum DF_1_GROUP = 0x00000004;
enum DF_1_NODELETE = 0x00000008;
enum DF_1_LOADFLTR = 0x00000010;
enum DF_1_INITFIRST = 0x00000020;
enum DF_1_NOOPEN = 0x00000040;
enum DF_1_ORIGIN = 0x00000080;
enum DF_1_DIRECT = 0x00000100;
enum DF_1_TRANS = 0x00000200;
enum DF_1_INTERPOSE = 0x00000400;
enum DF_1_NODEFLIB = 0x00000800;
enum DF_1_NODUMP = 0x00001000;
enum DF_1_CONLFAT = 0x00002000;

/*
 * Note header
 */
struct Elf32_Nhdr
{
    Elf32_Word n_namesz;
    Elf32_Word n_descsz;
    Elf32_Word n_type;
}

struct Elf64_Nhdr
{
    Elf64_Half n_namesz;
    Elf64_Half n_descsz;
    Elf64_Half n_type;
}

/*
 * Note Definitions
 */
struct Elf32_Note
{
    Elf32_Word namesz;
    Elf32_Word descsz;
    Elf32_Word type;
}

struct Elf64_Note
{
    Elf64_Half namesz;
    Elf64_Half descsz;
    Elf64_Half type;
}

/* Values for n_type. */
enum NT_PRSTATUS  = 1;
enum NT_FPREGSET  = 2;
enum NT_PRPSINFO  = 3;

/*
 * OpenBSD-specific core file information.
 *
 * OpenBSD ELF core files use notes to provide information about
 * the process's state.  The note name is "OpenBSD" for information
 * that is global to the process, and "OpenBSD@nn", where "nn" is the
 * thread ID of the thread that the information belongs to (such as
 * register state).
 *
 * We use the following note identifiers:
 *
 * NT_OPENBSD_PROCINFO
 *  Note is a "elfcore_procinfo" structure.
 * NT_OPENBSD_AUXV
 *  Note is a a bunch of Auxilliary Vectors, terminated by
 *  an AT_NULL entry.
 * NT_OPENBSD_REGS
 *  Note is a "reg" structure.
 * NT_OPENBSD_FPREGS
 *  Note is a "fpreg" structure.
 *
 * Please try to keep the members of the "elfcore_procinfo" structure
 * nicely aligned, and if you add elements, add them to the end and
 * bump the version.
 */

enum NT_OPENBSD_PROCINFO = 10;
enum NT_OPENBSD_AUXV     = 11;

enum NT_OPENBSD_REGS     = 20;
enum NT_OPENBSD_FPREGS   = 21;
enum NT_OPENBSD_XFPREGS  = 22;
enum NT_OPENBSD_WCOOKIE  = 23;

struct elfcore_procinfo {
 /* Version 1 fields start here. */
 uint cpi_version;
 enum ELFCORE_PROCINFO_VERSION = 1;
 uint cpi_cpisize;;
 uint cpi_signo;
 uint cpi_sigcode;
 uint cpi_sigpend;
 uint cpi_sigmask;
 uint cpi_sigignore;
 uint cpi_sigcatch;
 int  cpi_pid;
 int  cpi_ppid;
 int  cpi_pgrp;
 int  cpi_sid;
 uint cpi_ruid;
 uint cpi_euid;
 uint cpi_svuid;
 uint cpi_rgid;
 uint cpi_egid;
 uint cpi_svgid;
 byte[32] cpi_name;
};

version(all)
{
/*
 * XXX - these _KERNEL items aren't part of the ABI!
 */
//#if defined(_KERNEL) || defined(_DYN_LOADER)

enum ELF32_NO_ADDR = cast(uint) ~0; /* Indicates addr. not yet filled in */

struct Aux32Info
{
    Elf32_Sword au_id;
    Elf32_Word au_v;
}

enum ELF64_NO_ADDR = cast(ulong) ~0; /* Indicates addr. not yet filled in */

struct Aux64Info
{
    Elf64_Shalf au_id;
    Elf64_Xword au_v;
}

enum AuxID
{
    AUX_null     = 0,
    AUX_ignore   = 1,
    AUX_execfd   = 2,
    AUX_phdr     = 3,   /* &phdr[0] */
    AUX_phent    = 4,   /* sizeof(phdr[0]) */
    AUX_phnum    = 5,   /* # phdr entries */
    AUX_pagesz   = 6,   /* PAGESIZE */
    AUX_base     = 7,   /* ld.so base addr */
    AUX_flags    = 8,   /* processor flags */
    AUX_entry    = 9,   /* a.out entry */
    AUX_sun_uid  = 2000,  /* euid */
    AUX_sun_ruid = 2001,  /* ruid */
    AUX_sun_gid  = 2002,  /* egid */
    AUX_sun_rgid = 2003,  /* rgid */
}

import core.stdc.config : c_ulong;
struct elf_args
{
    c_ulong arg_entry;     /* program entry point */
    c_ulong arg_interp;    /* Interpreter load address */
    c_ulong arg_phaddr;    /* program header address */
    c_ulong arg_phentsize; /* Size of program header */
    c_ulong arg_phnum;     /* Number of program headers */
}

//#endif
}

//#if !defined(ELFSIZE) && defined(ARCH_ELFSIZE)
//#define ELFSIZE ARCH_ELFSIZE
//#endif

version (D_LP64)
    enum __ELF_NATIVE_CLASS = 64;
else
    enum __ELF_NATIVE_CLASS = 32;

//#if defined(ELFSIZE)
//#define CONCAT(x,y) __CONCAT(x,y)
//#define ELFNAME(x) CONCAT(elf,CONCAT(ELFSIZE,CONCAT(_,x)))
//#define ELFDEFNNAME(x) CONCAT(ELF,CONCAT(ELFSIZE,CONCAT(_,x)))
//#endif

static if (__ELF_NATIVE_CLASS == 32)
{
    alias Elf_Ehdr    = Elf32_Ehdr;
    alias Elf_Phdr    = Elf32_Phdr;
    alias Elf_Shdr    = Elf32_Shdr;
    alias Elf_Sym     = Elf32_Sym;
    alias Elf_Rel     = Elf32_Rel;
    alias Elf_RelA    = Elf32_Rela;
    alias Elf_Dyn     = Elf32_Dyn;
    alias Elf_Half    = Elf32_Half;
    alias Elf_Word    = Elf32_Word;
    alias Elf_Sword   = Elf32_Sword;
    alias Elf_Addr    = Elf32_Addr;
    alias Elf_Off     = Elf32_Off;
    alias Elf_Nhdr    = Elf32_Nhdr;
    alias Elf_Note    = Elf32_Note;

    alias ELF_R_SYM   = ELF32_R_SYM;
    alias ELF_R_TYPE  = ELF32_R_TYPE;
    alias ELF_R_INFO  = ELF32_R_INFO;
    alias ELFCLASS    = ELFCLASS32;

    alias ELF_ST_BIND = ELF32_ST_BIND;
    alias ELF_ST_TYPE = ELF32_ST_TYPE;
    alias ELF_ST_INFO = ELF32_ST_INFO;

    alias ELF_NO_ADDR = ELF32_NO_ADDR;
//    alias AuxInfo     = Aux32Info;
}
else static if (__ELF_NATIVE_CLASS == 64)
{
    alias Elf_Ehdr    = Elf64_Ehdr;
    alias Elf_Phdr    = Elf64_Phdr;
    alias Elf_Shdr    = Elf64_Shdr;
    alias Elf_Sym     = Elf64_Sym;
    alias Elf_Rel     = Elf64_Rel;
    alias Elf_RelA    = Elf64_Rela;
    alias Elf_Dyn     = Elf64_Dyn;
    alias Elf_Half    = Elf64_Half;
    alias Elf_Word    = Elf64_Word;
    alias Elf_Sword   = Elf64_Sword;
    alias Elf_Addr    = Elf64_Addr;
    alias Elf_Off     = Elf64_Off;
    alias Elf_Nhdr    = Elf64_Nhdr;
    alias Elf_Note    = Elf64_Note;

    alias ELF_R_SYM   = ELF64_R_SYM;
    alias ELF_R_TYPE  = ELF64_R_TYPE;
    alias ELF_R_INFO  = ELF64_R_INFO;
    alias ELFCLASS    = ELFCLASS64;

    alias ELF_ST_BIND = ELF64_ST_BIND;
    alias ELF_ST_TYPE = ELF64_ST_TYPE;
    alias ELF_ST_INFO = ELF64_ST_INFO;

    alias ELF_NO_ADDR = ELF64_NO_ADDR;
//    alias AuxInfo     = Aux64Info;
}

version(all)
{
//#ifndef _KERNEL
extern Elf_Dyn* _DYNAMIC;
//#endif
}

version(none)
{
/+
#ifdef _KERNEL
struct exec_package;

int exec_elf_makecmds(struct proc *, struct exec_package *);
#endif /* _KERNEL */
+/
}

enum ELF_TARG_VER = 1;
