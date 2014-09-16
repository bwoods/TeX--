% Using kerTeX's (http://www.kergis.com/en/kertex.html) values for some of the constants
% Using LuaTeX's (https://foundry.supelec.fr/projects/luatex) values for data type ranges (halfword, quarterword)
% Using github.com/ktraunmueller’s hash_sizes to successfully load a basic LaTeX setup 

@x
@<Constants...@>=
@!mem_max=30000; {greatest index in \TeX's internal |mem| array;
  must be strictly less than |max_halfword|;
  must be equal to |mem_top| in \.{INITEX}, otherwise |>=mem_top|}
@!mem_min=0; {smallest index in \TeX's internal |mem| array;
  must be |min_halfword| or more;
  must be equal to |mem_bot| in \.{INITEX}, otherwise |<=mem_bot|}
@!buf_size=500; {maximum number of characters simultaneously present in
  current lines of open files and in control sequences between
  \.{\\csname} and \.{\\endcsname}; must not exceed |max_halfword|}
@!error_line=72; {width of context lines on terminal error messages}
@!half_error_line=42; {width of first lines of contexts in terminal
  error messages; should be between 30 and |error_line-15|}
@!max_print_line=79; {width of longest text lines output; should be at least 60}
@!stack_size=200; {maximum number of simultaneous input sources}
@!max_in_open=6; {maximum number of input files and error insertions that
  can be going on simultaneously}
@!font_max=75; {maximum internal font number; must not exceed |max_quarterword|
  and must be at most |font_base+256|}
@!font_mem_size=20000; {number of words of |font_info| for all fonts}
@!param_size=60; {maximum number of simultaneous macro parameters}
@!nest_size=40; {maximum number of semantic levels simultaneously active}
@!max_strings=3000; {maximum number of strings; must not exceed |max_halfword|}
@!string_vacancies=8000; {the minimum number of characters that should be
  available for the user's control sequences and font names,
  after \TeX's own error messages are stored}
@!pool_size=32000; {maximum number of characters in strings, including all
  error messages and help texts, and the names of all fonts and
  control sequences; must exceed |string_vacancies| by the total
  length of \TeX's own strings, which is currently about 23000}
@!save_size=600; {space for saving values outside of current group; must be
  at most |max_halfword|}
@!trie_size=8000; {space for hyphenation patterns; should be larger for
  \.{INITEX} than it is in production versions of \TeX}
@!trie_op_size=500; {space for ``opcodes'' in the hyphenation patterns}
@!dvi_buf_size=800; {size of the output buffer; must be a multiple of 8}
@!file_name_size=40; {file names shouldn't be longer than this}
@!pool_name='TeXformats:TEX.POOL                     ';
  {string of length |file_name_size|; tells where the string pool appears}
@y
@<Constants...@>=
@!mem_max=1000000; {greatest index in \TeX's internal |mem| array;
  must be strictly less than |max_halfword|;
  must be equal to |mem_top| in \.{INITEX}, otherwise |>=mem_top|}
@!mem_min=0; {smallest index in \TeX's internal |mem| array;
  must be |min_halfword| or more;
  must be equal to |mem_bot| in \.{INITEX}, otherwise |<=mem_bot|}
@!buf_size=3000; {maximum number of characters simultaneously present in
  current lines of open files and in control sequences between
  \.{\\csname} and \.{\\endcsname}; must not exceed |max_halfword|}
@!error_line=79; {width of context lines on terminal error messages}
@!half_error_line=50; {width of first lines of contexts in terminal
  error messages; should be between 30 and |error_line-15|}
@!max_print_line=79; {width of longest text lines output; should be at least 60}
@!stack_size=300; {maximum number of simultaneous input sources}
@!max_in_open=15; {maximum number of input files and error insertions that
  can be going on simultaneously}
@!font_max=255; {maximum internal font number; must not exceed |max_quarterword|
  and must be at most |font_base+256|}
@!font_mem_size=72000; {number of words of |font_info| for all fonts}
@!param_size=60; {maximum number of simultaneous macro parameters}
@!nest_size=40; {maximum number of semantic levels simultaneously active}
@!max_strings=7500; {maximum number of strings; must not exceed |max_halfword|}
@!string_vacancies=74000; {the minimum number of characters that should be
  available for the user's control sequences and font names,
  after \TeX's own error messages are stored}
@!pool_size=100000; {maximum number of characters in strings, including all
  error messages and help texts, and the names of all fonts and
  control sequences; must exceed |string_vacancies| by the total
  length of \TeX's own strings, which is currently about 23000}
@!save_size=4000; {space for saving values outside of current group; must be
  at most |max_halfword|}
@!trie_size=24000; {space for hyphenation patterns; should be larger for
  \.{INITEX} than it is in production versions of \TeX}
@!trie_op_size=750; {space for ``opcodes'' in the hyphenation patterns}
@!dvi_buf_size=16384; {size of the output buffer; must be a multiple of 8}
@!file_name_size=FILENAME_MAX; {file names shouldn't be longer than this}
@!pool_name='tex/tex.pool';
  {string of length |file_name_size|; tells where the string pool appears}
@z

@x
@d mem_bot=0 {smallest index in the |mem| array dumped by \.{INITEX};
  must not be less than |mem_min|}
@d mem_top==30000 {largest index in the |mem| array dumped by \.{INITEX};
  must be substantially larger than |mem_bot|
  and not greater than |mem_max|}
@d font_base=0 {smallest internal font number; must not be less
  than |min_quarterword|}
@d hash_size=2100 {maximum number of control sequences; it should be at most
  about |(mem_max-mem_min)/10|}
@d hash_prime=1777 {a prime number equal to about 85\pct! of |hash_size|}
@d hyph_size=307 {another prime; the number of \.{\\hyphenation} exceptions}
@y
@d mem_bot=0 {smallest index in the |mem| array dumped by \.{INITEX};
  must not be less than |mem_min|}
@d mem_top==mem_max {largest index in the |mem| array dumped by \.{INITEX};
  must be substantially larger than |mem_bot|
  and not greater than |mem_max|}
@d font_base=0 {smallest internal font number; must not be less
  than |min_quarterword|}
@d hash_size=9000 {maximum number of control sequences; it should be at most
  about |(mem_max-mem_min)/10|}
@d hash_prime=7649 {a prime number equal to about 85\pct! of |hash_size|}
@d hyph_size=307 {another prime; the number of \.{\\hyphenation} exceptions}
@z

@x
@d min_quarterword=0 {smallest allowable value in a |quarterword|}
@d max_quarterword=255 {largest allowable value in a |quarterword|}
@d min_halfword==0 {smallest allowable value in a |halfword|}
@d max_halfword==65535 {largest allowable value in a |halfword|}
@y
@d min_quarterword=0 {smallest allowable value in a |quarterword|}
@d max_quarterword=65535 {largest allowable value in a |quarterword|}
@d min_halfword==-1073741824 {smallest allowable value in a |halfword|}
@d max_halfword==1073741824 {largest allowable value in a |halfword|}
@z