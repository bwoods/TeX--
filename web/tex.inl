// inline macro definitions
//


// file handling
#define __CAT__(a,b) a##b

#define FILEBUFNC(f,type) \
	int __CAT__(f,_BFLAGS); \
		type __CAT__(f,_BUFFER)

#define GET(f,type) \
	(__CAT__(f,_BFLAGS) == 1 ? \
		fread(&__CAT__(f,_BUFFER),sizeof(type),1,(f)) : \
		(__CAT__(f,_BFLAGS) = 1))

#define GETFBUF(f,type) \
		(*((__CAT__(f,_BFLAGS) == 1 && \
		((__CAT__(f,_BFLAGS) = 2), \
		fread(&__CAT__(f,_BUFFER), \
		sizeof(type),1,(f)))), \
		&__CAT__(f,_BUFFER)))

#define PUT(f,type) \
		(fwrite(&__CAT__(f,_BUFFER),sizeof(type),1,(f)), \
		(__CAT__(f,_BFLAGS) = 0))

#define RESETBUF(f,type)   (__CAT__(f,_BFLAGS) = 1)
#define SETUPBUF(f,type)   (__CAT__(f,_BFLAGS) = 0)


// bitset routines
#define get_bits(a,i,n,L)   ((int)((a)[(i)>>(L)-(n)] >> \
		(((~(i))&((1<<(L)-(n))-1)) << (n)) & \
		(1<<(1<<(n)))-1))

#define put_bits(a,i,x,n,L) ((a)[(i)>>(L)-(n)] |= \
		(x) << (((~(i))&((1<<(L)-(n))-1)) << (n)))

#define clr_bits(a,i,n,L)    ((a)[(i)>>(L)-(n)] &= \
		~( ((1<<(1<<(n)))-1) << \
		(((~(i))&((1<<(L)-(n))-1)) << (n))) )


