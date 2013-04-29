#define __CAT__(a,b) a##b
#define FILEBUFNC(f,type) int __CAT__(f,_mode); type __CAT__(f,_value)
#define GET(f,type) get<type>(f, __CAT__(f,_mode), &__CAT__(f,_value))
#define GETFBUF(f,type) getfbuf<type>(f, __CAT__(f,_mode), &__CAT__(f,_value))
#define PUT(f,type) put<type>(f, __CAT__(f,_mode), &__CAT__(f,_value))
#define RESETBUF(f,type)	__CAT__(f,_mode) = 1
#define SETUPBUF(f,type)	__CAT__(f,_mode) = 0
#define get_bit(a,i,n,L) a[i]
#define put_bit(a,i,x,n,L) a[i] = x