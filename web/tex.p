{4:}{9:}{$C-,A+,D-}{[$C+,D+]}{:9}program TEX;label{6:}1,9998,9999;
{:6}const{11:}mem_max=30000;mem_min=0;buf_size=500;error_line=72;
half_error_line=42;max_print_line=79;stack_size=200;max_in_open=6;
font_max=75;font_mem_size=20000;param_size=60;nest_size=40;
max_strings=3000;string_vacancies=8000;pool_size=32000;save_size=600;
trie_size=8000;trie_op_size=500;dvi_buf_size=800;file_name_size=40;
pool_name='TeXformats:TEX.POOL                     ';
{:11}type{18:}ASCII_code=0..255;{:18}{25:}eight_bits=0..255;
alpha_file=packed file of char;byte_file=packed file of eight_bits;
{:25}{38:}pool_pointer=0..pool_size;str_number=0..max_strings;
packed_ASCII_code=0..255;{:38}{101:}scaled=integer;
nonnegative_integer=0..2147483647;small_number=0..63;
{:101}{109:}glue_ratio=real;{:109}{113:}quarterword=0..255;
halfword=0..65535;two_choices=1..2;four_choices=1..4;
two_halves=packed record rh:halfword;
case two_choices of 1:(lh:halfword);2:(b0:quarterword;b1:quarterword);
end;four_quarters=packed record b0:quarterword;b1:quarterword;
b2:quarterword;b3:quarterword;end;
memory_word=record case four_choices of 1:(int:integer);
2:(gr:glue_ratio);3:(hh:two_halves);4:(qqqq:four_quarters);end;
word_file=file of memory_word;{:113}{150:}glue_ord=0..3;
{:150}{212:}list_state_record=record mode_field:-203..203;
head_field,tail_field:halfword;pg_field,ml_field:integer;
aux_field:memory_word;end;{:212}{269:}group_code=0..16;
{:269}{300:}in_state_record=record state_field,index_field:quarterword;
start_field,loc_field,limit_field,name_field:halfword;end;
{:300}{548:}internal_font_number=0..font_max;
font_index=0..font_mem_size;{:548}{594:}dvi_index=0..dvi_buf_size;
{:594}{920:}trie_pointer=0..trie_size;{:920}{925:}hyph_pointer=0..307;
{:925}var{13:}bad:integer;{:13}{20:}xord:array[char]of ASCII_code;
xchr:array[ASCII_code]of char;
{:20}{26:}name_of_file:packed array[1..file_name_size]of char;
name_length:0..file_name_size;
{:26}{30:}buffer:array[0..buf_size]of ASCII_code;first:0..buf_size;
last:0..buf_size;max_buf_stack:0..buf_size;{:30}{32:}term_in:alpha_file;
term_out:alpha_file;
{:32}{39:}str_pool:packed array[pool_pointer]of packed_ASCII_code;
str_start:array[str_number]of pool_pointer;pool_ptr:pool_pointer;
str_ptr:str_number;init_pool_ptr:pool_pointer;init_str_ptr:str_number;
{:39}{50:}pool_file:alpha_file;{:50}{54:}log_file:alpha_file;
selector:0..21;dig:array[0..22]of 0..15;tally:integer;
term_offset:0..max_print_line;file_offset:0..max_print_line;
trick_buf:array[0..error_line]of ASCII_code;trick_count:integer;
first_count:integer;{:54}{73:}interaction:0..3;
{:73}{76:}deletions_allowed:boolean;set_box_allowed:boolean;
history:0..3;error_count:-1..100;
{:76}{79:}help_line:array[0..5]of str_number;help_ptr:0..6;
use_err_help:boolean;{:79}{96:}interrupt:integer;
OK_to_interrupt:boolean;{:96}{104:}arith_error:boolean;remainder:scaled;
{:104}{115:}temp_ptr:halfword;
{:115}{116:}mem:array[mem_min..mem_max]of memory_word;
lo_mem_max:halfword;hi_mem_min:halfword;
{:116}{117:}var_used,dyn_used:integer;{:117}{118:}avail:halfword;
mem_end:halfword;{:118}{124:}rover:halfword;
{:124}{165:}{free:packed array[mem_min..mem_max]of boolean;
was_free:packed array[mem_min..mem_max]of boolean;
was_mem_end,was_lo_max,was_hi_min:halfword;panicking:boolean;}
{:165}{173:}font_in_short_display:integer;
{:173}{181:}depth_threshold:integer;breadth_max:integer;
{:181}{213:}nest:array[0..nest_size]of list_state_record;
nest_ptr:0..nest_size;max_nest_stack:0..nest_size;
cur_list:list_state_record;shown_mode:-203..203;
{:213}{246:}old_setting:0..21;
{:246}{253:}eqtb:array[1..6106]of memory_word;
xeq_level:array[5263..6106]of quarterword;
{:253}{256:}hash:array[514..2880]of two_halves;hash_used:halfword;
no_new_control_sequence:boolean;cs_count:integer;
{:256}{271:}save_stack:array[0..save_size]of memory_word;
save_ptr:0..save_size;max_save_stack:0..save_size;cur_level:quarterword;
cur_group:group_code;cur_boundary:0..save_size;
{:271}{286:}mag_set:integer;{:286}{297:}cur_cmd:eight_bits;
cur_chr:halfword;cur_cs:halfword;cur_tok:halfword;
{:297}{301:}input_stack:array[0..stack_size]of in_state_record;
input_ptr:0..stack_size;max_in_stack:0..stack_size;
cur_input:in_state_record;{:301}{304:}in_open:0..max_in_open;
open_parens:0..max_in_open;
input_file:array[1..max_in_open]of alpha_file;line:integer;
line_stack:array[1..max_in_open]of integer;
{:304}{305:}scanner_status:0..5;warning_index:halfword;def_ref:halfword;
{:305}{308:}param_stack:array[0..param_size]of halfword;
param_ptr:0..param_size;max_param_stack:integer;
{:308}{309:}align_state:integer;{:309}{310:}base_ptr:0..stack_size;
{:310}{333:}par_loc:halfword;par_token:halfword;
{:333}{361:}force_eof:boolean;
{:361}{382:}cur_mark:array[0..4]of halfword;
{:382}{387:}long_state:111..114;
{:387}{388:}pstack:array[0..8]of halfword;{:388}{410:}cur_val:integer;
cur_val_level:0..5;{:410}{438:}radix:small_number;
{:438}{447:}cur_order:glue_ord;
{:447}{480:}read_file:array[0..15]of alpha_file;
read_open:array[0..16]of 0..2;{:480}{489:}cond_ptr:halfword;
if_limit:0..4;cur_if:small_number;if_line:integer;
{:489}{493:}skip_line:integer;{:493}{512:}cur_name:str_number;
cur_area:str_number;cur_ext:str_number;
{:512}{513:}area_delimiter:pool_pointer;ext_delimiter:pool_pointer;
{:513}{520:}TEX_format_default:packed array[1..20]of char;
{:520}{527:}name_in_progress:boolean;job_name:str_number;
log_opened:boolean;{:527}{532:}dvi_file:byte_file;
output_file_name:str_number;log_name:str_number;
{:532}{539:}tfm_file:byte_file;
{:539}{549:}font_info:array[font_index]of memory_word;
fmem_ptr:font_index;font_ptr:internal_font_number;
font_check:array[internal_font_number]of four_quarters;
font_size:array[internal_font_number]of scaled;
font_dsize:array[internal_font_number]of scaled;
font_params:array[internal_font_number]of font_index;
font_name:array[internal_font_number]of str_number;
font_area:array[internal_font_number]of str_number;
font_bc:array[internal_font_number]of eight_bits;
font_ec:array[internal_font_number]of eight_bits;
font_glue:array[internal_font_number]of halfword;
font_used:array[internal_font_number]of boolean;
hyphen_char:array[internal_font_number]of integer;
skew_char:array[internal_font_number]of integer;
bchar_label:array[internal_font_number]of font_index;
font_bchar:array[internal_font_number]of 0..256;
font_false_bchar:array[internal_font_number]of 0..256;
{:549}{550:}char_base:array[internal_font_number]of integer;
width_base:array[internal_font_number]of integer;
height_base:array[internal_font_number]of integer;
depth_base:array[internal_font_number]of integer;
italic_base:array[internal_font_number]of integer;
lig_kern_base:array[internal_font_number]of integer;
kern_base:array[internal_font_number]of integer;
exten_base:array[internal_font_number]of integer;
param_base:array[internal_font_number]of integer;
{:550}{555:}null_character:four_quarters;
{:555}{592:}total_pages:integer;max_v:scaled;max_h:scaled;
max_push:integer;last_bop:integer;dead_cycles:integer;
doing_leaders:boolean;c,f:quarterword;rule_ht,rule_dp,rule_wd:scaled;
g:halfword;lq,lr:integer;
{:592}{595:}dvi_buf:array[dvi_index]of eight_bits;half_buf:dvi_index;
dvi_limit:dvi_index;dvi_ptr:dvi_index;dvi_offset:integer;
dvi_gone:integer;{:595}{605:}down_ptr,right_ptr:halfword;
{:605}{616:}dvi_h,dvi_v:scaled;cur_h,cur_v:scaled;
dvi_f:internal_font_number;cur_s:integer;
{:616}{646:}total_stretch,total_shrink:array[glue_ord]of scaled;
last_badness:integer;{:646}{647:}adjust_tail:halfword;
{:647}{661:}pack_begin_line:integer;{:661}{684:}empty_field:two_halves;
null_delimiter:four_quarters;{:684}{719:}cur_mlist:halfword;
cur_style:small_number;cur_size:small_number;cur_mu:scaled;
mlist_penalties:boolean;{:719}{724:}cur_f:internal_font_number;
cur_c:quarterword;cur_i:four_quarters;{:724}{764:}magic_offset:integer;
{:764}{770:}cur_align:halfword;cur_span:halfword;cur_loop:halfword;
align_ptr:halfword;cur_head,cur_tail:halfword;
{:770}{814:}just_box:halfword;{:814}{821:}passive:halfword;
printed_node:halfword;pass_number:halfword;
{:821}{823:}active_width:array[1..6]of scaled;
cur_active_width:array[1..6]of scaled;background:array[1..6]of scaled;
break_width:array[1..6]of scaled;
{:823}{825:}no_shrink_error_yet:boolean;{:825}{828:}cur_p:halfword;
second_pass:boolean;final_pass:boolean;threshold:integer;
{:828}{833:}minimal_demerits:array[0..3]of integer;
minimum_demerits:integer;best_place:array[0..3]of halfword;
best_pl_line:array[0..3]of halfword;{:833}{839:}disc_width:scaled;
{:839}{847:}easy_line:halfword;last_special_line:halfword;
first_width:scaled;second_width:scaled;first_indent:scaled;
second_indent:scaled;{:847}{872:}best_bet:halfword;
fewest_demerits:integer;best_line:halfword;actual_looseness:integer;
line_diff:integer;{:872}{892:}hc:array[0..65]of 0..256;hn:small_number;
ha,hb:halfword;hf:internal_font_number;hu:array[0..63]of 0..256;
hyf_char:integer;cur_lang,init_cur_lang:ASCII_code;
l_hyf,r_hyf,init_l_hyf,init_r_hyf:integer;hyf_bchar:halfword;
{:892}{900:}hyf:array[0..64]of 0..9;init_list:halfword;init_lig:boolean;
init_lft:boolean;{:900}{905:}hyphen_passed:small_number;
{:905}{907:}cur_l,cur_r:halfword;cur_q:halfword;lig_stack:halfword;
ligature_present:boolean;lft_hit,rt_hit:boolean;
{:907}{921:}trie:array[trie_pointer]of two_halves;
hyf_distance:array[1..trie_op_size]of small_number;
hyf_num:array[1..trie_op_size]of small_number;
hyf_next:array[1..trie_op_size]of quarterword;
op_start:array[ASCII_code]of 0..trie_op_size;
{:921}{926:}hyph_word:array[hyph_pointer]of str_number;
hyph_list:array[hyph_pointer]of halfword;hyph_count:hyph_pointer;
{:926}{943:}trie_op_hash:array[-trie_op_size..trie_op_size]of 0..
trie_op_size;trie_used:array[ASCII_code]of quarterword;
trie_op_lang:array[1..trie_op_size]of ASCII_code;
trie_op_val:array[1..trie_op_size]of quarterword;
trie_op_ptr:0..trie_op_size;
{:943}{947:}trie_c:packed array[trie_pointer]of packed_ASCII_code;
trie_o:packed array[trie_pointer]of quarterword;
trie_l:packed array[trie_pointer]of trie_pointer;
trie_r:packed array[trie_pointer]of trie_pointer;trie_ptr:trie_pointer;
trie_hash:packed array[trie_pointer]of trie_pointer;
{:947}{950:}trie_taken:packed array[1..trie_size]of boolean;
trie_min:array[ASCII_code]of trie_pointer;trie_max:trie_pointer;
trie_not_ready:boolean;{:950}{971:}best_height_plus_depth:scaled;
{:971}{980:}page_tail:halfword;page_contents:0..2;page_max_depth:scaled;
best_page_break:halfword;least_page_cost:integer;best_size:scaled;
{:980}{982:}page_so_far:array[0..7]of scaled;last_glue:halfword;
last_penalty:integer;last_kern:scaled;insert_penalties:integer;
{:982}{989:}output_active:boolean;
{:989}{1032:}main_f:internal_font_number;main_i:four_quarters;
main_j:four_quarters;main_k:font_index;main_p:halfword;main_s:integer;
bchar:halfword;false_bchar:halfword;cancel_boundary:boolean;
ins_disc:boolean;{:1032}{1074:}cur_box:halfword;
{:1074}{1266:}after_token:halfword;{:1266}{1281:}long_help_seen:boolean;
{:1281}{1299:}format_ident:str_number;{:1299}{1305:}fmt_file:word_file;
{:1305}{1331:}ready_already:integer;
{:1331}{1342:}write_file:array[0..15]of alpha_file;
write_open:array[0..17]of boolean;{:1342}{1345:}write_loc:halfword;
{:1345}procedure initialize;var{19:}i:integer;{:19}{163:}k:integer;
{:163}{927:}z:hyph_pointer;{:927}begin{8:}{21:}xchr[32]:=' ';
xchr[33]:='!';xchr[34]:='"';xchr[35]:='#';xchr[36]:='$';xchr[37]:='%';
xchr[38]:='&';xchr[39]:='''';xchr[40]:='(';xchr[41]:=')';xchr[42]:='*';
xchr[43]:='+';xchr[44]:=',';xchr[45]:='-';xchr[46]:='.';xchr[47]:='/';
xchr[48]:='0';xchr[49]:='1';xchr[50]:='2';xchr[51]:='3';xchr[52]:='4';
xchr[53]:='5';xchr[54]:='6';xchr[55]:='7';xchr[56]:='8';xchr[57]:='9';
xchr[58]:=':';xchr[59]:=';';xchr[60]:='<';xchr[61]:='=';xchr[62]:='>';
xchr[63]:='?';xchr[64]:='@';xchr[65]:='A';xchr[66]:='B';xchr[67]:='C';
xchr[68]:='D';xchr[69]:='E';xchr[70]:='F';xchr[71]:='G';xchr[72]:='H';
xchr[73]:='I';xchr[74]:='J';xchr[75]:='K';xchr[76]:='L';xchr[77]:='M';
xchr[78]:='N';xchr[79]:='O';xchr[80]:='P';xchr[81]:='Q';xchr[82]:='R';
xchr[83]:='S';xchr[84]:='T';xchr[85]:='U';xchr[86]:='V';xchr[87]:='W';
xchr[88]:='X';xchr[89]:='Y';xchr[90]:='Z';xchr[91]:='[';xchr[92]:='\';
xchr[93]:=']';xchr[94]:='^';xchr[95]:='_';xchr[96]:='`';xchr[97]:='a';
xchr[98]:='b';xchr[99]:='c';xchr[100]:='d';xchr[101]:='e';
xchr[102]:='f';xchr[103]:='g';xchr[104]:='h';xchr[105]:='i';
xchr[106]:='j';xchr[107]:='k';xchr[108]:='l';xchr[109]:='m';
xchr[110]:='n';xchr[111]:='o';xchr[112]:='p';xchr[113]:='q';
xchr[114]:='r';xchr[115]:='s';xchr[116]:='t';xchr[117]:='u';
xchr[118]:='v';xchr[119]:='w';xchr[120]:='x';xchr[121]:='y';
xchr[122]:='z';xchr[123]:='{';xchr[124]:='|';xchr[125]:='}';
xchr[126]:='~';{:21}{23:}for i:=0 to 31 do xchr[i]:=' ';
for i:=127 to 255 do xchr[i]:=' ';
{:23}{24:}for i:=0 to 255 do xord[chr(i)]:=127;
for i:=128 to 255 do xord[xchr[i]]:=i;
for i:=0 to 126 do xord[xchr[i]]:=i;{:24}{74:}interaction:=3;
{:74}{77:}deletions_allowed:=true;set_box_allowed:=true;error_count:=0;
{:77}{80:}help_ptr:=0;use_err_help:=false;{:80}{97:}interrupt:=0;
OK_to_interrupt:=true;{:97}{166:}{was_mem_end:=mem_min;
was_lo_max:=mem_min;was_hi_min:=mem_max;panicking:=false;}
{:166}{215:}nest_ptr:=0;max_nest_stack:=0;cur_list.mode_field:=1;
cur_list.head_field:=29999;cur_list.tail_field:=29999;
cur_list.aux_field.int:=-65536000;cur_list.ml_field:=0;
cur_list.pg_field:=0;shown_mode:=0;{991:}page_contents:=0;
page_tail:=29998;mem[29998].hh.rh:=0;last_glue:=65535;last_penalty:=0;
last_kern:=0;page_so_far[7]:=0;page_max_depth:=0{:991};
{:215}{254:}for k:=5263 to 6106 do xeq_level[k]:=1;
{:254}{257:}no_new_control_sequence:=true;hash[514].lh:=0;
hash[514].rh:=0;for k:=515 to 2880 do hash[k]:=hash[514];
{:257}{272:}save_ptr:=0;cur_level:=1;cur_group:=0;cur_boundary:=0;
max_save_stack:=0;{:272}{287:}mag_set:=0;{:287}{383:}cur_mark[0]:=0;
cur_mark[1]:=0;cur_mark[2]:=0;cur_mark[3]:=0;cur_mark[4]:=0;
{:383}{439:}cur_val:=0;cur_val_level:=0;radix:=0;cur_order:=0;
{:439}{481:}for k:=0 to 16 do read_open[k]:=2;{:481}{490:}cond_ptr:=0;
if_limit:=0;cur_if:=0;if_line:=0;
{:490}{521:}TEX_format_default:='TeXformats:plain.fmt';
{:521}{551:}for k:=0 to font_max do font_used[k]:=false;
{:551}{556:}null_character.b0:=0;null_character.b1:=0;
null_character.b2:=0;null_character.b3:=0;{:556}{593:}total_pages:=0;
max_v:=0;max_h:=0;max_push:=0;last_bop:=-1;doing_leaders:=false;
dead_cycles:=0;cur_s:=-1;{:593}{596:}half_buf:=dvi_buf_size div 2;
dvi_limit:=dvi_buf_size;dvi_ptr:=0;dvi_offset:=0;dvi_gone:=0;
{:596}{606:}down_ptr:=0;right_ptr:=0;{:606}{648:}adjust_tail:=0;
last_badness:=0;{:648}{662:}pack_begin_line:=0;
{:662}{685:}empty_field.rh:=0;empty_field.lh:=0;null_delimiter.b0:=0;
null_delimiter.b1:=0;null_delimiter.b2:=0;null_delimiter.b3:=0;
{:685}{771:}align_ptr:=0;cur_align:=0;cur_span:=0;cur_loop:=0;
cur_head:=0;cur_tail:=0;
{:771}{928:}for z:=0 to 307 do begin hyph_word[z]:=0;hyph_list[z]:=0;
end;hyph_count:=0;{:928}{990:}output_active:=false;insert_penalties:=0;
{:990}{1033:}ligature_present:=false;cancel_boundary:=false;
lft_hit:=false;rt_hit:=false;ins_disc:=false;
{:1033}{1267:}after_token:=0;{:1267}{1282:}long_help_seen:=false;
{:1282}{1300:}format_ident:=0;
{:1300}{1343:}for k:=0 to 17 do write_open[k]:=false;
{:1343}{164:}for k:=1 to 19 do mem[k].int:=0;k:=0;
while k<=19 do begin mem[k].hh.rh:=1;mem[k].hh.b0:=0;mem[k].hh.b1:=0;
k:=k+4;end;mem[6].int:=65536;mem[4].hh.b0:=1;mem[10].int:=65536;
mem[8].hh.b0:=2;mem[14].int:=65536;mem[12].hh.b0:=1;mem[15].int:=65536;
mem[12].hh.b1:=1;mem[18].int:=-65536;mem[16].hh.b0:=1;rover:=20;
mem[rover].hh.rh:=65535;mem[rover].hh.lh:=1000;
mem[rover+1].hh.lh:=rover;mem[rover+1].hh.rh:=rover;
lo_mem_max:=rover+1000;mem[lo_mem_max].hh.rh:=0;
mem[lo_mem_max].hh.lh:=0;
for k:=29987 to 30000 do mem[k]:=mem[lo_mem_max];
{790:}mem[29990].hh.lh:=6714;{:790}{797:}mem[29991].hh.rh:=256;
mem[29991].hh.lh:=0;{:797}{820:}mem[29993].hh.b0:=1;
mem[29994].hh.lh:=65535;mem[29993].hh.b1:=0;
{:820}{981:}mem[30000].hh.b1:=255;mem[30000].hh.b0:=1;
mem[30000].hh.rh:=30000;{:981}{988:}mem[29998].hh.b0:=10;
mem[29998].hh.b1:=0;{:988};avail:=0;mem_end:=30000;hi_mem_min:=29987;
var_used:=20;dyn_used:=14;{:164}{222:}eqtb[2881].hh.b0:=101;
eqtb[2881].hh.rh:=0;eqtb[2881].hh.b1:=0;
for k:=1 to 2880 do eqtb[k]:=eqtb[2881];{:222}{228:}eqtb[2882].hh.rh:=0;
eqtb[2882].hh.b1:=1;eqtb[2882].hh.b0:=117;
for k:=2883 to 3411 do eqtb[k]:=eqtb[2882];
mem[0].hh.rh:=mem[0].hh.rh+530;{:228}{232:}eqtb[3412].hh.rh:=0;
eqtb[3412].hh.b0:=118;eqtb[3412].hh.b1:=1;
for k:=3413 to 3677 do eqtb[k]:=eqtb[2881];eqtb[3678].hh.rh:=0;
eqtb[3678].hh.b0:=119;eqtb[3678].hh.b1:=1;
for k:=3679 to 3933 do eqtb[k]:=eqtb[3678];eqtb[3934].hh.rh:=0;
eqtb[3934].hh.b0:=120;eqtb[3934].hh.b1:=1;
for k:=3935 to 3982 do eqtb[k]:=eqtb[3934];eqtb[3983].hh.rh:=0;
eqtb[3983].hh.b0:=120;eqtb[3983].hh.b1:=1;
for k:=3984 to 5262 do eqtb[k]:=eqtb[3983];
for k:=0 to 255 do begin eqtb[3983+k].hh.rh:=12;eqtb[5007+k].hh.rh:=k+0;
eqtb[4751+k].hh.rh:=1000;end;eqtb[3996].hh.rh:=5;eqtb[4015].hh.rh:=10;
eqtb[4075].hh.rh:=0;eqtb[4020].hh.rh:=14;eqtb[4110].hh.rh:=15;
eqtb[3983].hh.rh:=9;for k:=48 to 57 do eqtb[5007+k].hh.rh:=k+28672;
for k:=65 to 90 do begin eqtb[3983+k].hh.rh:=11;
eqtb[3983+k+32].hh.rh:=11;eqtb[5007+k].hh.rh:=k+28928;
eqtb[5007+k+32].hh.rh:=k+28960;eqtb[4239+k].hh.rh:=k+32;
eqtb[4239+k+32].hh.rh:=k+32;eqtb[4495+k].hh.rh:=k;
eqtb[4495+k+32].hh.rh:=k;eqtb[4751+k].hh.rh:=999;end;
{:232}{240:}for k:=5263 to 5573 do eqtb[k].int:=0;eqtb[5280].int:=1000;
eqtb[5264].int:=10000;eqtb[5304].int:=1;eqtb[5303].int:=25;
eqtb[5308].int:=92;eqtb[5311].int:=13;
for k:=0 to 255 do eqtb[5574+k].int:=-1;eqtb[5620].int:=0;
{:240}{250:}for k:=5830 to 6106 do eqtb[k].int:=0;
{:250}{258:}hash_used:=2614;cs_count:=0;eqtb[2623].hh.b0:=116;
hash[2623].rh:=502;{:258}{552:}font_ptr:=0;fmem_ptr:=7;
font_name[0]:=800;font_area[0]:=338;hyphen_char[0]:=45;skew_char[0]:=-1;
bchar_label[0]:=0;font_bchar[0]:=256;font_false_bchar[0]:=256;
font_bc[0]:=1;font_ec[0]:=0;font_size[0]:=0;font_dsize[0]:=0;
char_base[0]:=0;width_base[0]:=0;height_base[0]:=0;depth_base[0]:=0;
italic_base[0]:=0;lig_kern_base[0]:=0;kern_base[0]:=0;exten_base[0]:=0;
font_glue[0]:=0;font_params[0]:=7;param_base[0]:=-1;
for k:=0 to 6 do font_info[k].int:=0;
{:552}{946:}for k:=-trie_op_size to trie_op_size do trie_op_hash[k]:=0;
for k:=0 to 255 do trie_used[k]:=0;trie_op_ptr:=0;
{:946}{951:}trie_not_ready:=true;trie_l[0]:=0;trie_c[0]:=0;trie_ptr:=0;
{:951}{1216:}hash[2614].rh:=1189;{:1216}{1301:}format_ident:=1256;
{:1301}{1369:}hash[2622].rh:=1295;eqtb[2622].hh.b1:=1;
eqtb[2622].hh.b0:=113;eqtb[2622].hh.rh:=0;{:1369}{:8}end;
{57:}procedure print_ln;
begin case selector of 19:begin write_ln(term_out);write_ln(log_file);
term_offset:=0;file_offset:=0;end;18:begin write_ln(log_file);
file_offset:=0;end;17:begin write_ln(term_out);term_offset:=0;end;
16,20,21:;others:write_ln(write_file[selector])end;end;
{:57}{58:}procedure print_char(s:ASCII_code);label 10;
begin if{244:}s=eqtb[5312].int{:244}then if selector<20 then begin
print_ln;goto 10;end;case selector of 19:begin write(term_out,xchr[s]);
write(log_file,xchr[s]);term_offset:=term_offset+1;
file_offset:=file_offset+1;
if term_offset=max_print_line then begin write_ln(term_out);
term_offset:=0;end;
if file_offset=max_print_line then begin write_ln(log_file);
file_offset:=0;end;end;18:begin write(log_file,xchr[s]);
file_offset:=file_offset+1;if file_offset=max_print_line then print_ln;
end;17:begin write(term_out,xchr[s]);term_offset:=term_offset+1;
if term_offset=max_print_line then print_ln;end;16:;
20:if tally<trick_count then trick_buf[tally mod error_line]:=s;
21:begin if pool_ptr<pool_size then begin str_pool[pool_ptr]:=s;
pool_ptr:=pool_ptr+1;end;end;
others:write(write_file[selector],xchr[s])end;tally:=tally+1;10:end;
{:58}{59:}procedure print(s:integer);label 10;var j:pool_pointer;
nl:integer;
begin if s>=str_ptr then s:=259 else if s<256 then if s<0 then s:=259
else begin if selector>20 then begin print_char(s);goto 10;end;
if({244:}s=eqtb[5312].int{:244})then if selector<20 then begin print_ln;
goto 10;end;nl:=eqtb[5312].int;eqtb[5312].int:=-1;j:=str_start[s];
while j<str_start[s+1]do begin print_char(str_pool[j]);j:=j+1;end;
eqtb[5312].int:=nl;goto 10;end;j:=str_start[s];
while j<str_start[s+1]do begin print_char(str_pool[j]);j:=j+1;end;
10:end;{:59}{60:}procedure slow_print(s:integer);var j:pool_pointer;
begin if(s>=str_ptr)or(s<256)then print(s)else begin j:=str_start[s];
while j<str_start[s+1]do begin print(str_pool[j]);j:=j+1;end;end;end;
{:60}{62:}procedure print_nl(s:str_number);
begin if((term_offset>0)and(odd(selector)))or((file_offset>0)and(
selector>=18))then print_ln;print(s);end;
{:62}{63:}procedure print_esc(s:str_number);var c:integer;
begin{243:}c:=eqtb[5308].int{:243};if c>=0 then if c<256 then print(c);
slow_print(s);end;{:63}{64:}procedure print_the_digs(k:eight_bits);
begin while k>0 do begin k:=k-1;
if dig[k]<10 then print_char(48+dig[k])else print_char(55+dig[k]);end;
end;{:64}{65:}procedure print_int(n:integer);var k:0..23;m:integer;
begin k:=0;if n<0 then begin print_char(45);
if n>-100000000 then n:=-n else begin m:=-1-n;n:=m div 10;
m:=(m mod 10)+1;k:=1;if m<10 then dig[0]:=m else begin dig[0]:=0;n:=n+1;
end;end;end;repeat dig[k]:=n mod 10;n:=n div 10;k:=k+1;until n=0;
print_the_digs(k);end;{:65}{262:}procedure print_cs(p:integer);
begin if p<514 then if p>=257 then if p=513 then begin print_esc(504);
print_esc(505);end else begin print_esc(p-257);
if eqtb[3983+p-257].hh.rh=11 then print_char(32);
end else if p<1 then print_esc(506)else print(p-1)else if p>=2881 then
print_esc(506)else if(hash[p].rh<0)or(hash[p].rh>=str_ptr)then print_esc
(507)else begin print_esc(hash[p].rh);print_char(32);end;end;
{:262}{263:}procedure sprint_cs(p:halfword);
begin if p<514 then if p<257 then print(p-1)else if p<513 then print_esc
(p-257)else begin print_esc(504);print_esc(505);
end else print_esc(hash[p].rh);end;
{:263}{518:}procedure print_file_name(n,a,e:integer);
begin slow_print(a);slow_print(n);slow_print(e);end;
{:518}{699:}procedure print_size(s:integer);
begin if s=0 then print_esc(412)else if s=16 then print_esc(413)else
print_esc(414);end;
{:699}{1355:}procedure print_write_whatsit(s:str_number;p:halfword);
begin print_esc(s);
if mem[p+1].hh.lh<16 then print_int(mem[p+1].hh.lh)else if mem[p+1].hh.
lh=16 then print_char(42)else print_char(45);end;
{:1355}{78:}procedure normalize_selector;forward;procedure get_token;
forward;procedure term_input;forward;procedure show_context;forward;
procedure begin_file_reading;forward;procedure open_log_file;forward;
procedure close_files_and_terminate;forward;
procedure clear_for_error_prompt;forward;procedure give_err_help;
forward;{procedure debug_help;forward;}{:78}{81:}procedure jump_out;
begin goto 9998;end;{:81}{82:}procedure error;label 22,10;
var c:ASCII_code;s1,s2,s3,s4:integer;begin if history<2 then history:=2;
print_char(46);show_context;
if interaction=3 then{83:}while true do begin 22:clear_for_error_prompt;
begin;print(264);term_input;end;if last=first then goto 10;
c:=buffer[first];if c>=97 then c:=c-32;
{84:}case c of 48,49,50,51,52,53,54,55,56,57:if deletions_allowed then
{88:}begin s1:=cur_tok;s2:=cur_cmd;s3:=cur_chr;s4:=align_state;
align_state:=1000000;OK_to_interrupt:=false;
if(last>first+1)and(buffer[first+1]>=48)and(buffer[first+1]<=57)then c:=
c*10+buffer[first+1]-48*11 else c:=c-48;while c>0 do begin get_token;
c:=c-1;end;cur_tok:=s1;cur_cmd:=s2;cur_chr:=s3;align_state:=s4;
OK_to_interrupt:=true;begin help_ptr:=2;help_line[1]:=279;
help_line[0]:=280;end;show_context;goto 22;end{:88};
{68:begin debug_help;goto 22;end;}
69:if base_ptr>0 then begin print_nl(265);
slow_print(input_stack[base_ptr].name_field);print(266);print_int(line);
interaction:=2;jump_out;end;
72:{89:}begin if use_err_help then begin give_err_help;
use_err_help:=false;end else begin if help_ptr=0 then begin help_ptr:=2;
help_line[1]:=281;help_line[0]:=282;end;repeat help_ptr:=help_ptr-1;
print(help_line[help_ptr]);print_ln;until help_ptr=0;end;
begin help_ptr:=4;help_line[3]:=283;help_line[2]:=282;help_line[1]:=284;
help_line[0]:=285;end;goto 22;end{:89};73:{87:}begin begin_file_reading;
if last>first+1 then begin cur_input.loc_field:=first+1;
buffer[first]:=32;end else begin begin;print(278);term_input;end;
cur_input.loc_field:=first;end;first:=last;
cur_input.limit_field:=last-1;goto 10;end{:87};
81,82,83:{86:}begin error_count:=0;interaction:=0+c-81;print(273);
case c of 81:begin print_esc(274);selector:=selector-1;end;
82:print_esc(275);83:print_esc(276);end;print(277);print_ln;
break(term_out);goto 10;end{:86};88:begin interaction:=2;jump_out;end;
others:end;{85:}begin print(267);print_nl(268);print_nl(269);
if base_ptr>0 then print(270);if deletions_allowed then print_nl(271);
print_nl(272);end{:85}{:84};end{:83};error_count:=error_count+1;
if error_count=100 then begin print_nl(263);history:=3;jump_out;end;
{90:}if interaction>0 then selector:=selector-1;
if use_err_help then begin print_ln;give_err_help;
end else while help_ptr>0 do begin help_ptr:=help_ptr-1;
print_nl(help_line[help_ptr]);end;print_ln;
if interaction>0 then selector:=selector+1;print_ln{:90};10:end;
{:82}{93:}procedure fatal_error(s:str_number);begin normalize_selector;
begin if interaction=3 then;print_nl(262);print(287);end;
begin help_ptr:=1;help_line[0]:=s;end;
begin if interaction=3 then interaction:=2;if log_opened then error;
{if interaction>0 then debug_help;}history:=3;jump_out;end;end;
{:93}{94:}procedure overflow(s:str_number;n:integer);
begin normalize_selector;begin if interaction=3 then;print_nl(262);
print(288);end;print(s);print_char(61);print_int(n);print_char(93);
begin help_ptr:=2;help_line[1]:=289;help_line[0]:=290;end;
begin if interaction=3 then interaction:=2;if log_opened then error;
{if interaction>0 then debug_help;}history:=3;jump_out;end;end;
{:94}{95:}procedure confusion(s:str_number);begin normalize_selector;
if history<2 then begin begin if interaction=3 then;print_nl(262);
print(291);end;print(s);print_char(41);begin help_ptr:=1;
help_line[0]:=292;end;end else begin begin if interaction=3 then;
print_nl(262);print(293);end;begin help_ptr:=2;help_line[1]:=294;
help_line[0]:=295;end;end;begin if interaction=3 then interaction:=2;
if log_opened then error;{if interaction>0 then debug_help;}history:=3;
jump_out;end;end;
{:95}{:4}{27:}function a_open_in(var f:alpha_file):boolean;
begin reset(f,name_of_file,'/O');a_open_in:=erstat(f)=0;end;
function a_open_out(var f:alpha_file):boolean;
begin rewrite(f,name_of_file,'/O');a_open_out:=erstat(f)=0;end;
function b_open_in(var f:byte_file):boolean;
begin reset(f,name_of_file,'/O');b_open_in:=erstat(f)=0;end;
function b_open_out(var f:byte_file):boolean;
begin rewrite(f,name_of_file,'/O');b_open_out:=erstat(f)=0;end;
function w_open_in(var f:word_file):boolean;
begin reset(f,name_of_file,'/O');w_open_in:=erstat(f)=0;end;
function w_open_out(var f:word_file):boolean;
begin rewrite(f,name_of_file,'/O');w_open_out:=erstat(f)=0;end;
{:27}{28:}procedure a_close(var f:alpha_file);begin close(f);end;
procedure b_close(var f:byte_file);begin close(f);end;
procedure w_close(var f:word_file);begin close(f);end;
{:28}{31:}function input_ln(var f:alpha_file;
bypass_eoln:boolean):boolean;var last_nonblank:0..buf_size;
begin if bypass_eoln then if not eof(f)then get(f);last:=first;
if eof(f)then input_ln:=false else begin last_nonblank:=first;
while not eoln(f)do begin if last>=max_buf_stack then begin
max_buf_stack:=last+1;
if max_buf_stack=buf_size then{35:}if format_ident=0 then begin write_ln
(term_out,'Buffer size exceeded!');goto 9999;
end else begin cur_input.loc_field:=first;cur_input.limit_field:=last-1;
overflow(256,buf_size);end{:35};end;buffer[last]:=xord[f^];get(f);
last:=last+1;if buffer[last-1]<>32 then last_nonblank:=last;end;
last:=last_nonblank;input_ln:=true;end;end;
{:31}{37:}function init_terminal:boolean;label 10;
begin reset(term_in,'TTY:','/O/I');while true do begin;
write(term_out,'**');break(term_out);
if not input_ln(term_in,true)then begin write_ln(term_out);
write(term_out,'! End of file on the terminal... why?');
init_terminal:=false;goto 10;end;cur_input.loc_field:=first;
while(cur_input.loc_field<last)and(buffer[cur_input.loc_field]=32)do
cur_input.loc_field:=cur_input.loc_field+1;
if cur_input.loc_field<last then begin init_terminal:=true;goto 10;end;
write_ln(term_out,'Please type the name of your input file.');end;
10:end;{:37}{43:}function make_string:str_number;
begin if str_ptr=max_strings then overflow(258,max_strings-init_str_ptr)
;str_ptr:=str_ptr+1;str_start[str_ptr]:=pool_ptr;make_string:=str_ptr-1;
end;{:43}{45:}function str_eq_buf(s:str_number;k:integer):boolean;
label 45;var j:pool_pointer;result:boolean;begin j:=str_start[s];
while j<str_start[s+1]do begin if str_pool[j]<>buffer[k]then begin
result:=false;goto 45;end;j:=j+1;k:=k+1;end;result:=true;
45:str_eq_buf:=result;end;
{:45}{46:}function str_eq_str(s,t:str_number):boolean;label 45;
var j,k:pool_pointer;result:boolean;begin result:=false;
if(str_start[s+1]-str_start[s])<>(str_start[t+1]-str_start[t])then goto
45;j:=str_start[s];k:=str_start[t];
while j<str_start[s+1]do begin if str_pool[j]<>str_pool[k]then goto 45;
j:=j+1;k:=k+1;end;result:=true;45:str_eq_str:=result;end;
{:46}{47:}function get_strings_started:boolean;label 30,10;
var k,l:0..255;m,n:char;g:str_number;a:integer;c:boolean;
begin pool_ptr:=0;str_ptr:=0;str_start[0]:=0;
{48:}for k:=0 to 255 do begin if({49:}(k<32)or(k>126){:49})then begin
begin str_pool[pool_ptr]:=94;pool_ptr:=pool_ptr+1;end;
begin str_pool[pool_ptr]:=94;pool_ptr:=pool_ptr+1;end;
if k<64 then begin str_pool[pool_ptr]:=k+64;pool_ptr:=pool_ptr+1;
end else if k<128 then begin str_pool[pool_ptr]:=k-64;
pool_ptr:=pool_ptr+1;end else begin l:=k div 16;
if l<10 then begin str_pool[pool_ptr]:=l+48;pool_ptr:=pool_ptr+1;
end else begin str_pool[pool_ptr]:=l+87;pool_ptr:=pool_ptr+1;end;
l:=k mod 16;if l<10 then begin str_pool[pool_ptr]:=l+48;
pool_ptr:=pool_ptr+1;end else begin str_pool[pool_ptr]:=l+87;
pool_ptr:=pool_ptr+1;end;end;end else begin str_pool[pool_ptr]:=k;
pool_ptr:=pool_ptr+1;end;g:=make_string;end{:48};
{51:}name_of_file:=pool_name;if a_open_in(pool_file)then begin c:=false;
repeat{52:}begin if eof(pool_file)then begin;
write_ln(term_out,'! TEX.POOL has no check sum.');a_close(pool_file);
get_strings_started:=false;goto 10;end;read(pool_file,m,n);
if m='*'then{53:}begin a:=0;k:=1;
while true do begin if(xord[n]<48)or(xord[n]>57)then begin;
write_ln(term_out,'! TEX.POOL check sum doesn''t have nine digits.');
a_close(pool_file);get_strings_started:=false;goto 10;end;
a:=10*a+xord[n]-48;if k=9 then goto 30;k:=k+1;read(pool_file,n);end;
30:if a<>117275187 then begin;
write_ln(term_out,'! TEX.POOL doesn''t match; TANGLE me again.');
a_close(pool_file);get_strings_started:=false;goto 10;end;c:=true;
end{:53}else begin if(xord[m]<48)or(xord[m]>57)or(xord[n]<48)or(xord[n]>
57)then begin;
write_ln(term_out,'! TEX.POOL line doesn''t begin with two digits.');
a_close(pool_file);get_strings_started:=false;goto 10;end;
l:=xord[m]*10+xord[n]-48*11;
if pool_ptr+l+string_vacancies>pool_size then begin;
write_ln(term_out,'! You have to increase POOLSIZE.');
a_close(pool_file);get_strings_started:=false;goto 10;end;
for k:=1 to l do begin if eoln(pool_file)then m:=' 'else read(pool_file,
m);begin str_pool[pool_ptr]:=xord[m];pool_ptr:=pool_ptr+1;end;end;
read_ln(pool_file);g:=make_string;end;end{:52};until c;
a_close(pool_file);get_strings_started:=true;end else begin;
write_ln(term_out,'! I can''t read TEX.POOL.');a_close(pool_file);
get_strings_started:=false;goto 10;end{:51};10:end;
{:47}{66:}procedure print_two(n:integer);begin n:=abs(n)mod 100;
print_char(48+(n div 10));print_char(48+(n mod 10));end;
{:66}{67:}procedure print_hex(n:integer);var k:0..22;begin k:=0;
print_char(34);repeat dig[k]:=n mod 16;n:=n div 16;k:=k+1;until n=0;
print_the_digs(k);end;{:67}{69:}procedure print_roman_int(n:integer);
label 10;var j,k:pool_pointer;u,v:nonnegative_integer;
begin j:=str_start[260];v:=1000;
while true do begin while n>=v do begin print_char(str_pool[j]);n:=n-v;
end;if n<=0 then goto 10;k:=j+2;u:=v div(str_pool[k-1]-48);
if str_pool[k-1]=50 then begin k:=k+2;u:=u div(str_pool[k-1]-48);end;
if n+u>=v then begin print_char(str_pool[k]);n:=n+u;
end else begin j:=j+2;v:=v div(str_pool[j-1]-48);end;end;10:end;
{:69}{70:}procedure print_current_string;var j:pool_pointer;
begin j:=str_start[str_ptr];
while j<pool_ptr do begin print_char(str_pool[j]);j:=j+1;end;end;
{:70}{71:}procedure term_input;var k:0..buf_size;begin break(term_out);
if not input_ln(term_in,true)then fatal_error(261);term_offset:=0;
selector:=selector-1;
if last<>first then for k:=first to last-1 do print(buffer[k]);print_ln;
selector:=selector+1;end;{:71}{91:}procedure int_error(n:integer);
begin print(286);print_int(n);print_char(41);error;end;
{:91}{92:}procedure normalize_selector;
begin if log_opened then selector:=19 else selector:=17;
if job_name=0 then open_log_file;
if interaction=0 then selector:=selector-1;end;
{:92}{98:}procedure pause_for_instructions;
begin if OK_to_interrupt then begin interaction:=3;
if(selector=18)or(selector=16)then selector:=selector+1;
begin if interaction=3 then;print_nl(262);print(296);end;
begin help_ptr:=3;help_line[2]:=297;help_line[1]:=298;help_line[0]:=299;
end;deletions_allowed:=false;error;deletions_allowed:=true;interrupt:=0;
end;end;{:98}{100:}function half(x:integer):integer;
begin if odd(x)then half:=(x+1)div 2 else half:=x div 2;end;
{:100}{102:}function round_decimals(k:small_number):scaled;
var a:integer;begin a:=0;while k>0 do begin k:=k-1;
a:=(a+dig[k]*131072)div 10;end;round_decimals:=(a+1)div 2;end;
{:102}{103:}procedure print_scaled(s:scaled);var delta:scaled;
begin if s<0 then begin print_char(45);s:=-s;end;print_int(s div 65536);
print_char(46);s:=10*(s mod 65536)+5;delta:=10;
repeat if delta>65536 then s:=s-17232;print_char(48+(s div 65536));
s:=10*(s mod 65536);delta:=delta*10;until s<=delta;end;
{:103}{105:}function mult_and_add(n:integer;
x,y,max_answer:scaled):scaled;begin if n<0 then begin x:=-x;n:=-n;end;
if n=0 then mult_and_add:=y else if((x<=(max_answer-y)div n)and(-x<=(
max_answer+y)div n))then mult_and_add:=n*x+y else begin arith_error:=
true;mult_and_add:=0;end;end;{:105}{106:}function x_over_n(x:scaled;
n:integer):scaled;var negative:boolean;begin negative:=false;
if n=0 then begin arith_error:=true;x_over_n:=0;remainder:=x;
end else begin if n<0 then begin x:=-x;n:=-n;negative:=true;end;
if x>=0 then begin x_over_n:=x div n;remainder:=x mod n;
end else begin x_over_n:=-((-x)div n);remainder:=-((-x)mod n);end;end;
if negative then remainder:=-remainder;end;
{:106}{107:}function xn_over_d(x:scaled;n,d:integer):scaled;
var positive:boolean;t,u,v:nonnegative_integer;
begin if x>=0 then positive:=true else begin x:=-x;positive:=false;end;
t:=(x mod 32768)*n;u:=(x div 32768)*n+(t div 32768);
v:=(u mod d)*32768+(t mod 32768);
if u div d>=32768 then arith_error:=true else u:=32768*(u div d)+(v div
d);if positive then begin xn_over_d:=u;remainder:=v mod d;
end else begin xn_over_d:=-u;remainder:=-(v mod d);end;end;
{:107}{108:}function badness(t,s:scaled):halfword;var r:integer;
begin if t=0 then badness:=0 else if s<=0 then badness:=10000 else begin
if t<=7230584 then r:=(t*297)div s else if s>=1663497 then r:=t div(s
div 297)else r:=t;
if r>1290 then badness:=10000 else badness:=(r*r*r+131072)div 262144;
end;end;{:108}{114:}{procedure print_word(w:memory_word);
begin print_int(w.int);print_char(32);print_scaled(w.int);
print_char(32);print_scaled(round(65536*w.gr));print_ln;
print_int(w.hh.lh);print_char(61);print_int(w.hh.b0);print_char(58);
print_int(w.hh.b1);print_char(59);print_int(w.hh.rh);print_char(32);
print_int(w.qqqq.b0);print_char(58);print_int(w.qqqq.b1);print_char(58);
print_int(w.qqqq.b2);print_char(58);print_int(w.qqqq.b3);end;}
{:114}{119:}{292:}procedure show_token_list(p,q:integer;l:integer);
label 10;var m,c:integer;match_chr:ASCII_code;n:ASCII_code;
begin match_chr:=35;n:=48;tally:=0;
while(p<>0)and(tally<l)do begin if p=q then{320:}begin first_count:=
tally;trick_count:=tally+1+error_line-half_error_line;
if trick_count<error_line then trick_count:=error_line;end{:320};
{293:}if(p<hi_mem_min)or(p>mem_end)then begin print_esc(309);goto 10;
end;
if mem[p].hh.lh>=4095 then print_cs(mem[p].hh.lh-4095)else begin m:=mem[
p].hh.lh div 256;c:=mem[p].hh.lh mod 256;
if mem[p].hh.lh<0 then print_esc(555)else{294:}case m of 1,2,3,4,7,8,10,
11,12:print(c);6:begin print(c);print(c);end;5:begin print(match_chr);
if c<=9 then print_char(c+48)else begin print_char(33);goto 10;end;end;
13:begin match_chr:=c;print(c);n:=n+1;print_char(n);
if n>57 then goto 10;end;14:print(556);others:print_esc(555)end{:294};
end{:293};p:=mem[p].hh.rh;end;if p<>0 then print_esc(554);10:end;
{:292}{306:}procedure runaway;var p:halfword;
begin if scanner_status>1 then begin print_nl(569);
case scanner_status of 2:begin print(570);p:=def_ref;end;
3:begin print(571);p:=29997;end;4:begin print(572);p:=29996;end;
5:begin print(573);p:=def_ref;end;end;print_char(63);print_ln;
show_token_list(mem[p].hh.rh,0,error_line-10);end;end;
{:306}{:119}{120:}function get_avail:halfword;var p:halfword;
begin p:=avail;
if p<>0 then avail:=mem[avail].hh.rh else if mem_end<mem_max then begin
mem_end:=mem_end+1;p:=mem_end;end else begin hi_mem_min:=hi_mem_min-1;
p:=hi_mem_min;if hi_mem_min<=lo_mem_max then begin runaway;
overflow(300,mem_max+1-mem_min);end;end;mem[p].hh.rh:=0;
{dyn_used:=dyn_used+1;}get_avail:=p;end;
{:120}{123:}procedure flush_list(p:halfword);var q,r:halfword;
begin if p<>0 then begin r:=p;repeat q:=r;r:=mem[r].hh.rh;
{dyn_used:=dyn_used-1;}until r=0;mem[q].hh.rh:=avail;avail:=p;end;end;
{:123}{125:}function get_node(s:integer):halfword;label 40,10,20;
var p:halfword;q:halfword;r:integer;t:integer;begin 20:p:=rover;
repeat{127:}q:=p+mem[p].hh.lh;
while(mem[q].hh.rh=65535)do begin t:=mem[q+1].hh.rh;
if q=rover then rover:=t;mem[t+1].hh.lh:=mem[q+1].hh.lh;
mem[mem[q+1].hh.lh+1].hh.rh:=t;q:=q+mem[q].hh.lh;end;r:=q-s;
if r>p+1 then{128:}begin mem[p].hh.lh:=r-p;rover:=p;goto 40;end{:128};
if r=p then if mem[p+1].hh.rh<>p then{129:}begin rover:=mem[p+1].hh.rh;
t:=mem[p+1].hh.lh;mem[rover+1].hh.lh:=t;mem[t+1].hh.rh:=rover;goto 40;
end{:129};mem[p].hh.lh:=q-p{:127};p:=mem[p+1].hh.rh;until p=rover;
if s=1073741824 then begin get_node:=65535;goto 10;end;
if lo_mem_max+2<hi_mem_min then if lo_mem_max+2<=65535 then{126:}begin
if hi_mem_min-lo_mem_max>=1998 then t:=lo_mem_max+1000 else t:=
lo_mem_max+1+(hi_mem_min-lo_mem_max)div 2;p:=mem[rover+1].hh.lh;
q:=lo_mem_max;mem[p+1].hh.rh:=q;mem[rover+1].hh.lh:=q;
if t>65535 then t:=65535;mem[q+1].hh.rh:=rover;mem[q+1].hh.lh:=p;
mem[q].hh.rh:=65535;mem[q].hh.lh:=t-lo_mem_max;lo_mem_max:=t;
mem[lo_mem_max].hh.rh:=0;mem[lo_mem_max].hh.lh:=0;rover:=q;goto 20;
end{:126};overflow(300,mem_max+1-mem_min);40:mem[r].hh.rh:=0;
{var_used:=var_used+s;}get_node:=r;10:end;
{:125}{130:}procedure free_node(p:halfword;s:halfword);var q:halfword;
begin mem[p].hh.lh:=s;mem[p].hh.rh:=65535;q:=mem[rover+1].hh.lh;
mem[p+1].hh.lh:=q;mem[p+1].hh.rh:=rover;mem[rover+1].hh.lh:=p;
mem[q+1].hh.rh:=p;{var_used:=var_used-s;}end;
{:130}{131:}procedure sort_avail;var p,q,r:halfword;old_rover:halfword;
begin p:=get_node(1073741824);p:=mem[rover+1].hh.rh;
mem[rover+1].hh.rh:=65535;old_rover:=rover;
while p<>old_rover do{132:}if p<rover then begin q:=p;p:=mem[q+1].hh.rh;
mem[q+1].hh.rh:=rover;rover:=q;end else begin q:=rover;
while mem[q+1].hh.rh<p do q:=mem[q+1].hh.rh;r:=mem[p+1].hh.rh;
mem[p+1].hh.rh:=mem[q+1].hh.rh;mem[q+1].hh.rh:=p;p:=r;end{:132};
p:=rover;
while mem[p+1].hh.rh<>65535 do begin mem[mem[p+1].hh.rh+1].hh.lh:=p;
p:=mem[p+1].hh.rh;end;mem[p+1].hh.rh:=rover;mem[rover+1].hh.lh:=p;end;
{:131}{136:}function new_null_box:halfword;var p:halfword;
begin p:=get_node(7);mem[p].hh.b0:=0;mem[p].hh.b1:=0;mem[p+1].int:=0;
mem[p+2].int:=0;mem[p+3].int:=0;mem[p+4].int:=0;mem[p+5].hh.rh:=0;
mem[p+5].hh.b0:=0;mem[p+5].hh.b1:=0;mem[p+6].gr:=0.0;new_null_box:=p;
end;{:136}{139:}function new_rule:halfword;var p:halfword;
begin p:=get_node(4);mem[p].hh.b0:=2;mem[p].hh.b1:=0;
mem[p+1].int:=-1073741824;mem[p+2].int:=-1073741824;
mem[p+3].int:=-1073741824;new_rule:=p;end;
{:139}{144:}function new_ligature(f,c:quarterword;q:halfword):halfword;
var p:halfword;begin p:=get_node(2);mem[p].hh.b0:=6;mem[p+1].hh.b0:=f;
mem[p+1].hh.b1:=c;mem[p+1].hh.rh:=q;mem[p].hh.b1:=0;new_ligature:=p;end;
function new_lig_item(c:quarterword):halfword;var p:halfword;
begin p:=get_node(2);mem[p].hh.b1:=c;mem[p+1].hh.rh:=0;new_lig_item:=p;
end;{:144}{145:}function new_disc:halfword;var p:halfword;
begin p:=get_node(2);mem[p].hh.b0:=7;mem[p].hh.b1:=0;mem[p+1].hh.lh:=0;
mem[p+1].hh.rh:=0;new_disc:=p;end;
{:145}{147:}function new_math(w:scaled;s:small_number):halfword;
var p:halfword;begin p:=get_node(2);mem[p].hh.b0:=9;mem[p].hh.b1:=s;
mem[p+1].int:=w;new_math:=p;end;
{:147}{151:}function new_spec(p:halfword):halfword;var q:halfword;
begin q:=get_node(4);mem[q]:=mem[p];mem[q].hh.rh:=0;
mem[q+1].int:=mem[p+1].int;mem[q+2].int:=mem[p+2].int;
mem[q+3].int:=mem[p+3].int;new_spec:=q;end;
{:151}{152:}function new_param_glue(n:small_number):halfword;
var p:halfword;q:halfword;begin p:=get_node(2);mem[p].hh.b0:=10;
mem[p].hh.b1:=n+1;mem[p+1].hh.rh:=0;q:={224:}eqtb[2882+n].hh.rh{:224};
mem[p+1].hh.lh:=q;mem[q].hh.rh:=mem[q].hh.rh+1;new_param_glue:=p;end;
{:152}{153:}function new_glue(q:halfword):halfword;var p:halfword;
begin p:=get_node(2);mem[p].hh.b0:=10;mem[p].hh.b1:=0;mem[p+1].hh.rh:=0;
mem[p+1].hh.lh:=q;mem[q].hh.rh:=mem[q].hh.rh+1;new_glue:=p;end;
{:153}{154:}function new_skip_param(n:small_number):halfword;
var p:halfword;begin temp_ptr:=new_spec({224:}eqtb[2882+n].hh.rh{:224});
p:=new_glue(temp_ptr);mem[temp_ptr].hh.rh:=0;mem[p].hh.b1:=n+1;
new_skip_param:=p;end;{:154}{156:}function new_kern(w:scaled):halfword;
var p:halfword;begin p:=get_node(2);mem[p].hh.b0:=11;mem[p].hh.b1:=0;
mem[p+1].int:=w;new_kern:=p;end;
{:156}{158:}function new_penalty(m:integer):halfword;var p:halfword;
begin p:=get_node(2);mem[p].hh.b0:=12;mem[p].hh.b1:=0;mem[p+1].int:=m;
new_penalty:=p;end;{:158}{167:}{procedure check_mem(print_locs:boolean);
label 31,32;var p,q:halfword;clobbered:boolean;
begin for p:=mem_min to lo_mem_max do free[p]:=false;
for p:=hi_mem_min to mem_end do free[p]:=false;[168:]p:=avail;q:=0;
clobbered:=false;
while p<>0 do begin if(p>mem_end)or(p<hi_mem_min)then clobbered:=true
else if free[p]then clobbered:=true;
if clobbered then begin print_nl(301);print_int(q);goto 31;end;
free[p]:=true;q:=p;p:=mem[q].hh.rh;end;31:[:168];[169:]p:=rover;q:=0;
clobbered:=false;
repeat if(p>=lo_mem_max)or(p<mem_min)then clobbered:=true else if(mem[p
+1].hh.rh>=lo_mem_max)or(mem[p+1].hh.rh<mem_min)then clobbered:=true
else if not((mem[p].hh.rh=65535))or(mem[p].hh.lh<2)or(p+mem[p].hh.lh>
lo_mem_max)or(mem[mem[p+1].hh.rh+1].hh.lh<>p)then clobbered:=true;
if clobbered then begin print_nl(302);print_int(q);goto 32;end;
for q:=p to p+mem[p].hh.lh-1 do begin if free[q]then begin print_nl(303)
;print_int(q);goto 32;end;free[q]:=true;end;q:=p;p:=mem[p+1].hh.rh;
until p=rover;32:[:169];[170:]p:=mem_min;
while p<=lo_mem_max do begin if(mem[p].hh.rh=65535)then begin print_nl(
304);print_int(p);end;while(p<=lo_mem_max)and not free[p]do p:=p+1;
while(p<=lo_mem_max)and free[p]do p:=p+1;end[:170];
if print_locs then[171:]begin print_nl(305);
for p:=mem_min to lo_mem_max do if not free[p]and((p>was_lo_max)or
was_free[p])then begin print_char(32);print_int(p);end;
for p:=hi_mem_min to mem_end do if not free[p]and((p<was_hi_min)or(p>
was_mem_end)or was_free[p])then begin print_char(32);print_int(p);end;
end[:171];for p:=mem_min to lo_mem_max do was_free[p]:=free[p];
for p:=hi_mem_min to mem_end do was_free[p]:=free[p];
was_mem_end:=mem_end;was_lo_max:=lo_mem_max;was_hi_min:=hi_mem_min;end;}
{:167}{172:}{procedure search_mem(p:halfword);var q:integer;
begin for q:=mem_min to lo_mem_max do begin if mem[q].hh.rh=p then begin
print_nl(306);print_int(q);print_char(41);end;
if mem[q].hh.lh=p then begin print_nl(307);print_int(q);print_char(41);
end;end;
for q:=hi_mem_min to mem_end do begin if mem[q].hh.rh=p then begin
print_nl(306);print_int(q);print_char(41);end;
if mem[q].hh.lh=p then begin print_nl(307);print_int(q);print_char(41);
end;end;
[255:]for q:=1 to 3933 do begin if eqtb[q].hh.rh=p then begin print_nl(
501);print_int(q);print_char(41);end;end[:255];
[285:]if save_ptr>0 then for q:=0 to save_ptr-1 do begin if save_stack[q
].hh.rh=p then begin print_nl(546);print_int(q);print_char(41);end;
end[:285];
[933:]for q:=0 to 307 do begin if hyph_list[q]=p then begin print_nl(939
);print_int(q);print_char(41);end;end[:933];end;}
{:172}{174:}procedure short_display(p:integer);var n:integer;
begin while p>mem_min do begin if(p>=hi_mem_min)then begin if p<=mem_end
then begin if mem[p].hh.b0<>font_in_short_display then begin if(mem[p].
hh.b0<0)or(mem[p].hh.b0>font_max)then print_char(42)else{267:}print_esc(
hash[2624+mem[p].hh.b0].rh){:267};print_char(32);
font_in_short_display:=mem[p].hh.b0;end;print(mem[p].hh.b1-0);end;
end else{175:}case mem[p].hh.b0 of 0,1,3,8,4,5,13:print(308);
2:print_char(124);10:if mem[p+1].hh.lh<>0 then print_char(32);
9:print_char(36);6:short_display(mem[p+1].hh.rh);
7:begin short_display(mem[p+1].hh.lh);short_display(mem[p+1].hh.rh);
n:=mem[p].hh.b1;
while n>0 do begin if mem[p].hh.rh<>0 then p:=mem[p].hh.rh;n:=n-1;end;
end;others:end{:175};p:=mem[p].hh.rh;end;end;
{:174}{176:}procedure print_font_and_char(p:integer);
begin if p>mem_end then print_esc(309)else begin if(mem[p].hh.b0<0)or(
mem[p].hh.b0>font_max)then print_char(42)else{267:}print_esc(hash[2624+
mem[p].hh.b0].rh){:267};print_char(32);print(mem[p].hh.b1-0);end;end;
procedure print_mark(p:integer);begin print_char(123);
if(p<hi_mem_min)or(p>mem_end)then print_esc(309)else show_token_list(mem
[p].hh.rh,0,max_print_line-10);print_char(125);end;
procedure print_rule_dimen(d:scaled);
begin if(d=-1073741824)then print_char(42)else print_scaled(d);end;
{:176}{177:}procedure print_glue(d:scaled;order:integer;s:str_number);
begin print_scaled(d);
if(order<0)or(order>3)then print(310)else if order>0 then begin print(
311);while order>1 do begin print_char(108);order:=order-1;end;
end else if s<>0 then print(s);end;
{:177}{178:}procedure print_spec(p:integer;s:str_number);
begin if(p<mem_min)or(p>=lo_mem_max)then print_char(42)else begin
print_scaled(mem[p+1].int);if s<>0 then print(s);
if mem[p+2].int<>0 then begin print(312);
print_glue(mem[p+2].int,mem[p].hh.b0,s);end;
if mem[p+3].int<>0 then begin print(313);
print_glue(mem[p+3].int,mem[p].hh.b1,s);end;end;end;
{:178}{179:}{691:}procedure print_fam_and_char(p:halfword);
begin print_esc(464);print_int(mem[p].hh.b0);print_char(32);
print(mem[p].hh.b1-0);end;procedure print_delimiter(p:halfword);
var a:integer;begin a:=mem[p].qqqq.b0*256+mem[p].qqqq.b1-0;
a:=a*4096+mem[p].qqqq.b2*256+mem[p].qqqq.b3-0;
if a<0 then print_int(a)else print_hex(a);end;
{:691}{692:}procedure show_info;forward;
procedure print_subsidiary_data(p:halfword;c:ASCII_code);
begin if(pool_ptr-str_start[str_ptr])>=depth_threshold then begin if mem
[p].hh.rh<>0 then print(314);end else begin begin str_pool[pool_ptr]:=c;
pool_ptr:=pool_ptr+1;end;temp_ptr:=p;
case mem[p].hh.rh of 1:begin print_ln;print_current_string;
print_fam_and_char(p);end;2:show_info;
3:if mem[p].hh.lh=0 then begin print_ln;print_current_string;print(859);
end else show_info;others:end;pool_ptr:=pool_ptr-1;end;end;
{:692}{694:}procedure print_style(c:integer);
begin case c div 2 of 0:print_esc(860);1:print_esc(861);
2:print_esc(862);3:print_esc(863);others:print(864)end;end;
{:694}{225:}procedure print_skip_param(n:integer);
begin case n of 0:print_esc(376);1:print_esc(377);2:print_esc(378);
3:print_esc(379);4:print_esc(380);5:print_esc(381);6:print_esc(382);
7:print_esc(383);8:print_esc(384);9:print_esc(385);10:print_esc(386);
11:print_esc(387);12:print_esc(388);13:print_esc(389);14:print_esc(390);
15:print_esc(391);16:print_esc(392);17:print_esc(393);
others:print(394)end;end;
{:225}{:179}{182:}procedure show_node_list(p:integer);label 10;
var n:integer;g:real;
begin if(pool_ptr-str_start[str_ptr])>depth_threshold then begin if p>0
then print(314);goto 10;end;n:=0;while p>mem_min do begin print_ln;
print_current_string;if p>mem_end then begin print(315);goto 10;end;
n:=n+1;if n>breadth_max then begin print(316);goto 10;end;
{183:}if(p>=hi_mem_min)then print_font_and_char(p)else case mem[p].hh.b0
of 0,1,13:{184:}begin if mem[p].hh.b0=0 then print_esc(104)else if mem[p
].hh.b0=1 then print_esc(118)else print_esc(318);print(319);
print_scaled(mem[p+3].int);print_char(43);print_scaled(mem[p+2].int);
print(320);print_scaled(mem[p+1].int);
if mem[p].hh.b0=13 then{185:}begin if mem[p].hh.b1<>0 then begin print(
286);print_int(mem[p].hh.b1+1);print(322);end;
if mem[p+6].int<>0 then begin print(323);
print_glue(mem[p+6].int,mem[p+5].hh.b1,0);end;
if mem[p+4].int<>0 then begin print(324);
print_glue(mem[p+4].int,mem[p+5].hh.b0,0);end;
end{:185}else begin{186:}g:=mem[p+6].gr;
if(g<>0.0)and(mem[p+5].hh.b0<>0)then begin print(325);
if mem[p+5].hh.b0=2 then print(326);
if abs(mem[p+6].int)<1048576 then print(327)else if abs(g)>20000.0 then
begin if g>0.0 then print_char(62)else print(328);
print_glue(20000*65536,mem[p+5].hh.b1,0);
end else print_glue(round(65536*g),mem[p+5].hh.b1,0);end{:186};
if mem[p+4].int<>0 then begin print(321);print_scaled(mem[p+4].int);end;
end;begin begin str_pool[pool_ptr]:=46;pool_ptr:=pool_ptr+1;end;
show_node_list(mem[p+5].hh.rh);pool_ptr:=pool_ptr-1;end;end{:184};
2:{187:}begin print_esc(329);print_rule_dimen(mem[p+3].int);
print_char(43);print_rule_dimen(mem[p+2].int);print(320);
print_rule_dimen(mem[p+1].int);end{:187};3:{188:}begin print_esc(330);
print_int(mem[p].hh.b1-0);print(331);print_scaled(mem[p+3].int);
print(332);print_spec(mem[p+4].hh.rh,0);print_char(44);
print_scaled(mem[p+2].int);print(333);print_int(mem[p+1].int);
begin begin str_pool[pool_ptr]:=46;pool_ptr:=pool_ptr+1;end;
show_node_list(mem[p+4].hh.lh);pool_ptr:=pool_ptr-1;end;end{:188};
8:{1356:}case mem[p].hh.b1 of 0:begin print_write_whatsit(1284,p);
print_char(61);
print_file_name(mem[p+1].hh.rh,mem[p+2].hh.lh,mem[p+2].hh.rh);end;
1:begin print_write_whatsit(594,p);print_mark(mem[p+1].hh.rh);end;
2:print_write_whatsit(1285,p);3:begin print_esc(1286);
print_mark(mem[p+1].hh.rh);end;4:begin print_esc(1288);
print_int(mem[p+1].hh.rh);print(1291);print_int(mem[p+1].hh.b0);
print_char(44);print_int(mem[p+1].hh.b1);print_char(41);end;
others:print(1292)end{:1356};
10:{189:}if mem[p].hh.b1>=100 then{190:}begin print_esc(338);
if mem[p].hh.b1=101 then print_char(99)else if mem[p].hh.b1=102 then
print_char(120);print(339);print_spec(mem[p+1].hh.lh,0);
begin begin str_pool[pool_ptr]:=46;pool_ptr:=pool_ptr+1;end;
show_node_list(mem[p+1].hh.rh);pool_ptr:=pool_ptr-1;end;
end{:190}else begin print_esc(334);
if mem[p].hh.b1<>0 then begin print_char(40);
if mem[p].hh.b1<98 then print_skip_param(mem[p].hh.b1-1)else if mem[p].
hh.b1=98 then print_esc(335)else print_esc(336);print_char(41);end;
if mem[p].hh.b1<>98 then begin print_char(32);
if mem[p].hh.b1<98 then print_spec(mem[p+1].hh.lh,0)else print_spec(mem[
p+1].hh.lh,337);end;end{:189};
11:{191:}if mem[p].hh.b1<>99 then begin print_esc(340);
if mem[p].hh.b1<>0 then print_char(32);print_scaled(mem[p+1].int);
if mem[p].hh.b1=2 then print(341);end else begin print_esc(342);
print_scaled(mem[p+1].int);print(337);end{:191};
9:{192:}begin print_esc(343);
if mem[p].hh.b1=0 then print(344)else print(345);
if mem[p+1].int<>0 then begin print(346);print_scaled(mem[p+1].int);end;
end{:192};6:{193:}begin print_font_and_char(p+1);print(347);
if mem[p].hh.b1>1 then print_char(124);
font_in_short_display:=mem[p+1].hh.b0;short_display(mem[p+1].hh.rh);
if odd(mem[p].hh.b1)then print_char(124);print_char(41);end{:193};
12:{194:}begin print_esc(348);print_int(mem[p+1].int);end{:194};
7:{195:}begin print_esc(349);if mem[p].hh.b1>0 then begin print(350);
print_int(mem[p].hh.b1);end;begin begin str_pool[pool_ptr]:=46;
pool_ptr:=pool_ptr+1;end;show_node_list(mem[p+1].hh.lh);
pool_ptr:=pool_ptr-1;end;begin str_pool[pool_ptr]:=124;
pool_ptr:=pool_ptr+1;end;show_node_list(mem[p+1].hh.rh);
pool_ptr:=pool_ptr-1;end{:195};4:{196:}begin print_esc(351);
print_mark(mem[p+1].int);end{:196};5:{197:}begin print_esc(352);
begin begin str_pool[pool_ptr]:=46;pool_ptr:=pool_ptr+1;end;
show_node_list(mem[p+1].int);pool_ptr:=pool_ptr-1;end;end{:197};
{690:}14:print_style(mem[p].hh.b1);15:{695:}begin print_esc(525);
begin str_pool[pool_ptr]:=68;pool_ptr:=pool_ptr+1;end;
show_node_list(mem[p+1].hh.lh);pool_ptr:=pool_ptr-1;
begin str_pool[pool_ptr]:=84;pool_ptr:=pool_ptr+1;end;
show_node_list(mem[p+1].hh.rh);pool_ptr:=pool_ptr-1;
begin str_pool[pool_ptr]:=83;pool_ptr:=pool_ptr+1;end;
show_node_list(mem[p+2].hh.lh);pool_ptr:=pool_ptr-1;
begin str_pool[pool_ptr]:=115;pool_ptr:=pool_ptr+1;end;
show_node_list(mem[p+2].hh.rh);pool_ptr:=pool_ptr-1;end{:695};
16,17,18,19,20,21,22,23,24,27,26,29,28,30,31:{696:}begin case mem[p].hh.
b0 of 16:print_esc(865);17:print_esc(866);18:print_esc(867);
19:print_esc(868);20:print_esc(869);21:print_esc(870);22:print_esc(871);
23:print_esc(872);27:print_esc(873);26:print_esc(874);29:print_esc(539);
24:begin print_esc(533);print_delimiter(p+4);end;
28:begin print_esc(508);print_fam_and_char(p+4);end;
30:begin print_esc(875);print_delimiter(p+1);end;
31:begin print_esc(876);print_delimiter(p+1);end;end;
if mem[p].hh.b1<>0 then if mem[p].hh.b1=1 then print_esc(877)else
print_esc(878);if mem[p].hh.b0<30 then print_subsidiary_data(p+1,46);
print_subsidiary_data(p+2,94);print_subsidiary_data(p+3,95);end{:696};
25:{697:}begin print_esc(879);
if mem[p+1].int=1073741824 then print(880)else print_scaled(mem[p+1].int
);
if(mem[p+4].qqqq.b0<>0)or(mem[p+4].qqqq.b1<>0)or(mem[p+4].qqqq.b2<>0)or(
mem[p+4].qqqq.b3<>0)then begin print(881);print_delimiter(p+4);end;
if(mem[p+5].qqqq.b0<>0)or(mem[p+5].qqqq.b1<>0)or(mem[p+5].qqqq.b2<>0)or(
mem[p+5].qqqq.b3<>0)then begin print(882);print_delimiter(p+5);end;
print_subsidiary_data(p+2,92);print_subsidiary_data(p+3,47);end{:697};
{:690}others:print(317)end{:183};p:=mem[p].hh.rh;end;10:end;
{:182}{198:}procedure show_box(p:halfword);
begin{236:}depth_threshold:=eqtb[5288].int;
breadth_max:=eqtb[5287].int{:236};if breadth_max<=0 then breadth_max:=5;
if pool_ptr+depth_threshold>=pool_size then depth_threshold:=pool_size-
pool_ptr-1;show_node_list(p);print_ln;end;
{:198}{200:}procedure delete_token_ref(p:halfword);
begin if mem[p].hh.lh=0 then flush_list(p)else mem[p].hh.lh:=mem[p].hh.
lh-1;end;{:200}{201:}procedure delete_glue_ref(p:halfword);
begin if mem[p].hh.rh=0 then free_node(p,4)else mem[p].hh.rh:=mem[p].hh.
rh-1;end;{:201}{202:}procedure flush_node_list(p:halfword);label 30;
var q:halfword;begin while p<>0 do begin q:=mem[p].hh.rh;
if(p>=hi_mem_min)then begin mem[p].hh.rh:=avail;avail:=p;
{dyn_used:=dyn_used-1;}
end else begin case mem[p].hh.b0 of 0,1,13:begin flush_node_list(mem[p+5
].hh.rh);free_node(p,7);goto 30;end;2:begin free_node(p,4);goto 30;end;
3:begin flush_node_list(mem[p+4].hh.lh);delete_glue_ref(mem[p+4].hh.rh);
free_node(p,5);goto 30;end;
8:{1358:}begin case mem[p].hh.b1 of 0:free_node(p,3);
1,3:begin delete_token_ref(mem[p+1].hh.rh);free_node(p,2);goto 30;end;
2,4:free_node(p,2);others:confusion(1294)end;goto 30;end{:1358};
10:begin begin if mem[mem[p+1].hh.lh].hh.rh=0 then free_node(mem[p+1].hh
.lh,4)else mem[mem[p+1].hh.lh].hh.rh:=mem[mem[p+1].hh.lh].hh.rh-1;end;
if mem[p+1].hh.rh<>0 then flush_node_list(mem[p+1].hh.rh);end;11,9,12:;
6:flush_node_list(mem[p+1].hh.rh);4:delete_token_ref(mem[p+1].int);
7:begin flush_node_list(mem[p+1].hh.lh);flush_node_list(mem[p+1].hh.rh);
end;5:flush_node_list(mem[p+1].int);{698:}14:begin free_node(p,3);
goto 30;end;15:begin flush_node_list(mem[p+1].hh.lh);
flush_node_list(mem[p+1].hh.rh);flush_node_list(mem[p+2].hh.lh);
flush_node_list(mem[p+2].hh.rh);free_node(p,3);goto 30;end;
16,17,18,19,20,21,22,23,24,27,26,29,28:begin if mem[p+1].hh.rh>=2 then
flush_node_list(mem[p+1].hh.lh);
if mem[p+2].hh.rh>=2 then flush_node_list(mem[p+2].hh.lh);
if mem[p+3].hh.rh>=2 then flush_node_list(mem[p+3].hh.lh);
if mem[p].hh.b0=24 then free_node(p,5)else if mem[p].hh.b0=28 then
free_node(p,5)else free_node(p,4);goto 30;end;
30,31:begin free_node(p,4);goto 30;end;
25:begin flush_node_list(mem[p+2].hh.lh);
flush_node_list(mem[p+3].hh.lh);free_node(p,6);goto 30;end;
{:698}others:confusion(353)end;free_node(p,2);30:end;p:=q;end;end;
{:202}{204:}function copy_node_list(p:halfword):halfword;var h:halfword;
q:halfword;r:halfword;words:0..5;begin h:=get_avail;q:=h;
while p<>0 do begin{205:}words:=1;
if(p>=hi_mem_min)then r:=get_avail else{206:}case mem[p].hh.b0 of 0,1,13
:begin r:=get_node(7);mem[r+6]:=mem[p+6];mem[r+5]:=mem[p+5];
mem[r+5].hh.rh:=copy_node_list(mem[p+5].hh.rh);words:=5;end;
2:begin r:=get_node(4);words:=4;end;3:begin r:=get_node(5);
mem[r+4]:=mem[p+4];
mem[mem[p+4].hh.rh].hh.rh:=mem[mem[p+4].hh.rh].hh.rh+1;
mem[r+4].hh.lh:=copy_node_list(mem[p+4].hh.lh);words:=4;end;
8:{1357:}case mem[p].hh.b1 of 0:begin r:=get_node(3);words:=3;end;
1,3:begin r:=get_node(2);
mem[mem[p+1].hh.rh].hh.lh:=mem[mem[p+1].hh.rh].hh.lh+1;words:=2;end;
2,4:begin r:=get_node(2);words:=2;end;others:confusion(1293)end{:1357};
10:begin r:=get_node(2);
mem[mem[p+1].hh.lh].hh.rh:=mem[mem[p+1].hh.lh].hh.rh+1;
mem[r+1].hh.lh:=mem[p+1].hh.lh;
mem[r+1].hh.rh:=copy_node_list(mem[p+1].hh.rh);end;
11,9,12:begin r:=get_node(2);words:=2;end;6:begin r:=get_node(2);
mem[r+1]:=mem[p+1];mem[r+1].hh.rh:=copy_node_list(mem[p+1].hh.rh);end;
7:begin r:=get_node(2);mem[r+1].hh.lh:=copy_node_list(mem[p+1].hh.lh);
mem[r+1].hh.rh:=copy_node_list(mem[p+1].hh.rh);end;
4:begin r:=get_node(2);
mem[mem[p+1].int].hh.lh:=mem[mem[p+1].int].hh.lh+1;words:=2;end;
5:begin r:=get_node(2);mem[r+1].int:=copy_node_list(mem[p+1].int);end;
others:confusion(354)end{:206};while words>0 do begin words:=words-1;
mem[r+words]:=mem[p+words];end{:205};mem[q].hh.rh:=r;q:=r;
p:=mem[p].hh.rh;end;mem[q].hh.rh:=0;q:=mem[h].hh.rh;
begin mem[h].hh.rh:=avail;avail:=h;{dyn_used:=dyn_used-1;}end;
copy_node_list:=q;end;{:204}{211:}procedure print_mode(m:integer);
begin if m>0 then case m div(101)of 0:print(355);1:print(356);
2:print(357);
end else if m=0 then print(358)else case(-m)div(101)of 0:print(359);
1:print(360);2:print(343);end;print(361);end;
{:211}{216:}procedure push_nest;
begin if nest_ptr>max_nest_stack then begin max_nest_stack:=nest_ptr;
if nest_ptr=nest_size then overflow(362,nest_size);end;
nest[nest_ptr]:=cur_list;nest_ptr:=nest_ptr+1;
cur_list.head_field:=get_avail;cur_list.tail_field:=cur_list.head_field;
cur_list.pg_field:=0;cur_list.ml_field:=line;end;
{:216}{217:}procedure pop_nest;
begin begin mem[cur_list.head_field].hh.rh:=avail;
avail:=cur_list.head_field;{dyn_used:=dyn_used-1;}end;
nest_ptr:=nest_ptr-1;cur_list:=nest[nest_ptr];end;
{:217}{218:}procedure print_totals;forward;procedure show_activities;
var p:0..nest_size;m:-203..203;a:memory_word;q,r:halfword;t:integer;
begin nest[nest_ptr]:=cur_list;print_nl(338);print_ln;
for p:=nest_ptr downto 0 do begin m:=nest[p].mode_field;
a:=nest[p].aux_field;print_nl(363);print_mode(m);print(364);
print_int(abs(nest[p].ml_field));
if m=102 then if nest[p].pg_field<>8585216 then begin print(365);
print_int(nest[p].pg_field mod 65536);print(366);
print_int(nest[p].pg_field div 4194304);print_char(44);
print_int((nest[p].pg_field div 65536)mod 64);print_char(41);end;
if nest[p].ml_field<0 then print(367);
if p=0 then begin{986:}if 29998<>page_tail then begin print_nl(979);
if output_active then print(980);show_box(mem[29998].hh.rh);
if page_contents>0 then begin print_nl(981);print_totals;print_nl(982);
print_scaled(page_so_far[0]);r:=mem[30000].hh.rh;
while r<>30000 do begin print_ln;print_esc(330);t:=mem[r].hh.b1-0;
print_int(t);print(983);
if eqtb[5318+t].int=1000 then t:=mem[r+3].int else t:=x_over_n(mem[r+3].
int,1000)*eqtb[5318+t].int;print_scaled(t);
if mem[r].hh.b0=1 then begin q:=29998;t:=0;repeat q:=mem[q].hh.rh;
if(mem[q].hh.b0=3)and(mem[q].hh.b1=mem[r].hh.b1)then t:=t+1;
until q=mem[r+1].hh.lh;print(984);print_int(t);print(985);end;
r:=mem[r].hh.rh;end;end;end{:986};
if mem[29999].hh.rh<>0 then print_nl(368);end;
show_box(mem[nest[p].head_field].hh.rh);
{219:}case abs(m)div(101)of 0:begin print_nl(369);
if a.int<=-65536000 then print(370)else print_scaled(a.int);
if nest[p].pg_field<>0 then begin print(371);
print_int(nest[p].pg_field);print(372);
if nest[p].pg_field<>1 then print_char(115);end;end;
1:begin print_nl(373);print_int(a.hh.lh);
if m>0 then if a.hh.rh>0 then begin print(374);print_int(a.hh.rh);end;
end;2:if a.int<>0 then begin print(375);show_box(a.int);end;end{:219};
end;end;{:218}{237:}procedure print_param(n:integer);
begin case n of 0:print_esc(420);1:print_esc(421);2:print_esc(422);
3:print_esc(423);4:print_esc(424);5:print_esc(425);6:print_esc(426);
7:print_esc(427);8:print_esc(428);9:print_esc(429);10:print_esc(430);
11:print_esc(431);12:print_esc(432);13:print_esc(433);14:print_esc(434);
15:print_esc(435);16:print_esc(436);17:print_esc(437);18:print_esc(438);
19:print_esc(439);20:print_esc(440);21:print_esc(441);22:print_esc(442);
23:print_esc(443);24:print_esc(444);25:print_esc(445);26:print_esc(446);
27:print_esc(447);28:print_esc(448);29:print_esc(449);30:print_esc(450);
31:print_esc(451);32:print_esc(452);33:print_esc(453);34:print_esc(454);
35:print_esc(455);36:print_esc(456);37:print_esc(457);38:print_esc(458);
39:print_esc(459);40:print_esc(460);41:print_esc(461);42:print_esc(462);
43:print_esc(463);44:print_esc(464);45:print_esc(465);46:print_esc(466);
47:print_esc(467);48:print_esc(468);49:print_esc(469);50:print_esc(470);
51:print_esc(471);52:print_esc(472);53:print_esc(473);54:print_esc(474);
others:print(475)end;end;{:237}{241:}procedure fix_date_and_time;
begin eqtb[5283].int:=12*60;eqtb[5284].int:=4;eqtb[5285].int:=7;
eqtb[5286].int:=1776;end;{:241}{245:}procedure begin_diagnostic;
begin old_setting:=selector;
if(eqtb[5292].int<=0)and(selector=19)then begin selector:=selector-1;
if history=0 then history:=1;end;end;
procedure end_diagnostic(blank_line:boolean);begin print_nl(338);
if blank_line then print_ln;selector:=old_setting;end;
{:245}{247:}procedure print_length_param(n:integer);
begin case n of 0:print_esc(478);1:print_esc(479);2:print_esc(480);
3:print_esc(481);4:print_esc(482);5:print_esc(483);6:print_esc(484);
7:print_esc(485);8:print_esc(486);9:print_esc(487);10:print_esc(488);
11:print_esc(489);12:print_esc(490);13:print_esc(491);14:print_esc(492);
15:print_esc(493);16:print_esc(494);17:print_esc(495);18:print_esc(496);
19:print_esc(497);20:print_esc(498);others:print(499)end;end;
{:247}{252:}{298:}procedure print_cmd_chr(cmd:quarterword;
chr_code:halfword);begin case cmd of 1:begin print(557);print(chr_code);
end;2:begin print(558);print(chr_code);end;3:begin print(559);
print(chr_code);end;6:begin print(560);print(chr_code);end;
7:begin print(561);print(chr_code);end;8:begin print(562);
print(chr_code);end;9:print(563);10:begin print(564);print(chr_code);
end;11:begin print(565);print(chr_code);end;12:begin print(566);
print(chr_code);end;
{227:}75,76:if chr_code<2900 then print_skip_param(chr_code-2882)else if
chr_code<3156 then begin print_esc(395);print_int(chr_code-2900);
end else begin print_esc(396);print_int(chr_code-3156);end;
{:227}{231:}72:if chr_code>=3422 then begin print_esc(407);
print_int(chr_code-3422);end else case chr_code of 3413:print_esc(398);
3414:print_esc(399);3415:print_esc(400);3416:print_esc(401);
3417:print_esc(402);3418:print_esc(403);3419:print_esc(404);
3420:print_esc(405);others:print_esc(406)end;
{:231}{239:}73:if chr_code<5318 then print_param(chr_code-5263)else
begin print_esc(476);print_int(chr_code-5318);end;
{:239}{249:}74:if chr_code<5851 then print_length_param(chr_code-5830)
else begin print_esc(500);print_int(chr_code-5851);end;
{:249}{266:}45:print_esc(508);90:print_esc(509);40:print_esc(510);
41:print_esc(511);77:print_esc(519);61:print_esc(512);42:print_esc(531);
16:print_esc(513);107:print_esc(504);88:print_esc(518);
15:print_esc(514);92:print_esc(515);67:print_esc(505);62:print_esc(516);
64:print_esc(32);102:print_esc(517);32:print_esc(520);36:print_esc(521);
39:print_esc(522);37:print_esc(330);44:print_esc(47);18:print_esc(351);
46:print_esc(523);17:print_esc(524);54:print_esc(525);91:print_esc(526);
34:print_esc(527);65:print_esc(528);103:print_esc(529);
55:print_esc(335);63:print_esc(530);66:print_esc(533);96:print_esc(534);
0:print_esc(535);98:print_esc(536);80:print_esc(532);84:print_esc(408);
109:print_esc(537);71:print_esc(407);38:print_esc(352);
33:print_esc(538);56:print_esc(539);35:print_esc(540);
{:266}{335:}13:print_esc(597);
{:335}{377:}104:if chr_code=0 then print_esc(629)else print_esc(630);
{:377}{385:}110:case chr_code of 1:print_esc(632);2:print_esc(633);
3:print_esc(634);4:print_esc(635);others:print_esc(631)end;
{:385}{412:}89:if chr_code=0 then print_esc(476)else if chr_code=1 then
print_esc(500)else if chr_code=2 then print_esc(395)else print_esc(396);
{:412}{417:}79:if chr_code=1 then print_esc(669)else print_esc(668);
82:if chr_code=0 then print_esc(670)else print_esc(671);
83:if chr_code=1 then print_esc(672)else if chr_code=3 then print_esc(
673)else print_esc(674);70:case chr_code of 0:print_esc(675);
1:print_esc(676);2:print_esc(677);3:print_esc(678);
others:print_esc(679)end;
{:417}{469:}108:case chr_code of 0:print_esc(735);1:print_esc(736);
2:print_esc(737);3:print_esc(738);4:print_esc(739);
others:print_esc(740)end;
{:469}{488:}105:case chr_code of 1:print_esc(757);2:print_esc(758);
3:print_esc(759);4:print_esc(760);5:print_esc(761);6:print_esc(762);
7:print_esc(763);8:print_esc(764);9:print_esc(765);10:print_esc(766);
11:print_esc(767);12:print_esc(768);13:print_esc(769);14:print_esc(770);
15:print_esc(771);16:print_esc(772);others:print_esc(756)end;
{:488}{492:}106:if chr_code=2 then print_esc(773)else if chr_code=4 then
print_esc(774)else print_esc(775);
{:492}{781:}4:if chr_code=256 then print_esc(897)else begin print(901);
print(chr_code);end;
5:if chr_code=257 then print_esc(898)else print_esc(899);
{:781}{984:}81:case chr_code of 0:print_esc(969);1:print_esc(970);
2:print_esc(971);3:print_esc(972);4:print_esc(973);5:print_esc(974);
6:print_esc(975);others:print_esc(976)end;
{:984}{1053:}14:if chr_code=1 then print_esc(1025)else print_esc(1024);
{:1053}{1059:}26:case chr_code of 4:print_esc(1026);0:print_esc(1027);
1:print_esc(1028);2:print_esc(1029);others:print_esc(1030)end;
27:case chr_code of 4:print_esc(1031);0:print_esc(1032);
1:print_esc(1033);2:print_esc(1034);others:print_esc(1035)end;
28:print_esc(336);29:print_esc(340);30:print_esc(342);
{:1059}{1072:}21:if chr_code=1 then print_esc(1053)else print_esc(1054);
22:if chr_code=1 then print_esc(1055)else print_esc(1056);
20:case chr_code of 0:print_esc(409);1:print_esc(1057);
2:print_esc(1058);3:print_esc(964);4:print_esc(1059);5:print_esc(966);
others:print_esc(1060)end;
31:if chr_code=100 then print_esc(1062)else if chr_code=101 then
print_esc(1063)else if chr_code=102 then print_esc(1064)else print_esc(
1061);
{:1072}{1089:}43:if chr_code=0 then print_esc(1080)else print_esc(1079);
{:1089}{1108:}25:if chr_code=10 then print_esc(1091)else if chr_code=11
then print_esc(1090)else print_esc(1089);
23:if chr_code=1 then print_esc(1093)else print_esc(1092);
24:if chr_code=1 then print_esc(1095)else print_esc(1094);
{:1108}{1115:}47:if chr_code=1 then print_esc(45)else print_esc(349);
{:1115}{1143:}48:if chr_code=1 then print_esc(1127)else print_esc(1126);
{:1143}{1157:}50:case chr_code of 16:print_esc(865);17:print_esc(866);
18:print_esc(867);19:print_esc(868);20:print_esc(869);21:print_esc(870);
22:print_esc(871);23:print_esc(872);26:print_esc(874);
others:print_esc(873)end;
51:if chr_code=1 then print_esc(877)else if chr_code=2 then print_esc(
878)else print_esc(1128);{:1157}{1170:}53:print_style(chr_code);
{:1170}{1179:}52:case chr_code of 1:print_esc(1147);2:print_esc(1148);
3:print_esc(1149);4:print_esc(1150);5:print_esc(1151);
others:print_esc(1146)end;
{:1179}{1189:}49:if chr_code=30 then print_esc(875)else print_esc(876);
{:1189}{1209:}93:if chr_code=1 then print_esc(1170)else if chr_code=2
then print_esc(1171)else print_esc(1172);
97:if chr_code=0 then print_esc(1173)else if chr_code=1 then print_esc(
1174)else if chr_code=2 then print_esc(1175)else print_esc(1176);
{:1209}{1220:}94:if chr_code<>0 then print_esc(1191)else print_esc(1190)
;{:1220}{1223:}95:case chr_code of 0:print_esc(1192);1:print_esc(1193);
2:print_esc(1194);3:print_esc(1195);4:print_esc(1196);5:print_esc(1197);
others:print_esc(1198)end;68:begin print_esc(513);print_hex(chr_code);
end;69:begin print_esc(524);print_hex(chr_code);end;
{:1223}{1231:}85:if chr_code=3983 then print_esc(415)else if chr_code=
5007 then print_esc(419)else if chr_code=4239 then print_esc(416)else if
chr_code=4495 then print_esc(417)else if chr_code=4751 then print_esc(
418)else print_esc(477);86:print_size(chr_code-3935);
{:1231}{1251:}99:if chr_code=1 then print_esc(952)else print_esc(940);
{:1251}{1255:}78:if chr_code=0 then print_esc(1216)else print_esc(1217);
{:1255}{1261:}87:begin print(1225);slow_print(font_name[chr_code]);
if font_size[chr_code]<>font_dsize[chr_code]then begin print(741);
print_scaled(font_size[chr_code]);print(397);end;end;
{:1261}{1263:}100:case chr_code of 0:print_esc(274);1:print_esc(275);
2:print_esc(276);others:print_esc(1226)end;
{:1263}{1273:}60:if chr_code=0 then print_esc(1228)else print_esc(1227);
{:1273}{1278:}58:if chr_code=0 then print_esc(1229)else print_esc(1230);
{:1278}{1287:}57:if chr_code=4239 then print_esc(1236)else print_esc(
1237);{:1287}{1292:}19:case chr_code of 1:print_esc(1239);
2:print_esc(1240);3:print_esc(1241);others:print_esc(1238)end;
{:1292}{1295:}101:print(1248);111:print(1249);112:print_esc(1250);
113:print_esc(1251);114:begin print_esc(1170);print_esc(1251);end;
115:print_esc(1252);{:1295}{1346:}59:case chr_code of 0:print_esc(1284);
1:print_esc(594);2:print_esc(1285);3:print_esc(1286);4:print_esc(1287);
5:print_esc(1288);others:print(1289)end;{:1346}others:print(567)end;end;
{:298}{procedure show_eqtb(n:halfword);
begin if n<1 then print_char(63)else if n<2882 then[223:]begin sprint_cs
(n);print_char(61);print_cmd_chr(eqtb[n].hh.b0,eqtb[n].hh.rh);
if eqtb[n].hh.b0>=111 then begin print_char(58);
show_token_list(mem[eqtb[n].hh.rh].hh.rh,0,32);end;
end[:223]else if n<3412 then[229:]if n<2900 then begin print_skip_param(
n-2882);print_char(61);
if n<2897 then print_spec(eqtb[n].hh.rh,397)else print_spec(eqtb[n].hh.
rh,337);end else if n<3156 then begin print_esc(395);print_int(n-2900);
print_char(61);print_spec(eqtb[n].hh.rh,397);
end else begin print_esc(396);print_int(n-3156);print_char(61);
print_spec(eqtb[n].hh.rh,337);
end[:229]else if n<5263 then[233:]if n=3412 then begin print_esc(408);
print_char(61);
if eqtb[3412].hh.rh=0 then print_char(48)else print_int(mem[eqtb[3412].
hh.rh].hh.lh);end else if n<3422 then begin print_cmd_chr(72,n);
print_char(61);
if eqtb[n].hh.rh<>0 then show_token_list(mem[eqtb[n].hh.rh].hh.rh,0,32);
end else if n<3678 then begin print_esc(407);print_int(n-3422);
print_char(61);
if eqtb[n].hh.rh<>0 then show_token_list(mem[eqtb[n].hh.rh].hh.rh,0,32);
end else if n<3934 then begin print_esc(409);print_int(n-3678);
print_char(61);
if eqtb[n].hh.rh=0 then print(410)else begin depth_threshold:=0;
breadth_max:=1;show_node_list(eqtb[n].hh.rh);end;
end else if n<3983 then[234:]begin if n=3934 then print(411)else if n<
3951 then begin print_esc(412);print_int(n-3935);
end else if n<3967 then begin print_esc(413);print_int(n-3951);
end else begin print_esc(414);print_int(n-3967);end;print_char(61);
print_esc(hash[2624+eqtb[n].hh.rh].rh);
end[:234]else[235:]if n<5007 then begin if n<4239 then begin print_esc(
415);print_int(n-3983);end else if n<4495 then begin print_esc(416);
print_int(n-4239);end else if n<4751 then begin print_esc(417);
print_int(n-4495);end else begin print_esc(418);print_int(n-4751);end;
print_char(61);print_int(eqtb[n].hh.rh);end else begin print_esc(419);
print_int(n-5007);print_char(61);print_int(eqtb[n].hh.rh-0);
end[:235][:233]else if n<5830 then[242:]begin if n<5318 then print_param
(n-5263)else if n<5574 then begin print_esc(476);print_int(n-5318);
end else begin print_esc(477);print_int(n-5574);end;print_char(61);
print_int(eqtb[n].int);
end[:242]else if n<=6106 then[251:]begin if n<5851 then
print_length_param(n-5830)else begin print_esc(500);print_int(n-5851);
end;print_char(61);print_scaled(eqtb[n].int);print(397);
end[:251]else print_char(63);end;}
{:252}{259:}function id_lookup(j,l:integer):halfword;label 40;
var h:integer;d:integer;p:halfword;k:halfword;begin{261:}h:=buffer[j];
for k:=j+1 to j+l-1 do begin h:=h+h+buffer[k];
while h>=1777 do h:=h-1777;end{:261};p:=h+514;
while true do begin if hash[p].rh>0 then if(str_start[hash[p].rh+1]-
str_start[hash[p].rh])=l then if str_eq_buf(hash[p].rh,j)then goto 40;
if hash[p].lh=0 then begin if no_new_control_sequence then p:=2881 else
{260:}begin if hash[p].rh>0 then begin repeat if(hash_used=514)then
overflow(503,2100);hash_used:=hash_used-1;until hash[hash_used].rh=0;
hash[p].lh:=hash_used;p:=hash_used;end;
begin if pool_ptr+l>pool_size then overflow(257,pool_size-init_pool_ptr)
;end;d:=(pool_ptr-str_start[str_ptr]);
while pool_ptr>str_start[str_ptr]do begin pool_ptr:=pool_ptr-1;
str_pool[pool_ptr+l]:=str_pool[pool_ptr];end;
for k:=j to j+l-1 do begin str_pool[pool_ptr]:=buffer[k];
pool_ptr:=pool_ptr+1;end;hash[p].rh:=make_string;pool_ptr:=pool_ptr+d;
{cs_count:=cs_count+1;}end{:260};goto 40;end;p:=hash[p].lh;end;
40:id_lookup:=p;end;{:259}{264:}procedure primitive(s:str_number;
c:quarterword;o:halfword);var k:pool_pointer;j:small_number;
l:small_number;
begin if s<256 then cur_val:=s+257 else begin k:=str_start[s];
l:=str_start[s+1]-k;for j:=0 to l-1 do buffer[j]:=str_pool[k+j];
cur_val:=id_lookup(0,l);begin str_ptr:=str_ptr-1;
pool_ptr:=str_start[str_ptr];end;hash[cur_val].rh:=s;end;
eqtb[cur_val].hh.b1:=1;eqtb[cur_val].hh.b0:=c;eqtb[cur_val].hh.rh:=o;
end;{:264}{274:}procedure new_save_level(c:group_code);
begin if save_ptr>max_save_stack then begin max_save_stack:=save_ptr;
if max_save_stack>save_size-6 then overflow(541,save_size);end;
save_stack[save_ptr].hh.b0:=3;save_stack[save_ptr].hh.b1:=cur_group;
save_stack[save_ptr].hh.rh:=cur_boundary;
if cur_level=255 then overflow(542,255);cur_boundary:=save_ptr;
cur_level:=cur_level+1;save_ptr:=save_ptr+1;cur_group:=c;end;
{:274}{275:}procedure eq_destroy(w:memory_word);var q:halfword;
begin case w.hh.b0 of 111,112,113,114:delete_token_ref(w.hh.rh);
117:delete_glue_ref(w.hh.rh);118:begin q:=w.hh.rh;
if q<>0 then free_node(q,mem[q].hh.lh+mem[q].hh.lh+1);end;
119:flush_node_list(w.hh.rh);others:end;end;
{:275}{276:}procedure eq_save(p:halfword;l:quarterword);
begin if save_ptr>max_save_stack then begin max_save_stack:=save_ptr;
if max_save_stack>save_size-6 then overflow(541,save_size);end;
if l=0 then save_stack[save_ptr].hh.b0:=1 else begin save_stack[save_ptr
]:=eqtb[p];save_ptr:=save_ptr+1;save_stack[save_ptr].hh.b0:=0;end;
save_stack[save_ptr].hh.b1:=l;save_stack[save_ptr].hh.rh:=p;
save_ptr:=save_ptr+1;end;{:276}{277:}procedure eq_define(p:halfword;
t:quarterword;e:halfword);
begin if eqtb[p].hh.b1=cur_level then eq_destroy(eqtb[p])else if
cur_level>1 then eq_save(p,eqtb[p].hh.b1);eqtb[p].hh.b1:=cur_level;
eqtb[p].hh.b0:=t;eqtb[p].hh.rh:=e;end;
{:277}{278:}procedure eq_word_define(p:halfword;w:integer);
begin if xeq_level[p]<>cur_level then begin eq_save(p,xeq_level[p]);
xeq_level[p]:=cur_level;end;eqtb[p].int:=w;end;
{:278}{279:}procedure geq_define(p:halfword;t:quarterword;e:halfword);
begin eq_destroy(eqtb[p]);eqtb[p].hh.b1:=1;eqtb[p].hh.b0:=t;
eqtb[p].hh.rh:=e;end;procedure geq_word_define(p:halfword;w:integer);
begin eqtb[p].int:=w;xeq_level[p]:=1;end;
{:279}{280:}procedure save_for_after(t:halfword);
begin if cur_level>1 then begin if save_ptr>max_save_stack then begin
max_save_stack:=save_ptr;
if max_save_stack>save_size-6 then overflow(541,save_size);end;
save_stack[save_ptr].hh.b0:=2;save_stack[save_ptr].hh.b1:=0;
save_stack[save_ptr].hh.rh:=t;save_ptr:=save_ptr+1;end;end;
{:280}{281:}{284:}{procedure restore_trace(p:halfword;s:str_number);
begin begin_diagnostic;print_char(123);print(s);print_char(32);
show_eqtb(p);print_char(125);end_diagnostic(false);end;}
{:284}procedure back_input;forward;procedure unsave;label 30;
var p:halfword;l:quarterword;t:halfword;
begin if cur_level>1 then begin cur_level:=cur_level-1;
{282:}while true do begin save_ptr:=save_ptr-1;
if save_stack[save_ptr].hh.b0=3 then goto 30;
p:=save_stack[save_ptr].hh.rh;
if save_stack[save_ptr].hh.b0=2 then{326:}begin t:=cur_tok;cur_tok:=p;
back_input;cur_tok:=t;
end{:326}else begin if save_stack[save_ptr].hh.b0=0 then begin l:=
save_stack[save_ptr].hh.b1;save_ptr:=save_ptr-1;
end else save_stack[save_ptr]:=eqtb[2881];
{283:}if p<5263 then if eqtb[p].hh.b1=1 then begin eq_destroy(save_stack
[save_ptr]);{if eqtb[5300].int>0 then restore_trace(p,544);}
end else begin eq_destroy(eqtb[p]);eqtb[p]:=save_stack[save_ptr];
{if eqtb[5300].int>0 then restore_trace(p,545);}
end else if xeq_level[p]<>1 then begin eqtb[p]:=save_stack[save_ptr];
xeq_level[p]:=l;{if eqtb[5300].int>0 then restore_trace(p,545);}
end else begin{if eqtb[5300].int>0 then restore_trace(p,544);}end{:283};
end;end;30:cur_group:=save_stack[save_ptr].hh.b1;
cur_boundary:=save_stack[save_ptr].hh.rh{:282};end else confusion(543);
end;{:281}{288:}procedure prepare_mag;
begin if(mag_set>0)and(eqtb[5280].int<>mag_set)then begin begin if
interaction=3 then;print_nl(262);print(547);end;
print_int(eqtb[5280].int);print(548);print_nl(549);begin help_ptr:=2;
help_line[1]:=550;help_line[0]:=551;end;int_error(mag_set);
geq_word_define(5280,mag_set);end;
if(eqtb[5280].int<=0)or(eqtb[5280].int>32768)then begin begin if
interaction=3 then;print_nl(262);print(552);end;begin help_ptr:=1;
help_line[0]:=553;end;int_error(eqtb[5280].int);
geq_word_define(5280,1000);end;mag_set:=eqtb[5280].int;end;
{:288}{295:}procedure token_show(p:halfword);
begin if p<>0 then show_token_list(mem[p].hh.rh,0,10000000);end;
{:295}{296:}procedure print_meaning;
begin print_cmd_chr(cur_cmd,cur_chr);
if cur_cmd>=111 then begin print_char(58);print_ln;token_show(cur_chr);
end else if cur_cmd=110 then begin print_char(58);print_ln;
token_show(cur_mark[cur_chr]);end;end;
{:296}{299:}procedure show_cur_cmd_chr;begin begin_diagnostic;
print_nl(123);
if cur_list.mode_field<>shown_mode then begin print_mode(cur_list.
mode_field);print(568);shown_mode:=cur_list.mode_field;end;
print_cmd_chr(cur_cmd,cur_chr);print_char(125);end_diagnostic(false);
end;{:299}{311:}procedure show_context;label 30;var old_setting:0..21;
nn:integer;bottom_line:boolean;{315:}i:0..buf_size;j:0..buf_size;
l:0..half_error_line;m:integer;n:0..error_line;p:integer;q:integer;
{:315}begin base_ptr:=input_ptr;input_stack[base_ptr]:=cur_input;nn:=-1;
bottom_line:=false;while true do begin cur_input:=input_stack[base_ptr];
if(cur_input.state_field<>0)then if(cur_input.name_field>17)or(base_ptr=
0)then bottom_line:=true;
if(base_ptr=input_ptr)or bottom_line or(nn<eqtb[5317].int)then{312:}
begin if(base_ptr=input_ptr)or(cur_input.state_field<>0)or(cur_input.
index_field<>3)or(cur_input.loc_field<>0)then begin tally:=0;
old_setting:=selector;
if cur_input.state_field<>0 then begin{313:}if cur_input.name_field<=17
then if(cur_input.name_field=0)then if base_ptr=0 then print_nl(574)else
print_nl(575)else begin print_nl(576);
if cur_input.name_field=17 then print_char(42)else print_int(cur_input.
name_field-1);print_char(62);end else begin print_nl(577);
print_int(line);end;print_char(32){:313};{318:}begin l:=tally;tally:=0;
selector:=20;trick_count:=1000000;end;
if buffer[cur_input.limit_field]=eqtb[5311].int then j:=cur_input.
limit_field else j:=cur_input.limit_field+1;
if j>0 then for i:=cur_input.start_field to j-1 do begin if i=cur_input.
loc_field then begin first_count:=tally;
trick_count:=tally+1+error_line-half_error_line;
if trick_count<error_line then trick_count:=error_line;end;
print(buffer[i]);end{:318};
end else begin{314:}case cur_input.index_field of 0:print_nl(578);
1,2:print_nl(579);
3:if cur_input.loc_field=0 then print_nl(580)else print_nl(581);
4:print_nl(582);5:begin print_ln;print_cs(cur_input.name_field);end;
6:print_nl(583);7:print_nl(584);8:print_nl(585);9:print_nl(586);
10:print_nl(587);11:print_nl(588);12:print_nl(589);13:print_nl(590);
14:print_nl(591);15:print_nl(592);others:print_nl(63)end{:314};
{319:}begin l:=tally;tally:=0;selector:=20;trick_count:=1000000;end;
if cur_input.index_field<5 then show_token_list(cur_input.start_field,
cur_input.loc_field,100000)else show_token_list(mem[cur_input.
start_field].hh.rh,cur_input.loc_field,100000){:319};end;
selector:=old_setting;
{317:}if trick_count=1000000 then begin first_count:=tally;
trick_count:=tally+1+error_line-half_error_line;
if trick_count<error_line then trick_count:=error_line;end;
if tally<trick_count then m:=tally-first_count else m:=trick_count-
first_count;if l+first_count<=half_error_line then begin p:=0;
n:=l+first_count;end else begin print(277);
p:=l+first_count-half_error_line+3;n:=half_error_line;end;
for q:=p to first_count-1 do print_char(trick_buf[q mod error_line]);
print_ln;for q:=1 to n do print_char(32);
if m+n<=error_line then p:=first_count+m else p:=first_count+(error_line
-n-3);
for q:=first_count to p-1 do print_char(trick_buf[q mod error_line]);
if m+n>error_line then print(277){:317};nn:=nn+1;end;
end{:312}else if nn=eqtb[5317].int then begin print_nl(277);nn:=nn+1;
end;if bottom_line then goto 30;base_ptr:=base_ptr-1;end;
30:cur_input:=input_stack[input_ptr];end;
{:311}{323:}procedure begin_token_list(p:halfword;t:quarterword);
begin begin if input_ptr>max_in_stack then begin max_in_stack:=input_ptr
;if input_ptr=stack_size then overflow(593,stack_size);end;
input_stack[input_ptr]:=cur_input;input_ptr:=input_ptr+1;end;
cur_input.state_field:=0;cur_input.start_field:=p;
cur_input.index_field:=t;
if t>=5 then begin mem[p].hh.lh:=mem[p].hh.lh+1;
if t=5 then cur_input.limit_field:=param_ptr else begin cur_input.
loc_field:=mem[p].hh.rh;if eqtb[5293].int>1 then begin begin_diagnostic;
print_nl(338);case t of 14:print_esc(351);15:print_esc(594);
others:print_cmd_chr(72,t+3407)end;print(556);token_show(p);
end_diagnostic(false);end;end;end else cur_input.loc_field:=p;end;
{:323}{324:}procedure end_token_list;
begin if cur_input.index_field>=3 then begin if cur_input.index_field<=4
then flush_list(cur_input.start_field)else begin delete_token_ref(
cur_input.start_field);
if cur_input.index_field=5 then while param_ptr>cur_input.limit_field do
begin param_ptr:=param_ptr-1;flush_list(param_stack[param_ptr]);end;end;
end else if cur_input.index_field=1 then if align_state>500000 then
align_state:=0 else fatal_error(595);begin input_ptr:=input_ptr-1;
cur_input:=input_stack[input_ptr];end;
begin if interrupt<>0 then pause_for_instructions;end;end;
{:324}{325:}procedure back_input;var p:halfword;
begin while(cur_input.state_field=0)and(cur_input.loc_field=0)and(
cur_input.index_field<>2)do end_token_list;p:=get_avail;
mem[p].hh.lh:=cur_tok;
if cur_tok<768 then if cur_tok<512 then align_state:=align_state-1 else
align_state:=align_state+1;
begin if input_ptr>max_in_stack then begin max_in_stack:=input_ptr;
if input_ptr=stack_size then overflow(593,stack_size);end;
input_stack[input_ptr]:=cur_input;input_ptr:=input_ptr+1;end;
cur_input.state_field:=0;cur_input.start_field:=p;
cur_input.index_field:=3;cur_input.loc_field:=p;end;
{:325}{327:}procedure back_error;begin OK_to_interrupt:=false;
back_input;OK_to_interrupt:=true;error;end;procedure ins_error;
begin OK_to_interrupt:=false;back_input;cur_input.index_field:=4;
OK_to_interrupt:=true;error;end;
{:327}{328:}procedure begin_file_reading;
begin if in_open=max_in_open then overflow(596,max_in_open);
if first=buf_size then overflow(256,buf_size);in_open:=in_open+1;
begin if input_ptr>max_in_stack then begin max_in_stack:=input_ptr;
if input_ptr=stack_size then overflow(593,stack_size);end;
input_stack[input_ptr]:=cur_input;input_ptr:=input_ptr+1;end;
cur_input.index_field:=in_open;line_stack[cur_input.index_field]:=line;
cur_input.start_field:=first;cur_input.state_field:=1;
cur_input.name_field:=0;end;{:328}{329:}procedure end_file_reading;
begin first:=cur_input.start_field;
line:=line_stack[cur_input.index_field];
if cur_input.name_field>17 then a_close(input_file[cur_input.index_field
]);begin input_ptr:=input_ptr-1;cur_input:=input_stack[input_ptr];end;
in_open:=in_open-1;end;{:329}{330:}procedure clear_for_error_prompt;
begin while(cur_input.state_field<>0)and(cur_input.name_field=0)and(
input_ptr>0)and(cur_input.loc_field>cur_input.limit_field)do
end_file_reading;print_ln;break_in(term_in,true);end;
{:330}{336:}procedure check_outer_validity;var p:halfword;q:halfword;
begin if scanner_status<>0 then begin deletions_allowed:=false;
{337:}if cur_cs<>0 then begin if(cur_input.state_field=0)or(cur_input.
name_field<1)or(cur_input.name_field>17)then begin p:=get_avail;
mem[p].hh.lh:=4095+cur_cs;begin_token_list(p,3);end;cur_cmd:=10;
cur_chr:=32;end{:337};if scanner_status>1 then{338:}begin runaway;
if cur_cs=0 then begin if interaction=3 then;print_nl(262);print(604);
end else begin cur_cs:=0;begin if interaction=3 then;print_nl(262);
print(605);end;end;print(606);{339:}p:=get_avail;
case scanner_status of 2:begin print(570);mem[p].hh.lh:=637;end;
3:begin print(612);mem[p].hh.lh:=par_token;long_state:=113;end;
4:begin print(572);mem[p].hh.lh:=637;q:=p;p:=get_avail;mem[p].hh.rh:=q;
mem[p].hh.lh:=6710;align_state:=-1000000;end;5:begin print(573);
mem[p].hh.lh:=637;end;end;begin_token_list(p,4){:339};print(607);
sprint_cs(warning_index);begin help_ptr:=4;help_line[3]:=608;
help_line[2]:=609;help_line[1]:=610;help_line[0]:=611;end;error;
end{:338}else begin begin if interaction=3 then;print_nl(262);
print(598);end;print_cmd_chr(105,cur_if);print(599);
print_int(skip_line);begin help_ptr:=3;help_line[2]:=600;
help_line[1]:=601;help_line[0]:=602;end;
if cur_cs<>0 then cur_cs:=0 else help_line[2]:=603;cur_tok:=6713;
ins_error;end;deletions_allowed:=true;end;end;
{:336}{340:}procedure firm_up_the_line;forward;
{:340}{341:}procedure get_next;label 20,25,21,26,40,10;
var k:0..buf_size;t:halfword;cat:0..15;c,cc:ASCII_code;d:2..3;
begin 20:cur_cs:=0;
if cur_input.state_field<>0 then{343:}begin 25:if cur_input.loc_field<=
cur_input.limit_field then begin cur_chr:=buffer[cur_input.loc_field];
cur_input.loc_field:=cur_input.loc_field+1;
21:cur_cmd:=eqtb[3983+cur_chr].hh.rh;
{344:}case cur_input.state_field+cur_cmd of{345:}10,26,42,27,43{:345}:
goto 25;
1,17,33:{354:}begin if cur_input.loc_field>cur_input.limit_field then
cur_cs:=513 else begin 26:k:=cur_input.loc_field;cur_chr:=buffer[k];
cat:=eqtb[3983+cur_chr].hh.rh;k:=k+1;
if cat=11 then cur_input.state_field:=17 else if cat=10 then cur_input.
state_field:=17 else cur_input.state_field:=1;
if(cat=11)and(k<=cur_input.limit_field)then{356:}begin repeat cur_chr:=
buffer[k];cat:=eqtb[3983+cur_chr].hh.rh;k:=k+1;
until(cat<>11)or(k>cur_input.limit_field);
{355:}begin if buffer[k]=cur_chr then if cat=7 then if k<cur_input.
limit_field then begin c:=buffer[k+1];if c<128 then begin d:=2;
if(((c>=48)and(c<=57))or((c>=97)and(c<=102)))then if k+2<=cur_input.
limit_field then begin cc:=buffer[k+2];
if(((cc>=48)and(cc<=57))or((cc>=97)and(cc<=102)))then d:=d+1;end;
if d>2 then begin if c<=57 then cur_chr:=c-48 else cur_chr:=c-87;
if cc<=57 then cur_chr:=16*cur_chr+cc-48 else cur_chr:=16*cur_chr+cc-87;
buffer[k-1]:=cur_chr;
end else if c<64 then buffer[k-1]:=c+64 else buffer[k-1]:=c-64;
cur_input.limit_field:=cur_input.limit_field-d;first:=first-d;
while k<=cur_input.limit_field do begin buffer[k]:=buffer[k+d];k:=k+1;
end;goto 26;end;end;end{:355};if cat<>11 then k:=k-1;
if k>cur_input.loc_field+1 then begin cur_cs:=id_lookup(cur_input.
loc_field,k-cur_input.loc_field);cur_input.loc_field:=k;goto 40;end;
end{:356}else{355:}begin if buffer[k]=cur_chr then if cat=7 then if k<
cur_input.limit_field then begin c:=buffer[k+1];
if c<128 then begin d:=2;
if(((c>=48)and(c<=57))or((c>=97)and(c<=102)))then if k+2<=cur_input.
limit_field then begin cc:=buffer[k+2];
if(((cc>=48)and(cc<=57))or((cc>=97)and(cc<=102)))then d:=d+1;end;
if d>2 then begin if c<=57 then cur_chr:=c-48 else cur_chr:=c-87;
if cc<=57 then cur_chr:=16*cur_chr+cc-48 else cur_chr:=16*cur_chr+cc-87;
buffer[k-1]:=cur_chr;
end else if c<64 then buffer[k-1]:=c+64 else buffer[k-1]:=c-64;
cur_input.limit_field:=cur_input.limit_field-d;first:=first-d;
while k<=cur_input.limit_field do begin buffer[k]:=buffer[k+d];k:=k+1;
end;goto 26;end;end;end{:355};cur_cs:=257+buffer[cur_input.loc_field];
cur_input.loc_field:=cur_input.loc_field+1;end;
40:cur_cmd:=eqtb[cur_cs].hh.b0;cur_chr:=eqtb[cur_cs].hh.rh;
if cur_cmd>=113 then check_outer_validity;end{:354};
14,30,46:{353:}begin cur_cs:=cur_chr+1;cur_cmd:=eqtb[cur_cs].hh.b0;
cur_chr:=eqtb[cur_cs].hh.rh;cur_input.state_field:=1;
if cur_cmd>=113 then check_outer_validity;end{:353};
8,24,40:{352:}begin if cur_chr=buffer[cur_input.loc_field]then if
cur_input.loc_field<cur_input.limit_field then begin c:=buffer[cur_input
.loc_field+1];
if c<128 then begin cur_input.loc_field:=cur_input.loc_field+2;
if(((c>=48)and(c<=57))or((c>=97)and(c<=102)))then if cur_input.loc_field
<=cur_input.limit_field then begin cc:=buffer[cur_input.loc_field];
if(((cc>=48)and(cc<=57))or((cc>=97)and(cc<=102)))then begin cur_input.
loc_field:=cur_input.loc_field+1;
if c<=57 then cur_chr:=c-48 else cur_chr:=c-87;
if cc<=57 then cur_chr:=16*cur_chr+cc-48 else cur_chr:=16*cur_chr+cc-87;
goto 21;end;end;if c<64 then cur_chr:=c+64 else cur_chr:=c-64;goto 21;
end;end;cur_input.state_field:=1;end{:352};
16,32,48:{346:}begin begin if interaction=3 then;print_nl(262);
print(613);end;begin help_ptr:=2;help_line[1]:=614;help_line[0]:=615;
end;deletions_allowed:=false;error;deletions_allowed:=true;goto 20;
end{:346};{347:}11:{349:}begin cur_input.state_field:=17;cur_chr:=32;
end{:349};6:{348:}begin cur_input.loc_field:=cur_input.limit_field+1;
cur_cmd:=10;cur_chr:=32;end{:348};
22,15,31,47:{350:}begin cur_input.loc_field:=cur_input.limit_field+1;
goto 25;end{:350};
38:{351:}begin cur_input.loc_field:=cur_input.limit_field+1;
cur_cs:=par_loc;cur_cmd:=eqtb[cur_cs].hh.b0;cur_chr:=eqtb[cur_cs].hh.rh;
if cur_cmd>=113 then check_outer_validity;end{:351};
2:align_state:=align_state+1;18,34:begin cur_input.state_field:=1;
align_state:=align_state+1;end;3:align_state:=align_state-1;
19,35:begin cur_input.state_field:=1;align_state:=align_state-1;end;
20,21,23,25,28,29,36,37,39,41,44,45:cur_input.state_field:=1;
{:347}others:end{:344};end else begin cur_input.state_field:=33;
{360:}if cur_input.name_field>17 then{362:}begin line:=line+1;
first:=cur_input.start_field;
if not force_eof then begin if input_ln(input_file[cur_input.index_field
],true)then firm_up_the_line else force_eof:=true;end;
if force_eof then begin print_char(41);open_parens:=open_parens-1;
break(term_out);force_eof:=false;end_file_reading;check_outer_validity;
goto 20;end;
if(eqtb[5311].int<0)or(eqtb[5311].int>255)then cur_input.limit_field:=
cur_input.limit_field-1 else buffer[cur_input.limit_field]:=eqtb[5311].
int;first:=cur_input.limit_field+1;
cur_input.loc_field:=cur_input.start_field;
end{:362}else begin if not(cur_input.name_field=0)then begin cur_cmd:=0;
cur_chr:=0;goto 10;end;if input_ptr>0 then begin end_file_reading;
goto 20;end;if selector<18 then open_log_file;
if interaction>1 then begin if(eqtb[5311].int<0)or(eqtb[5311].int>255)
then cur_input.limit_field:=cur_input.limit_field+1;
if cur_input.limit_field=cur_input.start_field then print_nl(616);
print_ln;first:=cur_input.start_field;begin;print(42);term_input;end;
cur_input.limit_field:=last;
if(eqtb[5311].int<0)or(eqtb[5311].int>255)then cur_input.limit_field:=
cur_input.limit_field-1 else buffer[cur_input.limit_field]:=eqtb[5311].
int;first:=cur_input.limit_field+1;
cur_input.loc_field:=cur_input.start_field;end else fatal_error(617);
end{:360};begin if interrupt<>0 then pause_for_instructions;end;goto 25;
end;
end{:343}else{357:}if cur_input.loc_field<>0 then begin t:=mem[cur_input
.loc_field].hh.lh;cur_input.loc_field:=mem[cur_input.loc_field].hh.rh;
if t>=4095 then begin cur_cs:=t-4095;cur_cmd:=eqtb[cur_cs].hh.b0;
cur_chr:=eqtb[cur_cs].hh.rh;
if cur_cmd>=113 then if cur_cmd=116 then{358:}begin cur_cs:=mem[
cur_input.loc_field].hh.lh-4095;cur_input.loc_field:=0;
cur_cmd:=eqtb[cur_cs].hh.b0;cur_chr:=eqtb[cur_cs].hh.rh;
if cur_cmd>100 then begin cur_cmd:=0;cur_chr:=257;end;
end{:358}else check_outer_validity;end else begin cur_cmd:=t div 256;
cur_chr:=t mod 256;case cur_cmd of 1:align_state:=align_state+1;
2:align_state:=align_state-1;
5:{359:}begin begin_token_list(param_stack[cur_input.limit_field+cur_chr
-1],0);goto 20;end{:359};others:end;end;end else begin end_token_list;
goto 20;end{:357};
{342:}if cur_cmd<=5 then if cur_cmd>=4 then if align_state=0 then{789:}
begin if(scanner_status=4)or(cur_align=0)then fatal_error(595);
cur_cmd:=mem[cur_align+5].hh.lh;mem[cur_align+5].hh.lh:=cur_chr;
if cur_cmd=63 then begin_token_list(29990,2)else begin_token_list(mem[
cur_align+2].int,2);align_state:=1000000;goto 20;end{:789}{:342};10:end;
{:341}{363:}procedure firm_up_the_line;var k:0..buf_size;
begin cur_input.limit_field:=last;
if eqtb[5291].int>0 then if interaction>1 then begin;print_ln;
if cur_input.start_field<cur_input.limit_field then for k:=cur_input.
start_field to cur_input.limit_field-1 do print(buffer[k]);
first:=cur_input.limit_field;begin;print(618);term_input;end;
if last>first then begin for k:=first to last-1 do buffer[k+cur_input.
start_field-first]:=buffer[k];
cur_input.limit_field:=cur_input.start_field+last-first;end;end;end;
{:363}{365:}procedure get_token;begin no_new_control_sequence:=false;
get_next;no_new_control_sequence:=true;
if cur_cs=0 then cur_tok:=(cur_cmd*256)+cur_chr else cur_tok:=4095+
cur_cs;end;{:365}{366:}{389:}procedure macro_call;label 10,22,30,31,40;
var r:halfword;p:halfword;q:halfword;s:halfword;t:halfword;u,v:halfword;
rbrace_ptr:halfword;n:small_number;unbalance:halfword;m:halfword;
ref_count:halfword;save_scanner_status:small_number;
save_warning_index:halfword;match_chr:ASCII_code;
begin save_scanner_status:=scanner_status;
save_warning_index:=warning_index;warning_index:=cur_cs;
ref_count:=cur_chr;r:=mem[ref_count].hh.rh;n:=0;
if eqtb[5293].int>0 then{401:}begin begin_diagnostic;print_ln;
print_cs(warning_index);token_show(ref_count);end_diagnostic(false);
end{:401};if mem[r].hh.lh<>3584 then{391:}begin scanner_status:=3;
unbalance:=0;long_state:=eqtb[cur_cs].hh.b0;
if long_state>=113 then long_state:=long_state-2;
repeat mem[29997].hh.rh:=0;
if(mem[r].hh.lh>3583)or(mem[r].hh.lh<3328)then s:=0 else begin match_chr
:=mem[r].hh.lh-3328;s:=mem[r].hh.rh;r:=s;p:=29997;m:=0;end;
{392:}22:get_token;
if cur_tok=mem[r].hh.lh then{394:}begin r:=mem[r].hh.rh;
if(mem[r].hh.lh>=3328)and(mem[r].hh.lh<=3584)then begin if cur_tok<512
then align_state:=align_state-1;goto 40;end else goto 22;end{:394};
{397:}if s<>r then if s=0 then{398:}begin begin if interaction=3 then;
print_nl(262);print(650);end;sprint_cs(warning_index);print(651);
begin help_ptr:=4;help_line[3]:=652;help_line[2]:=653;help_line[1]:=654;
help_line[0]:=655;end;error;goto 10;end{:398}else begin t:=s;
repeat begin q:=get_avail;mem[p].hh.rh:=q;mem[q].hh.lh:=mem[t].hh.lh;
p:=q;end;m:=m+1;u:=mem[t].hh.rh;v:=s;
while true do begin if u=r then if cur_tok<>mem[v].hh.lh then goto 30
else begin r:=mem[v].hh.rh;goto 22;end;
if mem[u].hh.lh<>mem[v].hh.lh then goto 30;u:=mem[u].hh.rh;
v:=mem[v].hh.rh;end;30:t:=mem[t].hh.rh;until t=r;r:=s;end{:397};
if cur_tok=par_token then if long_state<>112 then{396:}begin if
long_state=111 then begin runaway;begin if interaction=3 then;
print_nl(262);print(645);end;sprint_cs(warning_index);print(646);
begin help_ptr:=3;help_line[2]:=647;help_line[1]:=648;help_line[0]:=649;
end;back_error;end;pstack[n]:=mem[29997].hh.rh;
align_state:=align_state-unbalance;
for m:=0 to n do flush_list(pstack[m]);goto 10;end{:396};
if cur_tok<768 then if cur_tok<512 then{399:}begin unbalance:=1;
while true do begin begin begin q:=avail;
if q=0 then q:=get_avail else begin avail:=mem[q].hh.rh;mem[q].hh.rh:=0;
{dyn_used:=dyn_used+1;}end;end;mem[p].hh.rh:=q;mem[q].hh.lh:=cur_tok;
p:=q;end;get_token;
if cur_tok=par_token then if long_state<>112 then{396:}begin if
long_state=111 then begin runaway;begin if interaction=3 then;
print_nl(262);print(645);end;sprint_cs(warning_index);print(646);
begin help_ptr:=3;help_line[2]:=647;help_line[1]:=648;help_line[0]:=649;
end;back_error;end;pstack[n]:=mem[29997].hh.rh;
align_state:=align_state-unbalance;
for m:=0 to n do flush_list(pstack[m]);goto 10;end{:396};
if cur_tok<768 then if cur_tok<512 then unbalance:=unbalance+1 else
begin unbalance:=unbalance-1;if unbalance=0 then goto 31;end;end;
31:rbrace_ptr:=p;begin q:=get_avail;mem[p].hh.rh:=q;
mem[q].hh.lh:=cur_tok;p:=q;end;end{:399}else{395:}begin back_input;
begin if interaction=3 then;print_nl(262);print(637);end;
sprint_cs(warning_index);print(638);begin help_ptr:=6;help_line[5]:=639;
help_line[4]:=640;help_line[3]:=641;help_line[2]:=642;help_line[1]:=643;
help_line[0]:=644;end;align_state:=align_state+1;long_state:=111;
cur_tok:=par_token;ins_error;goto 22;
end{:395}else{393:}begin if cur_tok=2592 then if mem[r].hh.lh<=3584 then
if mem[r].hh.lh>=3328 then goto 22;begin q:=get_avail;mem[p].hh.rh:=q;
mem[q].hh.lh:=cur_tok;p:=q;end;end{:393};m:=m+1;
if mem[r].hh.lh>3584 then goto 22;if mem[r].hh.lh<3328 then goto 22;
40:if s<>0 then{400:}begin if(m=1)and(mem[p].hh.lh<768)and(p<>29997)then
begin mem[rbrace_ptr].hh.rh:=0;begin mem[p].hh.rh:=avail;avail:=p;
{dyn_used:=dyn_used-1;}end;p:=mem[29997].hh.rh;pstack[n]:=mem[p].hh.rh;
begin mem[p].hh.rh:=avail;avail:=p;{dyn_used:=dyn_used-1;}end;
end else pstack[n]:=mem[29997].hh.rh;n:=n+1;
if eqtb[5293].int>0 then begin begin_diagnostic;print_nl(match_chr);
print_int(n);print(656);show_token_list(pstack[n-1],0,1000);
end_diagnostic(false);end;end{:400}{:392};until mem[r].hh.lh=3584;
end{:391};
{390:}while(cur_input.state_field=0)and(cur_input.loc_field=0)and(
cur_input.index_field<>2)do end_token_list;
begin_token_list(ref_count,5);cur_input.name_field:=warning_index;
cur_input.loc_field:=mem[r].hh.rh;
if n>0 then begin if param_ptr+n>max_param_stack then begin
max_param_stack:=param_ptr+n;
if max_param_stack>param_size then overflow(636,param_size);end;
for m:=0 to n-1 do param_stack[param_ptr+m]:=pstack[m];
param_ptr:=param_ptr+n;end{:390};10:scanner_status:=save_scanner_status;
warning_index:=save_warning_index;end;
{:389}{379:}procedure insert_relax;begin cur_tok:=4095+cur_cs;
back_input;cur_tok:=6716;back_input;cur_input.index_field:=4;end;
{:379}procedure pass_text;forward;procedure start_input;forward;
procedure conditional;forward;procedure get_x_token;forward;
procedure conv_toks;forward;procedure ins_the_toks;forward;
procedure expand;var t:halfword;p,q,r:halfword;j:0..buf_size;
cv_backup:integer;cvl_backup,radix_backup,co_backup:small_number;
backup_backup:halfword;save_scanner_status:small_number;
begin cv_backup:=cur_val;cvl_backup:=cur_val_level;radix_backup:=radix;
co_backup:=cur_order;backup_backup:=mem[29987].hh.rh;
if cur_cmd<111 then{367:}begin if eqtb[5299].int>1 then show_cur_cmd_chr
;case cur_cmd of 110:{386:}begin if cur_mark[cur_chr]<>0 then
begin_token_list(cur_mark[cur_chr],14);end{:386};
102:{368:}begin get_token;t:=cur_tok;get_token;
if cur_cmd>100 then expand else back_input;cur_tok:=t;back_input;
end{:368};103:{369:}begin save_scanner_status:=scanner_status;
scanner_status:=0;get_token;scanner_status:=save_scanner_status;
t:=cur_tok;back_input;if t>=4095 then begin p:=get_avail;
mem[p].hh.lh:=6718;mem[p].hh.rh:=cur_input.loc_field;
cur_input.start_field:=p;cur_input.loc_field:=p;end;end{:369};
107:{372:}begin r:=get_avail;p:=r;repeat get_x_token;
if cur_cs=0 then begin q:=get_avail;mem[p].hh.rh:=q;
mem[q].hh.lh:=cur_tok;p:=q;end;until cur_cs<>0;
if cur_cmd<>67 then{373:}begin begin if interaction=3 then;
print_nl(262);print(625);end;print_esc(505);print(626);
begin help_ptr:=2;help_line[1]:=627;help_line[0]:=628;end;back_error;
end{:373};{374:}j:=first;p:=mem[r].hh.rh;
while p<>0 do begin if j>=max_buf_stack then begin max_buf_stack:=j+1;
if max_buf_stack=buf_size then overflow(256,buf_size);end;
buffer[j]:=mem[p].hh.lh mod 256;j:=j+1;p:=mem[p].hh.rh;end;
if j>first+1 then begin no_new_control_sequence:=false;
cur_cs:=id_lookup(first,j-first);no_new_control_sequence:=true;
end else if j=first then cur_cs:=513 else cur_cs:=257+buffer[first]
{:374};flush_list(r);
if eqtb[cur_cs].hh.b0=101 then begin eq_define(cur_cs,0,256);end;
cur_tok:=cur_cs+4095;back_input;end{:372};108:conv_toks;
109:ins_the_toks;105:conditional;
106:{510:}if cur_chr>if_limit then if if_limit=1 then insert_relax else
begin begin if interaction=3 then;print_nl(262);print(776);end;
print_cmd_chr(106,cur_chr);begin help_ptr:=1;help_line[0]:=777;end;
error;end else begin while cur_chr<>2 do pass_text;
{496:}begin p:=cond_ptr;if_line:=mem[p+1].int;cur_if:=mem[p].hh.b1;
if_limit:=mem[p].hh.b0;cond_ptr:=mem[p].hh.rh;free_node(p,2);end{:496};
end{:510};
104:{378:}if cur_chr>0 then force_eof:=true else if name_in_progress
then insert_relax else start_input{:378};
others:{370:}begin begin if interaction=3 then;print_nl(262);print(619);
end;begin help_ptr:=5;help_line[4]:=620;help_line[3]:=621;
help_line[2]:=622;help_line[1]:=623;help_line[0]:=624;end;error;
end{:370}end;
end{:367}else if cur_cmd<115 then macro_call else{375:}begin cur_tok:=
6715;back_input;end{:375};cur_val:=cv_backup;cur_val_level:=cvl_backup;
radix:=radix_backup;cur_order:=co_backup;
mem[29987].hh.rh:=backup_backup;end;{:366}{380:}procedure get_x_token;
label 20,30;begin 20:get_next;if cur_cmd<=100 then goto 30;
if cur_cmd>=111 then if cur_cmd<115 then macro_call else begin cur_cs:=
2620;cur_cmd:=9;goto 30;end else expand;goto 20;
30:if cur_cs=0 then cur_tok:=(cur_cmd*256)+cur_chr else cur_tok:=4095+
cur_cs;end;{:380}{381:}procedure x_token;
begin while cur_cmd>100 do begin expand;get_next;end;
if cur_cs=0 then cur_tok:=(cur_cmd*256)+cur_chr else cur_tok:=4095+
cur_cs;end;{:381}{403:}procedure scan_left_brace;
begin{404:}repeat get_x_token;until(cur_cmd<>10)and(cur_cmd<>0){:404};
if cur_cmd<>1 then begin begin if interaction=3 then;print_nl(262);
print(657);end;begin help_ptr:=4;help_line[3]:=658;help_line[2]:=659;
help_line[1]:=660;help_line[0]:=661;end;back_error;cur_tok:=379;
cur_cmd:=1;cur_chr:=123;align_state:=align_state+1;end;end;
{:403}{405:}procedure scan_optional_equals;
begin{406:}repeat get_x_token;until cur_cmd<>10{:406};
if cur_tok<>3133 then back_input;end;
{:405}{407:}function scan_keyword(s:str_number):boolean;label 10;
var p:halfword;q:halfword;k:pool_pointer;begin p:=29987;mem[p].hh.rh:=0;
k:=str_start[s];while k<str_start[s+1]do begin get_x_token;
if(cur_cs=0)and((cur_chr=str_pool[k])or(cur_chr=str_pool[k]-32))then
begin begin q:=get_avail;mem[p].hh.rh:=q;mem[q].hh.lh:=cur_tok;p:=q;end;
k:=k+1;end else if(cur_cmd<>10)or(p<>29987)then begin back_input;
if p<>29987 then begin_token_list(mem[29987].hh.rh,3);
scan_keyword:=false;goto 10;end;end;flush_list(mem[29987].hh.rh);
scan_keyword:=true;10:end;{:407}{408:}procedure mu_error;
begin begin if interaction=3 then;print_nl(262);print(662);end;
begin help_ptr:=1;help_line[0]:=663;end;error;end;
{:408}{409:}procedure scan_int;forward;
{433:}procedure scan_eight_bit_int;begin scan_int;
if(cur_val<0)or(cur_val>255)then begin begin if interaction=3 then;
print_nl(262);print(687);end;begin help_ptr:=2;help_line[1]:=688;
help_line[0]:=689;end;int_error(cur_val);cur_val:=0;end;end;
{:433}{434:}procedure scan_char_num;begin scan_int;
if(cur_val<0)or(cur_val>255)then begin begin if interaction=3 then;
print_nl(262);print(690);end;begin help_ptr:=2;help_line[1]:=691;
help_line[0]:=689;end;int_error(cur_val);cur_val:=0;end;end;
{:434}{435:}procedure scan_four_bit_int;begin scan_int;
if(cur_val<0)or(cur_val>15)then begin begin if interaction=3 then;
print_nl(262);print(692);end;begin help_ptr:=2;help_line[1]:=693;
help_line[0]:=689;end;int_error(cur_val);cur_val:=0;end;end;
{:435}{436:}procedure scan_fifteen_bit_int;begin scan_int;
if(cur_val<0)or(cur_val>32767)then begin begin if interaction=3 then;
print_nl(262);print(694);end;begin help_ptr:=2;help_line[1]:=695;
help_line[0]:=689;end;int_error(cur_val);cur_val:=0;end;end;
{:436}{437:}procedure scan_twenty_seven_bit_int;begin scan_int;
if(cur_val<0)or(cur_val>134217727)then begin begin if interaction=3 then
;print_nl(262);print(696);end;begin help_ptr:=2;help_line[1]:=697;
help_line[0]:=689;end;int_error(cur_val);cur_val:=0;end;end;
{:437}{577:}procedure scan_font_ident;var f:internal_font_number;
m:halfword;begin{406:}repeat get_x_token;until cur_cmd<>10{:406};
if cur_cmd=88 then f:=eqtb[3934].hh.rh else if cur_cmd=87 then f:=
cur_chr else if cur_cmd=86 then begin m:=cur_chr;scan_four_bit_int;
f:=eqtb[m+cur_val].hh.rh;end else begin begin if interaction=3 then;
print_nl(262);print(816);end;begin help_ptr:=2;help_line[1]:=817;
help_line[0]:=818;end;back_error;f:=0;end;cur_val:=f;end;
{:577}{578:}procedure find_font_dimen(writing:boolean);
var f:internal_font_number;n:integer;begin scan_int;n:=cur_val;
scan_font_ident;f:=cur_val;
if n<=0 then cur_val:=fmem_ptr else begin if writing and(n<=4)and(n>=2)
and(font_glue[f]<>0)then begin delete_glue_ref(font_glue[f]);
font_glue[f]:=0;end;
if n>font_params[f]then if f<font_ptr then cur_val:=fmem_ptr else{580:}
begin repeat if fmem_ptr=font_mem_size then overflow(823,font_mem_size);
font_info[fmem_ptr].int:=0;fmem_ptr:=fmem_ptr+1;
font_params[f]:=font_params[f]+1;until n=font_params[f];
cur_val:=fmem_ptr-1;end{:580}else cur_val:=n+param_base[f];end;
{579:}if cur_val=fmem_ptr then begin begin if interaction=3 then;
print_nl(262);print(801);end;print_esc(hash[2624+f].rh);print(819);
print_int(font_params[f]);print(820);begin help_ptr:=2;
help_line[1]:=821;help_line[0]:=822;end;error;end{:579};end;
{:578}{:409}{413:}procedure scan_something_internal(level:small_number;
negative:boolean);var m:halfword;p:0..nest_size;begin m:=cur_chr;
case cur_cmd of 85:{414:}begin scan_char_num;
if m=5007 then begin cur_val:=eqtb[5007+cur_val].hh.rh-0;
cur_val_level:=0;
end else if m<5007 then begin cur_val:=eqtb[m+cur_val].hh.rh;
cur_val_level:=0;end else begin cur_val:=eqtb[m+cur_val].int;
cur_val_level:=0;end;end{:414};
71,72,86,87,88:{415:}if level<>5 then begin begin if interaction=3 then;
print_nl(262);print(664);end;begin help_ptr:=3;help_line[2]:=665;
help_line[1]:=666;help_line[0]:=667;end;back_error;begin cur_val:=0;
cur_val_level:=1;end;
end else if cur_cmd<=72 then begin if cur_cmd<72 then begin
scan_eight_bit_int;m:=3422+cur_val;end;begin cur_val:=eqtb[m].hh.rh;
cur_val_level:=5;end;end else begin back_input;scan_font_ident;
begin cur_val:=2624+cur_val;cur_val_level:=4;end;end{:415};
73:begin cur_val:=eqtb[m].int;cur_val_level:=0;end;
74:begin cur_val:=eqtb[m].int;cur_val_level:=1;end;
75:begin cur_val:=eqtb[m].hh.rh;cur_val_level:=2;end;
76:begin cur_val:=eqtb[m].hh.rh;cur_val_level:=3;end;
79:{418:}if abs(cur_list.mode_field)<>m then begin begin if interaction=
3 then;print_nl(262);print(680);end;print_cmd_chr(79,m);
begin help_ptr:=4;help_line[3]:=681;help_line[2]:=682;help_line[1]:=683;
help_line[0]:=684;end;error;if level<>5 then begin cur_val:=0;
cur_val_level:=1;end else begin cur_val:=0;cur_val_level:=0;end;
end else if m=1 then begin cur_val:=cur_list.aux_field.int;
cur_val_level:=1;end else begin cur_val:=cur_list.aux_field.hh.lh;
cur_val_level:=0;end{:418};
80:{422:}if cur_list.mode_field=0 then begin cur_val:=0;
cur_val_level:=0;end else begin nest[nest_ptr]:=cur_list;p:=nest_ptr;
while abs(nest[p].mode_field)<>1 do p:=p-1;
begin cur_val:=nest[p].pg_field;cur_val_level:=0;end;end{:422};
82:{419:}begin if m=0 then cur_val:=dead_cycles else cur_val:=
insert_penalties;cur_val_level:=0;end{:419};
81:{421:}begin if(page_contents=0)and(not output_active)then if m=0 then
cur_val:=1073741823 else cur_val:=0 else cur_val:=page_so_far[m];
cur_val_level:=1;end{:421};
84:{423:}begin if eqtb[3412].hh.rh=0 then cur_val:=0 else cur_val:=mem[
eqtb[3412].hh.rh].hh.lh;cur_val_level:=0;end{:423};
83:{420:}begin scan_eight_bit_int;
if eqtb[3678+cur_val].hh.rh=0 then cur_val:=0 else cur_val:=mem[eqtb[
3678+cur_val].hh.rh+m].int;cur_val_level:=1;end{:420};
68,69:begin cur_val:=cur_chr;cur_val_level:=0;end;
77:{425:}begin find_font_dimen(false);font_info[fmem_ptr].int:=0;
begin cur_val:=font_info[cur_val].int;cur_val_level:=1;end;end{:425};
78:{426:}begin scan_font_ident;
if m=0 then begin cur_val:=hyphen_char[cur_val];cur_val_level:=0;
end else begin cur_val:=skew_char[cur_val];cur_val_level:=0;end;
end{:426};89:{427:}begin scan_eight_bit_int;
case m of 0:cur_val:=eqtb[5318+cur_val].int;
1:cur_val:=eqtb[5851+cur_val].int;2:cur_val:=eqtb[2900+cur_val].hh.rh;
3:cur_val:=eqtb[3156+cur_val].hh.rh;end;cur_val_level:=m;end{:427};
70:{424:}if cur_chr>2 then begin if cur_chr=3 then cur_val:=line else
cur_val:=last_badness;cur_val_level:=0;
end else begin if cur_chr=2 then cur_val:=0 else cur_val:=0;
cur_val_level:=cur_chr;
if not(cur_list.tail_field>=hi_mem_min)and(cur_list.mode_field<>0)then
case cur_chr of 0:if mem[cur_list.tail_field].hh.b0=12 then cur_val:=mem
[cur_list.tail_field+1].int;
1:if mem[cur_list.tail_field].hh.b0=11 then cur_val:=mem[cur_list.
tail_field+1].int;
2:if mem[cur_list.tail_field].hh.b0=10 then begin cur_val:=mem[cur_list.
tail_field+1].hh.lh;
if mem[cur_list.tail_field].hh.b1=99 then cur_val_level:=3;end;
end else if(cur_list.mode_field=1)and(cur_list.tail_field=cur_list.
head_field)then case cur_chr of 0:cur_val:=last_penalty;
1:cur_val:=last_kern;2:if last_glue<>65535 then cur_val:=last_glue;end;
end{:424};others:{428:}begin begin if interaction=3 then;print_nl(262);
print(685);end;print_cmd_chr(cur_cmd,cur_chr);print(686);print_esc(537);
begin help_ptr:=1;help_line[0]:=684;end;error;
if level<>5 then begin cur_val:=0;cur_val_level:=1;
end else begin cur_val:=0;cur_val_level:=0;end;end{:428}end;
while cur_val_level>level do{429:}begin if cur_val_level=2 then cur_val
:=mem[cur_val+1].int else if cur_val_level=3 then mu_error;
cur_val_level:=cur_val_level-1;end{:429};
{430:}if negative then if cur_val_level>=2 then begin cur_val:=new_spec(
cur_val);{431:}begin mem[cur_val+1].int:=-mem[cur_val+1].int;
mem[cur_val+2].int:=-mem[cur_val+2].int;
mem[cur_val+3].int:=-mem[cur_val+3].int;end{:431};
end else cur_val:=-cur_val else if(cur_val_level>=2)and(cur_val_level<=3
)then mem[cur_val].hh.rh:=mem[cur_val].hh.rh+1{:430};end;
{:413}{440:}procedure scan_int;label 30;var negative:boolean;m:integer;
d:small_number;vacuous:boolean;OK_so_far:boolean;begin radix:=0;
OK_so_far:=true;{441:}negative:=false;repeat{406:}repeat get_x_token;
until cur_cmd<>10{:406};
if cur_tok=3117 then begin negative:=not negative;cur_tok:=3115;end;
until cur_tok<>3115{:441};if cur_tok=3168 then{442:}begin get_token;
if cur_tok<4095 then begin cur_val:=cur_chr;
if cur_cmd<=2 then if cur_cmd=2 then align_state:=align_state+1 else
align_state:=align_state-1;
end else if cur_tok<4352 then cur_val:=cur_tok-4096 else cur_val:=
cur_tok-4352;if cur_val>255 then begin begin if interaction=3 then;
print_nl(262);print(698);end;begin help_ptr:=2;help_line[1]:=699;
help_line[0]:=700;end;cur_val:=48;back_error;
end else{443:}begin get_x_token;if cur_cmd<>10 then back_input;
end{:443};end{:442}else if(cur_cmd>=68)and(cur_cmd<=89)then
scan_something_internal(0,false)else{444:}begin radix:=10;m:=214748364;
if cur_tok=3111 then begin radix:=8;m:=268435456;get_x_token;
end else if cur_tok=3106 then begin radix:=16;m:=134217728;get_x_token;
end;vacuous:=true;cur_val:=0;
{445:}while true do begin if(cur_tok<3120+radix)and(cur_tok>=3120)and(
cur_tok<=3129)then d:=cur_tok-3120 else if radix=16 then if(cur_tok<=
2886)and(cur_tok>=2881)then d:=cur_tok-2871 else if(cur_tok<=3142)and(
cur_tok>=3137)then d:=cur_tok-3127 else goto 30 else goto 30;
vacuous:=false;
if(cur_val>=m)and((cur_val>m)or(d>7)or(radix<>10))then begin if
OK_so_far then begin begin if interaction=3 then;print_nl(262);
print(701);end;begin help_ptr:=2;help_line[1]:=702;help_line[0]:=703;
end;error;cur_val:=2147483647;OK_so_far:=false;end;
end else cur_val:=cur_val*radix+d;get_x_token;end;30:{:445};
if vacuous then{446:}begin begin if interaction=3 then;print_nl(262);
print(664);end;begin help_ptr:=3;help_line[2]:=665;help_line[1]:=666;
help_line[0]:=667;end;back_error;
end{:446}else if cur_cmd<>10 then back_input;end{:444};
if negative then cur_val:=-cur_val;end;
{:440}{448:}procedure scan_dimen(mu,inf,shortcut:boolean);
label 30,31,32,40,45,88,89;var negative:boolean;f:integer;
{450:}num,denom:1..65536;k,kk:small_number;p,q:halfword;v:scaled;
save_cur_val:integer;{:450}begin f:=0;arith_error:=false;cur_order:=0;
negative:=false;if not shortcut then begin{441:}negative:=false;
repeat{406:}repeat get_x_token;until cur_cmd<>10{:406};
if cur_tok=3117 then begin negative:=not negative;cur_tok:=3115;end;
until cur_tok<>3115{:441};
if(cur_cmd>=68)and(cur_cmd<=89)then{449:}if mu then begin
scan_something_internal(3,false);
{451:}if cur_val_level>=2 then begin v:=mem[cur_val+1].int;
delete_glue_ref(cur_val);cur_val:=v;end{:451};
if cur_val_level=3 then goto 89;if cur_val_level<>0 then mu_error;
end else begin scan_something_internal(1,false);
if cur_val_level=1 then goto 89;end{:449}else begin back_input;
if cur_tok=3116 then cur_tok:=3118;
if cur_tok<>3118 then scan_int else begin radix:=10;cur_val:=0;end;
if cur_tok=3116 then cur_tok:=3118;
if(radix=10)and(cur_tok=3118)then{452:}begin k:=0;p:=0;get_token;
while true do begin get_x_token;
if(cur_tok>3129)or(cur_tok<3120)then goto 31;
if k<17 then begin q:=get_avail;mem[q].hh.rh:=p;
mem[q].hh.lh:=cur_tok-3120;p:=q;k:=k+1;end;end;
31:for kk:=k downto 1 do begin dig[kk-1]:=mem[p].hh.lh;q:=p;
p:=mem[p].hh.rh;begin mem[q].hh.rh:=avail;avail:=q;
{dyn_used:=dyn_used-1;}end;end;f:=round_decimals(k);
if cur_cmd<>10 then back_input;end{:452};end;end;
if cur_val<0 then begin negative:=not negative;cur_val:=-cur_val;end;
{453:}if inf then{454:}if scan_keyword(311)then begin cur_order:=1;
while scan_keyword(108)do begin if cur_order=3 then begin begin if
interaction=3 then;print_nl(262);print(705);end;print(706);
begin help_ptr:=1;help_line[0]:=707;end;error;
end else cur_order:=cur_order+1;end;goto 88;end{:454};
{455:}save_cur_val:=cur_val;{406:}repeat get_x_token;
until cur_cmd<>10{:406};
if(cur_cmd<68)or(cur_cmd>89)then back_input else begin if mu then begin
scan_something_internal(3,false);
{451:}if cur_val_level>=2 then begin v:=mem[cur_val+1].int;
delete_glue_ref(cur_val);cur_val:=v;end{:451};
if cur_val_level<>3 then mu_error;
end else scan_something_internal(1,false);v:=cur_val;goto 40;end;
if mu then goto 45;
if scan_keyword(708)then v:=({558:}font_info[6+param_base[eqtb[3934].hh.
rh]].int{:558})else if scan_keyword(709)then v:=({559:}font_info[5+
param_base[eqtb[3934].hh.rh]].int{:559})else goto 45;
{443:}begin get_x_token;if cur_cmd<>10 then back_input;end{:443};
40:cur_val:=mult_and_add(save_cur_val,v,xn_over_d(v,f,65536),1073741823)
;goto 89;45:{:455};
if mu then{456:}if scan_keyword(337)then goto 88 else begin begin if
interaction=3 then;print_nl(262);print(705);end;print(710);
begin help_ptr:=4;help_line[3]:=711;help_line[2]:=712;help_line[1]:=713;
help_line[0]:=714;end;error;goto 88;end{:456};
if scan_keyword(704)then{457:}begin prepare_mag;
if eqtb[5280].int<>1000 then begin cur_val:=xn_over_d(cur_val,1000,eqtb[
5280].int);f:=(1000*f+65536*remainder)div eqtb[5280].int;
cur_val:=cur_val+(f div 65536);f:=f mod 65536;end;end{:457};
if scan_keyword(397)then goto 88;
{458:}if scan_keyword(715)then begin num:=7227;denom:=100;
end else if scan_keyword(716)then begin num:=12;denom:=1;
end else if scan_keyword(717)then begin num:=7227;denom:=254;
end else if scan_keyword(718)then begin num:=7227;denom:=2540;
end else if scan_keyword(719)then begin num:=7227;denom:=7200;
end else if scan_keyword(720)then begin num:=1238;denom:=1157;
end else if scan_keyword(721)then begin num:=14856;denom:=1157;
end else if scan_keyword(722)then goto 30 else{459:}begin begin if
interaction=3 then;print_nl(262);print(705);end;print(723);
begin help_ptr:=6;help_line[5]:=724;help_line[4]:=725;help_line[3]:=726;
help_line[2]:=712;help_line[1]:=713;help_line[0]:=714;end;error;goto 32;
end{:459};cur_val:=xn_over_d(cur_val,num,denom);
f:=(num*f+65536*remainder)div denom;cur_val:=cur_val+(f div 65536);
f:=f mod 65536;32:{:458};
88:if cur_val>=16384 then arith_error:=true else cur_val:=cur_val*65536+
f;30:{:453};{443:}begin get_x_token;if cur_cmd<>10 then back_input;
end{:443};
89:if arith_error or(abs(cur_val)>=1073741824)then{460:}begin begin if
interaction=3 then;print_nl(262);print(727);end;begin help_ptr:=2;
help_line[1]:=728;help_line[0]:=729;end;error;cur_val:=1073741823;
arith_error:=false;end{:460};if negative then cur_val:=-cur_val;end;
{:448}{461:}procedure scan_glue(level:small_number);label 10;
var negative:boolean;q:halfword;mu:boolean;begin mu:=(level=3);
{441:}negative:=false;repeat{406:}repeat get_x_token;
until cur_cmd<>10{:406};
if cur_tok=3117 then begin negative:=not negative;cur_tok:=3115;end;
until cur_tok<>3115{:441};
if(cur_cmd>=68)and(cur_cmd<=89)then begin scan_something_internal(level,
negative);
if cur_val_level>=2 then begin if cur_val_level<>level then mu_error;
goto 10;end;
if cur_val_level=0 then scan_dimen(mu,false,true)else if level=3 then
mu_error;end else begin back_input;scan_dimen(mu,false,false);
if negative then cur_val:=-cur_val;end;{462:}q:=new_spec(0);
mem[q+1].int:=cur_val;
if scan_keyword(730)then begin scan_dimen(mu,true,false);
mem[q+2].int:=cur_val;mem[q].hh.b0:=cur_order;end;
if scan_keyword(731)then begin scan_dimen(mu,true,false);
mem[q+3].int:=cur_val;mem[q].hh.b1:=cur_order;end;cur_val:=q{:462};
10:end;{:461}{463:}function scan_rule_spec:halfword;label 21;
var q:halfword;begin q:=new_rule;
if cur_cmd=35 then mem[q+1].int:=26214 else begin mem[q+3].int:=26214;
mem[q+2].int:=0;end;
21:if scan_keyword(732)then begin scan_dimen(false,false,false);
mem[q+1].int:=cur_val;goto 21;end;
if scan_keyword(733)then begin scan_dimen(false,false,false);
mem[q+3].int:=cur_val;goto 21;end;
if scan_keyword(734)then begin scan_dimen(false,false,false);
mem[q+2].int:=cur_val;goto 21;end;scan_rule_spec:=q;end;
{:463}{464:}function str_toks(b:pool_pointer):halfword;var p:halfword;
q:halfword;t:halfword;k:pool_pointer;
begin begin if pool_ptr+1>pool_size then overflow(257,pool_size-
init_pool_ptr);end;p:=29997;mem[p].hh.rh:=0;k:=b;
while k<pool_ptr do begin t:=str_pool[k];
if t=32 then t:=2592 else t:=3072+t;begin begin q:=avail;
if q=0 then q:=get_avail else begin avail:=mem[q].hh.rh;mem[q].hh.rh:=0;
{dyn_used:=dyn_used+1;}end;end;mem[p].hh.rh:=q;mem[q].hh.lh:=t;p:=q;end;
k:=k+1;end;pool_ptr:=b;str_toks:=p;end;
{:464}{465:}function the_toks:halfword;var old_setting:0..21;
p,q,r:halfword;b:pool_pointer;begin get_x_token;
scan_something_internal(5,false);
if cur_val_level>=4 then{466:}begin p:=29997;mem[p].hh.rh:=0;
if cur_val_level=4 then begin q:=get_avail;mem[p].hh.rh:=q;
mem[q].hh.lh:=4095+cur_val;p:=q;
end else if cur_val<>0 then begin r:=mem[cur_val].hh.rh;
while r<>0 do begin begin begin q:=avail;
if q=0 then q:=get_avail else begin avail:=mem[q].hh.rh;mem[q].hh.rh:=0;
{dyn_used:=dyn_used+1;}end;end;mem[p].hh.rh:=q;
mem[q].hh.lh:=mem[r].hh.lh;p:=q;end;r:=mem[r].hh.rh;end;end;the_toks:=p;
end{:466}else begin old_setting:=selector;selector:=21;b:=pool_ptr;
case cur_val_level of 0:print_int(cur_val);
1:begin print_scaled(cur_val);print(397);end;
2:begin print_spec(cur_val,397);delete_glue_ref(cur_val);end;
3:begin print_spec(cur_val,337);delete_glue_ref(cur_val);end;end;
selector:=old_setting;the_toks:=str_toks(b);end;end;
{:465}{467:}procedure ins_the_toks;begin mem[29988].hh.rh:=the_toks;
begin_token_list(mem[29997].hh.rh,4);end;
{:467}{470:}procedure conv_toks;var old_setting:0..21;c:0..5;
save_scanner_status:small_number;b:pool_pointer;begin c:=cur_chr;
{471:}case c of 0,1:scan_int;
2,3:begin save_scanner_status:=scanner_status;scanner_status:=0;
get_token;scanner_status:=save_scanner_status;end;4:scan_font_ident;
5:if job_name=0 then open_log_file;end{:471};old_setting:=selector;
selector:=21;b:=pool_ptr;{472:}case c of 0:print_int(cur_val);
1:print_roman_int(cur_val);
2:if cur_cs<>0 then sprint_cs(cur_cs)else print_char(cur_chr);
3:print_meaning;4:begin print(font_name[cur_val]);
if font_size[cur_val]<>font_dsize[cur_val]then begin print(741);
print_scaled(font_size[cur_val]);print(397);end;end;5:print(job_name);
end{:472};selector:=old_setting;mem[29988].hh.rh:=str_toks(b);
begin_token_list(mem[29997].hh.rh,4);end;
{:470}{473:}function scan_toks(macro_def,xpand:boolean):halfword;
label 40,30,31,32;var t:halfword;s:halfword;p:halfword;q:halfword;
unbalance:halfword;hash_brace:halfword;
begin if macro_def then scanner_status:=2 else scanner_status:=5;
warning_index:=cur_cs;def_ref:=get_avail;mem[def_ref].hh.lh:=0;
p:=def_ref;hash_brace:=0;t:=3120;
if macro_def then{474:}begin while true do begin get_token;
if cur_tok<768 then goto 31;
if cur_cmd=6 then{476:}begin s:=3328+cur_chr;get_token;
if cur_cmd=1 then begin hash_brace:=cur_tok;begin q:=get_avail;
mem[p].hh.rh:=q;mem[q].hh.lh:=cur_tok;p:=q;end;begin q:=get_avail;
mem[p].hh.rh:=q;mem[q].hh.lh:=3584;p:=q;end;goto 30;end;
if t=3129 then begin begin if interaction=3 then;print_nl(262);
print(744);end;begin help_ptr:=1;help_line[0]:=745;end;error;
end else begin t:=t+1;
if cur_tok<>t then begin begin if interaction=3 then;print_nl(262);
print(746);end;begin help_ptr:=2;help_line[1]:=747;help_line[0]:=748;
end;back_error;end;cur_tok:=s;end;end{:476};begin q:=get_avail;
mem[p].hh.rh:=q;mem[q].hh.lh:=cur_tok;p:=q;end;end;
31:begin q:=get_avail;mem[p].hh.rh:=q;mem[q].hh.lh:=3584;p:=q;end;
if cur_cmd=2 then{475:}begin begin if interaction=3 then;print_nl(262);
print(657);end;align_state:=align_state+1;begin help_ptr:=2;
help_line[1]:=742;help_line[0]:=743;end;error;goto 40;end{:475};
30:end{:474}else scan_left_brace;{477:}unbalance:=1;
while true do begin if xpand then{478:}begin while true do begin
get_next;if cur_cmd<=100 then goto 32;
if cur_cmd<>109 then expand else begin q:=the_toks;
if mem[29997].hh.rh<>0 then begin mem[p].hh.rh:=mem[29997].hh.rh;p:=q;
end;end;end;32:x_token end{:478}else get_token;
if cur_tok<768 then if cur_cmd<2 then unbalance:=unbalance+1 else begin
unbalance:=unbalance-1;if unbalance=0 then goto 40;
end else if cur_cmd=6 then if macro_def then{479:}begin s:=cur_tok;
if xpand then get_x_token else get_token;
if cur_cmd<>6 then if(cur_tok<=3120)or(cur_tok>t)then begin begin if
interaction=3 then;print_nl(262);print(749);end;
sprint_cs(warning_index);begin help_ptr:=3;help_line[2]:=750;
help_line[1]:=751;help_line[0]:=752;end;back_error;cur_tok:=s;
end else cur_tok:=1232+cur_chr;end{:479};begin q:=get_avail;
mem[p].hh.rh:=q;mem[q].hh.lh:=cur_tok;p:=q;end;end{:477};
40:scanner_status:=0;if hash_brace<>0 then begin q:=get_avail;
mem[p].hh.rh:=q;mem[q].hh.lh:=hash_brace;p:=q;end;scan_toks:=p;end;
{:473}{482:}procedure read_toks(n:integer;r:halfword);label 30;
var p:halfword;q:halfword;s:integer;m:small_number;
begin scanner_status:=2;warning_index:=r;def_ref:=get_avail;
mem[def_ref].hh.lh:=0;p:=def_ref;begin q:=get_avail;mem[p].hh.rh:=q;
mem[q].hh.lh:=3584;p:=q;end;if(n<0)or(n>15)then m:=16 else m:=n;
s:=align_state;align_state:=1000000;repeat{483:}begin_file_reading;
cur_input.name_field:=m+1;
if read_open[m]=2 then{484:}if interaction>1 then if n<0 then begin;
print(338);term_input;end else begin;print_ln;sprint_cs(r);begin;
print(61);term_input;end;n:=-1;
end else fatal_error(753){:484}else if read_open[m]=1 then{485:}if
input_ln(read_file[m],false)then read_open[m]:=0 else begin a_close(
read_file[m]);read_open[m]:=2;
end{:485}else{486:}begin if not input_ln(read_file[m],true)then begin
a_close(read_file[m]);read_open[m]:=2;
if align_state<>1000000 then begin runaway;begin if interaction=3 then;
print_nl(262);print(754);end;print_esc(534);begin help_ptr:=1;
help_line[0]:=755;end;align_state:=1000000;error;end;end;end{:486};
cur_input.limit_field:=last;
if(eqtb[5311].int<0)or(eqtb[5311].int>255)then cur_input.limit_field:=
cur_input.limit_field-1 else buffer[cur_input.limit_field]:=eqtb[5311].
int;first:=cur_input.limit_field+1;
cur_input.loc_field:=cur_input.start_field;cur_input.state_field:=33;
while true do begin get_token;if cur_tok=0 then goto 30;
if align_state<1000000 then begin repeat get_token;until cur_tok=0;
align_state:=1000000;goto 30;end;begin q:=get_avail;mem[p].hh.rh:=q;
mem[q].hh.lh:=cur_tok;p:=q;end;end;30:end_file_reading{:483};
until align_state=1000000;cur_val:=def_ref;scanner_status:=0;
align_state:=s;end;{:482}{494:}procedure pass_text;label 30;
var l:integer;save_scanner_status:small_number;
begin save_scanner_status:=scanner_status;scanner_status:=1;l:=0;
skip_line:=line;while true do begin get_next;
if cur_cmd=106 then begin if l=0 then goto 30;if cur_chr=2 then l:=l-1;
end else if cur_cmd=105 then l:=l+1;end;
30:scanner_status:=save_scanner_status;end;
{:494}{497:}procedure change_if_limit(l:small_number;p:halfword);
label 10;var q:halfword;
begin if p=cond_ptr then if_limit:=l else begin q:=cond_ptr;
while true do begin if q=0 then confusion(756);
if mem[q].hh.rh=p then begin mem[q].hh.b0:=l;goto 10;end;
q:=mem[q].hh.rh;end;end;10:end;{:497}{498:}procedure conditional;
label 10,50;var b:boolean;r:60..62;m,n:integer;p,q:halfword;
save_scanner_status:small_number;save_cond_ptr:halfword;
this_if:small_number;begin{495:}begin p:=get_node(2);
mem[p].hh.rh:=cond_ptr;mem[p].hh.b0:=if_limit;mem[p].hh.b1:=cur_if;
mem[p+1].int:=if_line;cond_ptr:=p;cur_if:=cur_chr;if_limit:=1;
if_line:=line;end{:495};save_cond_ptr:=cond_ptr;this_if:=cur_chr;
{501:}case this_if of 0,1:{506:}begin begin get_x_token;
if cur_cmd=0 then if cur_chr=257 then begin cur_cmd:=13;
cur_chr:=cur_tok-4096;end;end;
if(cur_cmd>13)or(cur_chr>255)then begin m:=0;n:=256;
end else begin m:=cur_cmd;n:=cur_chr;end;begin get_x_token;
if cur_cmd=0 then if cur_chr=257 then begin cur_cmd:=13;
cur_chr:=cur_tok-4096;end;end;
if(cur_cmd>13)or(cur_chr>255)then begin cur_cmd:=0;cur_chr:=256;end;
if this_if=0 then b:=(n=cur_chr)else b:=(m=cur_cmd);end{:506};
2,3:{503:}begin if this_if=2 then scan_int else scan_dimen(false,false,
false);n:=cur_val;{406:}repeat get_x_token;until cur_cmd<>10{:406};
if(cur_tok>=3132)and(cur_tok<=3134)then r:=cur_tok-3072 else begin begin
if interaction=3 then;print_nl(262);print(780);end;
print_cmd_chr(105,this_if);begin help_ptr:=1;help_line[0]:=781;end;
back_error;r:=61;end;
if this_if=2 then scan_int else scan_dimen(false,false,false);
case r of 60:b:=(n<cur_val);61:b:=(n=cur_val);62:b:=(n>cur_val);end;
end{:503};4:{504:}begin scan_int;b:=odd(cur_val);end{:504};
5:b:=(abs(cur_list.mode_field)=1);6:b:=(abs(cur_list.mode_field)=102);
7:b:=(abs(cur_list.mode_field)=203);8:b:=(cur_list.mode_field<0);
9,10,11:{505:}begin scan_eight_bit_int;p:=eqtb[3678+cur_val].hh.rh;
if this_if=9 then b:=(p=0)else if p=0 then b:=false else if this_if=10
then b:=(mem[p].hh.b0=0)else b:=(mem[p].hh.b0=1);end{:505};
12:{507:}begin save_scanner_status:=scanner_status;scanner_status:=0;
get_next;n:=cur_cs;p:=cur_cmd;q:=cur_chr;get_next;
if cur_cmd<>p then b:=false else if cur_cmd<111 then b:=(cur_chr=q)else
{508:}begin p:=mem[cur_chr].hh.rh;q:=mem[eqtb[n].hh.rh].hh.rh;
if p=q then b:=true else begin while(p<>0)and(q<>0)do if mem[p].hh.lh<>
mem[q].hh.lh then p:=0 else begin p:=mem[p].hh.rh;q:=mem[q].hh.rh;end;
b:=((p=0)and(q=0));end;end{:508};scanner_status:=save_scanner_status;
end{:507};13:begin scan_four_bit_int;b:=(read_open[cur_val]=2);end;
14:b:=true;15:b:=false;16:{509:}begin scan_int;n:=cur_val;
if eqtb[5299].int>1 then begin begin_diagnostic;print(782);print_int(n);
print_char(125);end_diagnostic(false);end;while n<>0 do begin pass_text;
if cond_ptr=save_cond_ptr then if cur_chr=4 then n:=n-1 else goto 50
else if cur_chr=2 then{496:}begin p:=cond_ptr;if_line:=mem[p+1].int;
cur_if:=mem[p].hh.b1;if_limit:=mem[p].hh.b0;cond_ptr:=mem[p].hh.rh;
free_node(p,2);end{:496};end;change_if_limit(4,save_cond_ptr);goto 10;
end{:509};end{:501};
if eqtb[5299].int>1 then{502:}begin begin_diagnostic;
if b then print(778)else print(779);end_diagnostic(false);end{:502};
if b then begin change_if_limit(3,save_cond_ptr);goto 10;end;
{500:}while true do begin pass_text;
if cond_ptr=save_cond_ptr then begin if cur_chr<>4 then goto 50;
begin if interaction=3 then;print_nl(262);print(776);end;print_esc(774);
begin help_ptr:=1;help_line[0]:=777;end;error;
end else if cur_chr=2 then{496:}begin p:=cond_ptr;if_line:=mem[p+1].int;
cur_if:=mem[p].hh.b1;if_limit:=mem[p].hh.b0;cond_ptr:=mem[p].hh.rh;
free_node(p,2);end{:496};end{:500};
50:if cur_chr=2 then{496:}begin p:=cond_ptr;if_line:=mem[p+1].int;
cur_if:=mem[p].hh.b1;if_limit:=mem[p].hh.b0;cond_ptr:=mem[p].hh.rh;
free_node(p,2);end{:496}else if_limit:=2;10:end;
{:498}{515:}procedure begin_name;begin area_delimiter:=0;
ext_delimiter:=0;end;
{:515}{516:}function more_name(c:ASCII_code):boolean;
begin if c=32 then more_name:=false else begin begin if pool_ptr+1>
pool_size then overflow(257,pool_size-init_pool_ptr);end;
begin str_pool[pool_ptr]:=c;pool_ptr:=pool_ptr+1;end;
if(c=62)or(c=58)then begin area_delimiter:=(pool_ptr-str_start[str_ptr])
;ext_delimiter:=0;
end else if(c=46)and(ext_delimiter=0)then ext_delimiter:=(pool_ptr-
str_start[str_ptr]);more_name:=true;end;end;
{:516}{517:}procedure end_name;
begin if str_ptr+3>max_strings then overflow(258,max_strings-
init_str_ptr);
if area_delimiter=0 then cur_area:=338 else begin cur_area:=str_ptr;
str_start[str_ptr+1]:=str_start[str_ptr]+area_delimiter;
str_ptr:=str_ptr+1;end;if ext_delimiter=0 then begin cur_ext:=338;
cur_name:=make_string;end else begin cur_name:=str_ptr;
str_start[str_ptr+1]:=str_start[str_ptr]+ext_delimiter-area_delimiter-1;
str_ptr:=str_ptr+1;cur_ext:=make_string;end;end;
{:517}{519:}procedure pack_file_name(n,a,e:str_number);var k:integer;
c:ASCII_code;j:pool_pointer;begin k:=0;
for j:=str_start[a]to str_start[a+1]-1 do begin c:=str_pool[j];k:=k+1;
if k<=file_name_size then name_of_file[k]:=xchr[c];end;
for j:=str_start[n]to str_start[n+1]-1 do begin c:=str_pool[j];k:=k+1;
if k<=file_name_size then name_of_file[k]:=xchr[c];end;
for j:=str_start[e]to str_start[e+1]-1 do begin c:=str_pool[j];k:=k+1;
if k<=file_name_size then name_of_file[k]:=xchr[c];end;
if k<=file_name_size then name_length:=k else name_length:=
file_name_size;
for k:=name_length+1 to file_name_size do name_of_file[k]:=' ';end;
{:519}{523:}procedure pack_buffered_name(n:small_number;a,b:integer);
var k:integer;c:ASCII_code;j:integer;
begin if n+b-a+5>file_name_size then b:=a+file_name_size-n-5;k:=0;
for j:=1 to n do begin c:=xord[TEX_format_default[j]];k:=k+1;
if k<=file_name_size then name_of_file[k]:=xchr[c];end;
for j:=a to b do begin c:=buffer[j];k:=k+1;
if k<=file_name_size then name_of_file[k]:=xchr[c];end;
for j:=17 to 20 do begin c:=xord[TEX_format_default[j]];k:=k+1;
if k<=file_name_size then name_of_file[k]:=xchr[c];end;
if k<=file_name_size then name_length:=k else name_length:=
file_name_size;
for k:=name_length+1 to file_name_size do name_of_file[k]:=' ';end;
{:523}{525:}function make_name_string:str_number;
var k:1..file_name_size;
begin if(pool_ptr+name_length>pool_size)or(str_ptr=max_strings)or((
pool_ptr-str_start[str_ptr])>0)then make_name_string:=63 else begin for
k:=1 to name_length do begin str_pool[pool_ptr]:=xord[name_of_file[k]];
pool_ptr:=pool_ptr+1;end;make_name_string:=make_string;end;end;
function a_make_name_string(var f:alpha_file):str_number;
begin a_make_name_string:=make_name_string;end;
function b_make_name_string(var f:byte_file):str_number;
begin b_make_name_string:=make_name_string;end;
function w_make_name_string(var f:word_file):str_number;
begin w_make_name_string:=make_name_string;end;
{:525}{526:}procedure scan_file_name;label 30;
begin name_in_progress:=true;begin_name;{406:}repeat get_x_token;
until cur_cmd<>10{:406};
while true do begin if(cur_cmd>12)or(cur_chr>255)then begin back_input;
goto 30;end;if not more_name(cur_chr)then goto 30;get_x_token;end;
30:end_name;name_in_progress:=false;end;
{:526}{529:}procedure pack_job_name(s:str_number);begin cur_area:=338;
cur_ext:=s;cur_name:=job_name;pack_file_name(cur_name,cur_area,cur_ext);
end;{:529}{530:}procedure prompt_file_name(s,e:str_number);label 30;
var k:0..buf_size;begin if interaction=2 then;
if s=786 then begin if interaction=3 then;print_nl(262);print(787);
end else begin if interaction=3 then;print_nl(262);print(788);end;
print_file_name(cur_name,cur_area,cur_ext);print(789);
if e=790 then show_context;print_nl(791);print(s);
if interaction<2 then fatal_error(792);break_in(term_in,true);begin;
print(568);term_input;end;{531:}begin begin_name;k:=first;
while(buffer[k]=32)and(k<last)do k:=k+1;
while true do begin if k=last then goto 30;
if not more_name(buffer[k])then goto 30;k:=k+1;end;30:end_name;
end{:531};if cur_ext=338 then cur_ext:=e;
pack_file_name(cur_name,cur_area,cur_ext);end;
{:530}{534:}procedure open_log_file;var old_setting:0..21;k:0..buf_size;
l:0..buf_size;months:packed array[1..36]of char;
begin old_setting:=selector;if job_name=0 then job_name:=795;
pack_job_name(796);
while not a_open_out(log_file)do{535:}begin selector:=17;
prompt_file_name(798,796);end{:535};
log_name:=a_make_name_string(log_file);selector:=18;log_opened:=true;
{536:}begin write(log_file,'This is TeX, Version 3.1415926');
slow_print(format_ident);print(799);print_int(eqtb[5284].int);
print_char(32);months:='JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC';
for k:=3*eqtb[5285].int-2 to 3*eqtb[5285].int do write(log_file,months[k
]);print_char(32);print_int(eqtb[5286].int);print_char(32);
print_two(eqtb[5283].int div 60);print_char(58);
print_two(eqtb[5283].int mod 60);end{:536};
input_stack[input_ptr]:=cur_input;print_nl(797);
l:=input_stack[0].limit_field;if buffer[l]=eqtb[5311].int then l:=l-1;
for k:=1 to l do print(buffer[k]);print_ln;selector:=old_setting+2;end;
{:534}{537:}procedure start_input;label 30;begin scan_file_name;
if cur_ext=338 then cur_ext:=790;
pack_file_name(cur_name,cur_area,cur_ext);
while true do begin begin_file_reading;
if a_open_in(input_file[cur_input.index_field])then goto 30;
if cur_area=338 then begin pack_file_name(cur_name,783,cur_ext);
if a_open_in(input_file[cur_input.index_field])then goto 30;end;
end_file_reading;prompt_file_name(786,790);end;
30:cur_input.name_field:=a_make_name_string(input_file[cur_input.
index_field]);if job_name=0 then begin job_name:=cur_name;open_log_file;
end;
if term_offset+(str_start[cur_input.name_field+1]-str_start[cur_input.
name_field])>max_print_line-2 then print_ln else if(term_offset>0)or(
file_offset>0)then print_char(32);print_char(40);
open_parens:=open_parens+1;slow_print(cur_input.name_field);
break(term_out);cur_input.state_field:=33;
if cur_input.name_field=str_ptr-1 then begin begin str_ptr:=str_ptr-1;
pool_ptr:=str_start[str_ptr];end;cur_input.name_field:=cur_name;end;
{538:}begin line:=1;
if input_ln(input_file[cur_input.index_field],false)then;
firm_up_the_line;
if(eqtb[5311].int<0)or(eqtb[5311].int>255)then cur_input.limit_field:=
cur_input.limit_field-1 else buffer[cur_input.limit_field]:=eqtb[5311].
int;first:=cur_input.limit_field+1;
cur_input.loc_field:=cur_input.start_field;end{:538};end;
{:537}{560:}function read_font_info(u:halfword;nom,aire:str_number;
s:scaled):internal_font_number;label 30,11,45;var k:font_index;
file_opened:boolean;lf,lh,bc,ec,nw,nh,nd,ni,nl,nk,ne,np:halfword;
f:internal_font_number;g:internal_font_number;a,b,c,d:eight_bits;
qw:four_quarters;sw:scaled;bch_label:integer;bchar:0..256;z:scaled;
alpha:integer;beta:1..16;begin g:=0;{562:}{563:}file_opened:=false;
if aire=338 then pack_file_name(nom,784,810)else pack_file_name(nom,aire
,810);if not b_open_in(tfm_file)then goto 11;file_opened:=true{:563};
{565:}begin begin lf:=tfm_file^;if lf>127 then goto 11;get(tfm_file);
lf:=lf*256+tfm_file^;end;get(tfm_file);begin lh:=tfm_file^;
if lh>127 then goto 11;get(tfm_file);lh:=lh*256+tfm_file^;end;
get(tfm_file);begin bc:=tfm_file^;if bc>127 then goto 11;get(tfm_file);
bc:=bc*256+tfm_file^;end;get(tfm_file);begin ec:=tfm_file^;
if ec>127 then goto 11;get(tfm_file);ec:=ec*256+tfm_file^;end;
if(bc>ec+1)or(ec>255)then goto 11;if bc>255 then begin bc:=1;ec:=0;end;
get(tfm_file);begin nw:=tfm_file^;if nw>127 then goto 11;get(tfm_file);
nw:=nw*256+tfm_file^;end;get(tfm_file);begin nh:=tfm_file^;
if nh>127 then goto 11;get(tfm_file);nh:=nh*256+tfm_file^;end;
get(tfm_file);begin nd:=tfm_file^;if nd>127 then goto 11;get(tfm_file);
nd:=nd*256+tfm_file^;end;get(tfm_file);begin ni:=tfm_file^;
if ni>127 then goto 11;get(tfm_file);ni:=ni*256+tfm_file^;end;
get(tfm_file);begin nl:=tfm_file^;if nl>127 then goto 11;get(tfm_file);
nl:=nl*256+tfm_file^;end;get(tfm_file);begin nk:=tfm_file^;
if nk>127 then goto 11;get(tfm_file);nk:=nk*256+tfm_file^;end;
get(tfm_file);begin ne:=tfm_file^;if ne>127 then goto 11;get(tfm_file);
ne:=ne*256+tfm_file^;end;get(tfm_file);begin np:=tfm_file^;
if np>127 then goto 11;get(tfm_file);np:=np*256+tfm_file^;end;
if lf<>6+lh+(ec-bc+1)+nw+nh+nd+ni+nl+nk+ne+np then goto 11;
if(nw=0)or(nh=0)or(nd=0)or(ni=0)then goto 11;end{:565};
{566:}lf:=lf-6-lh;if np<7 then lf:=lf+7-np;
if(font_ptr=font_max)or(fmem_ptr+lf>font_mem_size)then{567:}begin begin
if interaction=3 then;print_nl(262);print(801);end;sprint_cs(u);
print_char(61);print_file_name(nom,aire,338);
if s>=0 then begin print(741);print_scaled(s);print(397);
end else if s<>-1000 then begin print(802);print_int(-s);end;print(811);
begin help_ptr:=4;help_line[3]:=812;help_line[2]:=813;help_line[1]:=814;
help_line[0]:=815;end;error;goto 30;end{:567};f:=font_ptr+1;
char_base[f]:=fmem_ptr-bc;width_base[f]:=char_base[f]+ec+1;
height_base[f]:=width_base[f]+nw;depth_base[f]:=height_base[f]+nh;
italic_base[f]:=depth_base[f]+nd;lig_kern_base[f]:=italic_base[f]+ni;
kern_base[f]:=lig_kern_base[f]+nl-256*(128);
exten_base[f]:=kern_base[f]+256*(128)+nk;
param_base[f]:=exten_base[f]+ne{:566};{568:}begin if lh<2 then goto 11;
begin get(tfm_file);a:=tfm_file^;qw.b0:=a+0;get(tfm_file);b:=tfm_file^;
qw.b1:=b+0;get(tfm_file);c:=tfm_file^;qw.b2:=c+0;get(tfm_file);
d:=tfm_file^;qw.b3:=d+0;font_check[f]:=qw;end;get(tfm_file);
begin z:=tfm_file^;if z>127 then goto 11;get(tfm_file);
z:=z*256+tfm_file^;end;get(tfm_file);z:=z*256+tfm_file^;get(tfm_file);
z:=(z*16)+(tfm_file^div 16);if z<65536 then goto 11;
while lh>2 do begin get(tfm_file);get(tfm_file);get(tfm_file);
get(tfm_file);lh:=lh-1;end;font_dsize[f]:=z;
if s<>-1000 then if s>=0 then z:=s else z:=xn_over_d(z,-s,1000);
font_size[f]:=z;end{:568};
{569:}for k:=fmem_ptr to width_base[f]-1 do begin begin get(tfm_file);
a:=tfm_file^;qw.b0:=a+0;get(tfm_file);b:=tfm_file^;qw.b1:=b+0;
get(tfm_file);c:=tfm_file^;qw.b2:=c+0;get(tfm_file);d:=tfm_file^;
qw.b3:=d+0;font_info[k].qqqq:=qw;end;
if(a>=nw)or(b div 16>=nh)or(b mod 16>=nd)or(c div 4>=ni)then goto 11;
case c mod 4 of 1:if d>=nl then goto 11;3:if d>=ne then goto 11;
2:{570:}begin begin if(d<bc)or(d>ec)then goto 11 end;
while d<k+bc-fmem_ptr do begin qw:=font_info[char_base[f]+d].qqqq;
if((qw.b2-0)mod 4)<>2 then goto 45;d:=qw.b3-0;end;
if d=k+bc-fmem_ptr then goto 11;45:end{:570};others:end;end{:569};
{571:}begin{572:}begin alpha:=16;while z>=8388608 do begin z:=z div 2;
alpha:=alpha+alpha;end;beta:=256 div alpha;alpha:=alpha*z;end{:572};
for k:=width_base[f]to lig_kern_base[f]-1 do begin get(tfm_file);
a:=tfm_file^;get(tfm_file);b:=tfm_file^;get(tfm_file);c:=tfm_file^;
get(tfm_file);d:=tfm_file^;
sw:=(((((d*z)div 256)+(c*z))div 256)+(b*z))div beta;
if a=0 then font_info[k].int:=sw else if a=255 then font_info[k].int:=sw
-alpha else goto 11;end;if font_info[width_base[f]].int<>0 then goto 11;
if font_info[height_base[f]].int<>0 then goto 11;
if font_info[depth_base[f]].int<>0 then goto 11;
if font_info[italic_base[f]].int<>0 then goto 11;end{:571};
{573:}bch_label:=32767;bchar:=256;
if nl>0 then begin for k:=lig_kern_base[f]to kern_base[f]+256*(128)-1 do
begin begin get(tfm_file);a:=tfm_file^;qw.b0:=a+0;get(tfm_file);
b:=tfm_file^;qw.b1:=b+0;get(tfm_file);c:=tfm_file^;qw.b2:=c+0;
get(tfm_file);d:=tfm_file^;qw.b3:=d+0;font_info[k].qqqq:=qw;end;
if a>128 then begin if 256*c+d>=nl then goto 11;
if a=255 then if k=lig_kern_base[f]then bchar:=b;
end else begin if b<>bchar then begin begin if(b<bc)or(b>ec)then goto 11
end;qw:=font_info[char_base[f]+b].qqqq;if not(qw.b0>0)then goto 11;end;
if c<128 then begin begin if(d<bc)or(d>ec)then goto 11 end;
qw:=font_info[char_base[f]+d].qqqq;if not(qw.b0>0)then goto 11;
end else if 256*(c-128)+d>=nk then goto 11;
if a<128 then if k-lig_kern_base[f]+a+1>=nl then goto 11;end;end;
if a=255 then bch_label:=256*c+d;end;
for k:=kern_base[f]+256*(128)to exten_base[f]-1 do begin get(tfm_file);
a:=tfm_file^;get(tfm_file);b:=tfm_file^;get(tfm_file);c:=tfm_file^;
get(tfm_file);d:=tfm_file^;
sw:=(((((d*z)div 256)+(c*z))div 256)+(b*z))div beta;
if a=0 then font_info[k].int:=sw else if a=255 then font_info[k].int:=sw
-alpha else goto 11;end;{:573};
{574:}for k:=exten_base[f]to param_base[f]-1 do begin begin get(tfm_file
);a:=tfm_file^;qw.b0:=a+0;get(tfm_file);b:=tfm_file^;qw.b1:=b+0;
get(tfm_file);c:=tfm_file^;qw.b2:=c+0;get(tfm_file);d:=tfm_file^;
qw.b3:=d+0;font_info[k].qqqq:=qw;end;
if a<>0 then begin begin if(a<bc)or(a>ec)then goto 11 end;
qw:=font_info[char_base[f]+a].qqqq;if not(qw.b0>0)then goto 11;end;
if b<>0 then begin begin if(b<bc)or(b>ec)then goto 11 end;
qw:=font_info[char_base[f]+b].qqqq;if not(qw.b0>0)then goto 11;end;
if c<>0 then begin begin if(c<bc)or(c>ec)then goto 11 end;
qw:=font_info[char_base[f]+c].qqqq;if not(qw.b0>0)then goto 11;end;
begin begin if(d<bc)or(d>ec)then goto 11 end;
qw:=font_info[char_base[f]+d].qqqq;if not(qw.b0>0)then goto 11;end;
end{:574};{575:}begin for k:=1 to np do if k=1 then begin get(tfm_file);
sw:=tfm_file^;if sw>127 then sw:=sw-256;get(tfm_file);
sw:=sw*256+tfm_file^;get(tfm_file);sw:=sw*256+tfm_file^;get(tfm_file);
font_info[param_base[f]].int:=(sw*16)+(tfm_file^div 16);
end else begin get(tfm_file);a:=tfm_file^;get(tfm_file);b:=tfm_file^;
get(tfm_file);c:=tfm_file^;get(tfm_file);d:=tfm_file^;
sw:=(((((d*z)div 256)+(c*z))div 256)+(b*z))div beta;
if a=0 then font_info[param_base[f]+k-1].int:=sw else if a=255 then
font_info[param_base[f]+k-1].int:=sw-alpha else goto 11;end;
if eof(tfm_file)then goto 11;
for k:=np+1 to 7 do font_info[param_base[f]+k-1].int:=0;end{:575};
{576:}if np>=7 then font_params[f]:=np else font_params[f]:=7;
hyphen_char[f]:=eqtb[5309].int;skew_char[f]:=eqtb[5310].int;
if bch_label<nl then bchar_label[f]:=bch_label+lig_kern_base[f]else
bchar_label[f]:=0;font_bchar[f]:=bchar+0;font_false_bchar[f]:=bchar+0;
if bchar<=ec then if bchar>=bc then begin qw:=font_info[char_base[f]+
bchar].qqqq;if(qw.b0>0)then font_false_bchar[f]:=256;end;
font_name[f]:=nom;font_area[f]:=aire;font_bc[f]:=bc;font_ec[f]:=ec;
font_glue[f]:=0;char_base[f]:=char_base[f]-0;
width_base[f]:=width_base[f]-0;lig_kern_base[f]:=lig_kern_base[f]-0;
kern_base[f]:=kern_base[f]-0;exten_base[f]:=exten_base[f]-0;
param_base[f]:=param_base[f]-1;fmem_ptr:=fmem_ptr+lf;font_ptr:=f;g:=f;
goto 30{:576}{:562};11:{561:}begin if interaction=3 then;print_nl(262);
print(801);end;sprint_cs(u);print_char(61);
print_file_name(nom,aire,338);if s>=0 then begin print(741);
print_scaled(s);print(397);end else if s<>-1000 then begin print(802);
print_int(-s);end;if file_opened then print(803)else print(804);
begin help_ptr:=5;help_line[4]:=805;help_line[3]:=806;help_line[2]:=807;
help_line[1]:=808;help_line[0]:=809;end;error{:561};
30:if file_opened then b_close(tfm_file);read_font_info:=g;end;
{:560}{581:}procedure char_warning(f:internal_font_number;c:eight_bits);
begin if eqtb[5298].int>0 then begin begin_diagnostic;print_nl(824);
print(c);print(825);slow_print(font_name[f]);print_char(33);
end_diagnostic(false);end;end;
{:581}{582:}function new_character(f:internal_font_number;
c:eight_bits):halfword;label 10;var p:halfword;
begin if font_bc[f]<=c then if font_ec[f]>=c then if(font_info[char_base
[f]+c+0].qqqq.b0>0)then begin p:=get_avail;mem[p].hh.b0:=f;
mem[p].hh.b1:=c+0;new_character:=p;goto 10;end;char_warning(f,c);
new_character:=0;10:end;{:582}{597:}procedure write_dvi(a,b:dvi_index);
var k:dvi_index;begin for k:=a to b do write(dvi_file,dvi_buf[k]);end;
{:597}{598:}procedure dvi_swap;
begin if dvi_limit=dvi_buf_size then begin write_dvi(0,half_buf-1);
dvi_limit:=half_buf;dvi_offset:=dvi_offset+dvi_buf_size;dvi_ptr:=0;
end else begin write_dvi(half_buf,dvi_buf_size-1);
dvi_limit:=dvi_buf_size;end;dvi_gone:=dvi_gone+half_buf;end;
{:598}{600:}procedure dvi_four(x:integer);
begin if x>=0 then begin dvi_buf[dvi_ptr]:=x div 16777216;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;
end else begin x:=x+1073741824;x:=x+1073741824;
begin dvi_buf[dvi_ptr]:=(x div 16777216)+128;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;end;x:=x mod 16777216;
begin dvi_buf[dvi_ptr]:=x div 65536;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;x:=x mod 65536;
begin dvi_buf[dvi_ptr]:=x div 256;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=x mod 256;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;end;
{:600}{601:}procedure dvi_pop(l:integer);
begin if(l=dvi_offset+dvi_ptr)and(dvi_ptr>0)then dvi_ptr:=dvi_ptr-1 else
begin dvi_buf[dvi_ptr]:=142;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;end;
{:601}{602:}procedure dvi_font_def(f:internal_font_number);
var k:pool_pointer;begin begin dvi_buf[dvi_ptr]:=243;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;begin dvi_buf[dvi_ptr]:=f-1;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=font_check[f].b0-0;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=font_check[f].b1-0;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=font_check[f].b2-0;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=font_check[f].b3-0;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;dvi_four(font_size[f]);
dvi_four(font_dsize[f]);
begin dvi_buf[dvi_ptr]:=(str_start[font_area[f]+1]-str_start[font_area[f
]]);dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=(str_start[font_name[f]+1]-str_start[font_name[f
]]);dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
{603:}for k:=str_start[font_area[f]]to str_start[font_area[f]+1]-1 do
begin dvi_buf[dvi_ptr]:=str_pool[k];dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
for k:=str_start[font_name[f]]to str_start[font_name[f]+1]-1 do begin
dvi_buf[dvi_ptr]:=str_pool[k];dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end{:603};end;
{:602}{607:}procedure movement(w:scaled;o:eight_bits);
label 10,40,45,2,1;var mstate:small_number;p,q:halfword;k:integer;
begin q:=get_node(3);mem[q+1].int:=w;mem[q+2].int:=dvi_offset+dvi_ptr;
if o=157 then begin mem[q].hh.rh:=down_ptr;down_ptr:=q;
end else begin mem[q].hh.rh:=right_ptr;right_ptr:=q;end;
{611:}p:=mem[q].hh.rh;mstate:=0;
while p<>0 do begin if mem[p+1].int=w then{612:}case mstate+mem[p].hh.lh
of 3,4,15,16:if mem[p+2].int<dvi_gone then goto 45 else{613:}begin k:=
mem[p+2].int-dvi_offset;if k<0 then k:=k+dvi_buf_size;
dvi_buf[k]:=dvi_buf[k]+5;mem[p].hh.lh:=1;goto 40;end{:613};
5,9,11:if mem[p+2].int<dvi_gone then goto 45 else{614:}begin k:=mem[p+2]
.int-dvi_offset;if k<0 then k:=k+dvi_buf_size;dvi_buf[k]:=dvi_buf[k]+10;
mem[p].hh.lh:=2;goto 40;end{:614};1,2,8,13:goto 40;
others:end{:612}else case mstate+mem[p].hh.lh of 1:mstate:=6;
2:mstate:=12;8,13:goto 45;others:end;p:=mem[p].hh.rh;end;45:{:611};
{610:}mem[q].hh.lh:=3;
if abs(w)>=8388608 then begin begin dvi_buf[dvi_ptr]:=o+3;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;dvi_four(w);
goto 10;end;if abs(w)>=32768 then begin begin dvi_buf[dvi_ptr]:=o+2;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
if w<0 then w:=w+16777216;begin dvi_buf[dvi_ptr]:=w div 65536;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
w:=w mod 65536;goto 2;end;
if abs(w)>=128 then begin begin dvi_buf[dvi_ptr]:=o+1;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
if w<0 then w:=w+65536;goto 2;end;begin dvi_buf[dvi_ptr]:=o;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
if w<0 then w:=w+256;goto 1;2:begin dvi_buf[dvi_ptr]:=w div 256;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
1:begin dvi_buf[dvi_ptr]:=w mod 256;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;goto 10{:610};
40:{609:}mem[q].hh.lh:=mem[p].hh.lh;
if mem[q].hh.lh=1 then begin begin dvi_buf[dvi_ptr]:=o+4;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
while mem[q].hh.rh<>p do begin q:=mem[q].hh.rh;
case mem[q].hh.lh of 3:mem[q].hh.lh:=5;4:mem[q].hh.lh:=6;others:end;end;
end else begin begin dvi_buf[dvi_ptr]:=o+9;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
while mem[q].hh.rh<>p do begin q:=mem[q].hh.rh;
case mem[q].hh.lh of 3:mem[q].hh.lh:=4;5:mem[q].hh.lh:=6;others:end;end;
end{:609};10:end;{:607}{615:}procedure prune_movements(l:integer);
label 30,10;var p:halfword;
begin while down_ptr<>0 do begin if mem[down_ptr+2].int<l then goto 30;
p:=down_ptr;down_ptr:=mem[p].hh.rh;free_node(p,3);end;
30:while right_ptr<>0 do begin if mem[right_ptr+2].int<l then goto 10;
p:=right_ptr;right_ptr:=mem[p].hh.rh;free_node(p,3);end;10:end;
{:615}{618:}procedure vlist_out;forward;
{:618}{619:}{1368:}procedure special_out(p:halfword);
var old_setting:0..21;k:pool_pointer;
begin if cur_h<>dvi_h then begin movement(cur_h-dvi_h,143);dvi_h:=cur_h;
end;if cur_v<>dvi_v then begin movement(cur_v-dvi_v,157);dvi_v:=cur_v;
end;old_setting:=selector;selector:=21;
show_token_list(mem[mem[p+1].hh.rh].hh.rh,0,pool_size-pool_ptr);
selector:=old_setting;
begin if pool_ptr+1>pool_size then overflow(257,pool_size-init_pool_ptr)
;end;
if(pool_ptr-str_start[str_ptr])<256 then begin begin dvi_buf[dvi_ptr]:=
239;dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=(pool_ptr-str_start[str_ptr]);
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
end else begin begin dvi_buf[dvi_ptr]:=242;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
dvi_four((pool_ptr-str_start[str_ptr]));end;
for k:=str_start[str_ptr]to pool_ptr-1 do begin dvi_buf[dvi_ptr]:=
str_pool[k];dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
pool_ptr:=str_start[str_ptr];end;
{:1368}{1370:}procedure write_out(p:halfword);var old_setting:0..21;
old_mode:integer;j:small_number;q,r:halfword;begin{1371:}q:=get_avail;
mem[q].hh.lh:=637;r:=get_avail;mem[q].hh.rh:=r;mem[r].hh.lh:=6717;
begin_token_list(q,4);begin_token_list(mem[p+1].hh.rh,15);q:=get_avail;
mem[q].hh.lh:=379;begin_token_list(q,4);old_mode:=cur_list.mode_field;
cur_list.mode_field:=0;cur_cs:=write_loc;q:=scan_toks(false,true);
get_token;if cur_tok<>6717 then{1372:}begin begin if interaction=3 then;
print_nl(262);print(1296);end;begin help_ptr:=2;help_line[1]:=1297;
help_line[0]:=1011;end;error;repeat get_token;until cur_tok=6717;
end{:1372};cur_list.mode_field:=old_mode;end_token_list{:1371};
old_setting:=selector;j:=mem[p+1].hh.lh;
if write_open[j]then selector:=j else begin if(j=17)and(selector=19)then
selector:=18;print_nl(338);end;token_show(def_ref);print_ln;
flush_list(def_ref);selector:=old_setting;end;
{:1370}{1373:}procedure out_what(p:halfword);var j:small_number;
begin case mem[p].hh.b1 of 0,1,2:{1374:}if not doing_leaders then begin
j:=mem[p+1].hh.lh;
if mem[p].hh.b1=1 then write_out(p)else begin if write_open[j]then
a_close(write_file[j]);
if mem[p].hh.b1=2 then write_open[j]:=false else if j<16 then begin
cur_name:=mem[p+1].hh.rh;cur_area:=mem[p+2].hh.lh;
cur_ext:=mem[p+2].hh.rh;if cur_ext=338 then cur_ext:=790;
pack_file_name(cur_name,cur_area,cur_ext);
while not a_open_out(write_file[j])do prompt_file_name(1299,790);
write_open[j]:=true;end;end;end{:1374};3:special_out(p);4:;
others:confusion(1298)end;end;{:1373}procedure hlist_out;
label 21,13,14,15;var base_line:scaled;left_edge:scaled;
save_h,save_v:scaled;this_box:halfword;g_order:glue_ord;g_sign:0..2;
p:halfword;save_loc:integer;leader_box:halfword;leader_wd:scaled;
lx:scaled;outer_doing_leaders:boolean;edge:scaled;glue_temp:real;
cur_glue:real;cur_g:scaled;begin cur_g:=0;cur_glue:=0.0;
this_box:=temp_ptr;g_order:=mem[this_box+5].hh.b1;
g_sign:=mem[this_box+5].hh.b0;p:=mem[this_box+5].hh.rh;cur_s:=cur_s+1;
if cur_s>0 then begin dvi_buf[dvi_ptr]:=141;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
if cur_s>max_push then max_push:=cur_s;save_loc:=dvi_offset+dvi_ptr;
base_line:=cur_v;left_edge:=cur_h;
while p<>0 do{620:}21:if(p>=hi_mem_min)then begin if cur_h<>dvi_h then
begin movement(cur_h-dvi_h,143);dvi_h:=cur_h;end;
if cur_v<>dvi_v then begin movement(cur_v-dvi_v,157);dvi_v:=cur_v;end;
repeat f:=mem[p].hh.b0;c:=mem[p].hh.b1;
if f<>dvi_f then{621:}begin if not font_used[f]then begin dvi_font_def(f
);font_used[f]:=true;end;if f<=64 then begin dvi_buf[dvi_ptr]:=f+170;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;
end else begin begin dvi_buf[dvi_ptr]:=235;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;begin dvi_buf[dvi_ptr]:=f-1;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;end;dvi_f:=f;
end{:621};if c>=128 then begin dvi_buf[dvi_ptr]:=128;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;begin dvi_buf[dvi_ptr]:=c-0;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
cur_h:=cur_h+font_info[width_base[f]+font_info[char_base[f]+c].qqqq.b0].
int;p:=mem[p].hh.rh;until not(p>=hi_mem_min);dvi_h:=cur_h;
end else{622:}begin case mem[p].hh.b0 of 0,1:{623:}if mem[p+5].hh.rh=0
then cur_h:=cur_h+mem[p+1].int else begin save_h:=dvi_h;save_v:=dvi_v;
cur_v:=base_line+mem[p+4].int;temp_ptr:=p;edge:=cur_h;
if mem[p].hh.b0=1 then vlist_out else hlist_out;dvi_h:=save_h;
dvi_v:=save_v;cur_h:=edge+mem[p+1].int;cur_v:=base_line;end{:623};
2:begin rule_ht:=mem[p+3].int;rule_dp:=mem[p+2].int;
rule_wd:=mem[p+1].int;goto 14;end;8:{1367:}out_what(p){:1367};
10:{625:}begin g:=mem[p+1].hh.lh;rule_wd:=mem[g+1].int-cur_g;
if g_sign<>0 then begin if g_sign=1 then begin if mem[g].hh.b0=g_order
then begin cur_glue:=cur_glue+mem[g+2].int;
glue_temp:=mem[this_box+6].gr*cur_glue;
if glue_temp>1000000000.0 then glue_temp:=1000000000.0 else if glue_temp
<-1000000000.0 then glue_temp:=-1000000000.0;cur_g:=round(glue_temp);
end;
end else if mem[g].hh.b1=g_order then begin cur_glue:=cur_glue-mem[g+3].
int;glue_temp:=mem[this_box+6].gr*cur_glue;
if glue_temp>1000000000.0 then glue_temp:=1000000000.0 else if glue_temp
<-1000000000.0 then glue_temp:=-1000000000.0;cur_g:=round(glue_temp);
end;end;rule_wd:=rule_wd+cur_g;
if mem[p].hh.b1>=100 then{626:}begin leader_box:=mem[p+1].hh.rh;
if mem[leader_box].hh.b0=2 then begin rule_ht:=mem[leader_box+3].int;
rule_dp:=mem[leader_box+2].int;goto 14;end;
leader_wd:=mem[leader_box+1].int;
if(leader_wd>0)and(rule_wd>0)then begin rule_wd:=rule_wd+10;
edge:=cur_h+rule_wd;lx:=0;
{627:}if mem[p].hh.b1=100 then begin save_h:=cur_h;
cur_h:=left_edge+leader_wd*((cur_h-left_edge)div leader_wd);
if cur_h<save_h then cur_h:=cur_h+leader_wd;
end else begin lq:=rule_wd div leader_wd;lr:=rule_wd mod leader_wd;
if mem[p].hh.b1=101 then cur_h:=cur_h+(lr div 2)else begin lx:=lr div(lq
+1);cur_h:=cur_h+((lr-(lq-1)*lx)div 2);end;end{:627};
while cur_h+leader_wd<=edge do{628:}begin cur_v:=base_line+mem[
leader_box+4].int;if cur_v<>dvi_v then begin movement(cur_v-dvi_v,157);
dvi_v:=cur_v;end;save_v:=dvi_v;
if cur_h<>dvi_h then begin movement(cur_h-dvi_h,143);dvi_h:=cur_h;end;
save_h:=dvi_h;temp_ptr:=leader_box;outer_doing_leaders:=doing_leaders;
doing_leaders:=true;
if mem[leader_box].hh.b0=1 then vlist_out else hlist_out;
doing_leaders:=outer_doing_leaders;dvi_v:=save_v;dvi_h:=save_h;
cur_v:=base_line;cur_h:=save_h+leader_wd+lx;end{:628};cur_h:=edge-10;
goto 15;end;end{:626};goto 13;end{:625};11,9:cur_h:=cur_h+mem[p+1].int;
6:{652:}begin mem[29988]:=mem[p+1];mem[29988].hh.rh:=mem[p].hh.rh;
p:=29988;goto 21;end{:652};others:end;goto 15;
14:{624:}if(rule_ht=-1073741824)then rule_ht:=mem[this_box+3].int;
if(rule_dp=-1073741824)then rule_dp:=mem[this_box+2].int;
rule_ht:=rule_ht+rule_dp;
if(rule_ht>0)and(rule_wd>0)then begin if cur_h<>dvi_h then begin
movement(cur_h-dvi_h,143);dvi_h:=cur_h;end;cur_v:=base_line+rule_dp;
if cur_v<>dvi_v then begin movement(cur_v-dvi_v,157);dvi_v:=cur_v;end;
begin dvi_buf[dvi_ptr]:=132;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;dvi_four(rule_ht);
dvi_four(rule_wd);cur_v:=base_line;dvi_h:=dvi_h+rule_wd;end{:624};
13:cur_h:=cur_h+rule_wd;15:p:=mem[p].hh.rh;end{:622}{:620};
prune_movements(save_loc);if cur_s>0 then dvi_pop(save_loc);
cur_s:=cur_s-1;end;{:619}{629:}procedure vlist_out;label 13,14,15;
var left_edge:scaled;top_edge:scaled;save_h,save_v:scaled;
this_box:halfword;g_order:glue_ord;g_sign:0..2;p:halfword;
save_loc:integer;leader_box:halfword;leader_ht:scaled;lx:scaled;
outer_doing_leaders:boolean;edge:scaled;glue_temp:real;cur_glue:real;
cur_g:scaled;begin cur_g:=0;cur_glue:=0.0;this_box:=temp_ptr;
g_order:=mem[this_box+5].hh.b1;g_sign:=mem[this_box+5].hh.b0;
p:=mem[this_box+5].hh.rh;cur_s:=cur_s+1;
if cur_s>0 then begin dvi_buf[dvi_ptr]:=141;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
if cur_s>max_push then max_push:=cur_s;save_loc:=dvi_offset+dvi_ptr;
left_edge:=cur_h;cur_v:=cur_v-mem[this_box+3].int;top_edge:=cur_v;
while p<>0 do{630:}begin if(p>=hi_mem_min)then confusion(827)else{631:}
begin case mem[p].hh.b0 of 0,1:{632:}if mem[p+5].hh.rh=0 then cur_v:=
cur_v+mem[p+3].int+mem[p+2].int else begin cur_v:=cur_v+mem[p+3].int;
if cur_v<>dvi_v then begin movement(cur_v-dvi_v,157);dvi_v:=cur_v;end;
save_h:=dvi_h;save_v:=dvi_v;cur_h:=left_edge+mem[p+4].int;temp_ptr:=p;
if mem[p].hh.b0=1 then vlist_out else hlist_out;dvi_h:=save_h;
dvi_v:=save_v;cur_v:=save_v+mem[p+2].int;cur_h:=left_edge;end{:632};
2:begin rule_ht:=mem[p+3].int;rule_dp:=mem[p+2].int;
rule_wd:=mem[p+1].int;goto 14;end;8:{1366:}out_what(p){:1366};
10:{634:}begin g:=mem[p+1].hh.lh;rule_ht:=mem[g+1].int-cur_g;
if g_sign<>0 then begin if g_sign=1 then begin if mem[g].hh.b0=g_order
then begin cur_glue:=cur_glue+mem[g+2].int;
glue_temp:=mem[this_box+6].gr*cur_glue;
if glue_temp>1000000000.0 then glue_temp:=1000000000.0 else if glue_temp
<-1000000000.0 then glue_temp:=-1000000000.0;cur_g:=round(glue_temp);
end;
end else if mem[g].hh.b1=g_order then begin cur_glue:=cur_glue-mem[g+3].
int;glue_temp:=mem[this_box+6].gr*cur_glue;
if glue_temp>1000000000.0 then glue_temp:=1000000000.0 else if glue_temp
<-1000000000.0 then glue_temp:=-1000000000.0;cur_g:=round(glue_temp);
end;end;rule_ht:=rule_ht+cur_g;
if mem[p].hh.b1>=100 then{635:}begin leader_box:=mem[p+1].hh.rh;
if mem[leader_box].hh.b0=2 then begin rule_wd:=mem[leader_box+1].int;
rule_dp:=0;goto 14;end;
leader_ht:=mem[leader_box+3].int+mem[leader_box+2].int;
if(leader_ht>0)and(rule_ht>0)then begin rule_ht:=rule_ht+10;
edge:=cur_v+rule_ht;lx:=0;
{636:}if mem[p].hh.b1=100 then begin save_v:=cur_v;
cur_v:=top_edge+leader_ht*((cur_v-top_edge)div leader_ht);
if cur_v<save_v then cur_v:=cur_v+leader_ht;
end else begin lq:=rule_ht div leader_ht;lr:=rule_ht mod leader_ht;
if mem[p].hh.b1=101 then cur_v:=cur_v+(lr div 2)else begin lx:=lr div(lq
+1);cur_v:=cur_v+((lr-(lq-1)*lx)div 2);end;end{:636};
while cur_v+leader_ht<=edge do{637:}begin cur_h:=left_edge+mem[
leader_box+4].int;if cur_h<>dvi_h then begin movement(cur_h-dvi_h,143);
dvi_h:=cur_h;end;save_h:=dvi_h;cur_v:=cur_v+mem[leader_box+3].int;
if cur_v<>dvi_v then begin movement(cur_v-dvi_v,157);dvi_v:=cur_v;end;
save_v:=dvi_v;temp_ptr:=leader_box;outer_doing_leaders:=doing_leaders;
doing_leaders:=true;
if mem[leader_box].hh.b0=1 then vlist_out else hlist_out;
doing_leaders:=outer_doing_leaders;dvi_v:=save_v;dvi_h:=save_h;
cur_h:=left_edge;cur_v:=save_v-mem[leader_box+3].int+leader_ht+lx;
end{:637};cur_v:=edge-10;goto 15;end;end{:635};goto 13;end{:634};
11:cur_v:=cur_v+mem[p+1].int;others:end;goto 15;
14:{633:}if(rule_wd=-1073741824)then rule_wd:=mem[this_box+1].int;
rule_ht:=rule_ht+rule_dp;cur_v:=cur_v+rule_ht;
if(rule_ht>0)and(rule_wd>0)then begin if cur_h<>dvi_h then begin
movement(cur_h-dvi_h,143);dvi_h:=cur_h;end;
if cur_v<>dvi_v then begin movement(cur_v-dvi_v,157);dvi_v:=cur_v;end;
begin dvi_buf[dvi_ptr]:=137;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;dvi_four(rule_ht);
dvi_four(rule_wd);end;goto 15{:633};13:cur_v:=cur_v+rule_ht;end{:631};
15:p:=mem[p].hh.rh;end{:630};prune_movements(save_loc);
if cur_s>0 then dvi_pop(save_loc);cur_s:=cur_s-1;end;
{:629}{638:}procedure ship_out(p:halfword);label 30;
var page_loc:integer;j,k:0..9;s:pool_pointer;old_setting:0..21;
begin if eqtb[5297].int>0 then begin print_nl(338);print_ln;print(828);
end;
if term_offset>max_print_line-9 then print_ln else if(term_offset>0)or(
file_offset>0)then print_char(32);print_char(91);j:=9;
while(eqtb[5318+j].int=0)and(j>0)do j:=j-1;
for k:=0 to j do begin print_int(eqtb[5318+k].int);
if k<j then print_char(46);end;break(term_out);
if eqtb[5297].int>0 then begin print_char(93);begin_diagnostic;
show_box(p);end_diagnostic(true);end;
{640:}{641:}if(mem[p+3].int>1073741823)or(mem[p+2].int>1073741823)or(mem
[p+3].int+mem[p+2].int+eqtb[5849].int>1073741823)or(mem[p+1].int+eqtb[
5848].int>1073741823)then begin begin if interaction=3 then;
print_nl(262);print(832);end;begin help_ptr:=2;help_line[1]:=833;
help_line[0]:=834;end;error;
if eqtb[5297].int<=0 then begin begin_diagnostic;print_nl(835);
show_box(p);end_diagnostic(true);end;goto 30;end;
if mem[p+3].int+mem[p+2].int+eqtb[5849].int>max_v then max_v:=mem[p+3].
int+mem[p+2].int+eqtb[5849].int;
if mem[p+1].int+eqtb[5848].int>max_h then max_h:=mem[p+1].int+eqtb[5848]
.int{:641};{617:}dvi_h:=0;dvi_v:=0;cur_h:=eqtb[5848].int;dvi_f:=0;
if output_file_name=0 then begin if job_name=0 then open_log_file;
pack_job_name(793);
while not b_open_out(dvi_file)do prompt_file_name(794,793);
output_file_name:=b_make_name_string(dvi_file);end;
if total_pages=0 then begin begin dvi_buf[dvi_ptr]:=247;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=2;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;dvi_four(25400000);
dvi_four(473628672);prepare_mag;dvi_four(eqtb[5280].int);
old_setting:=selector;selector:=21;print(826);print_int(eqtb[5286].int);
print_char(46);print_two(eqtb[5285].int);print_char(46);
print_two(eqtb[5284].int);print_char(58);
print_two(eqtb[5283].int div 60);print_two(eqtb[5283].int mod 60);
selector:=old_setting;
begin dvi_buf[dvi_ptr]:=(pool_ptr-str_start[str_ptr]);
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
for s:=str_start[str_ptr]to pool_ptr-1 do begin dvi_buf[dvi_ptr]:=
str_pool[s];dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
pool_ptr:=str_start[str_ptr];end{:617};page_loc:=dvi_offset+dvi_ptr;
begin dvi_buf[dvi_ptr]:=139;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
for k:=0 to 9 do dvi_four(eqtb[5318+k].int);dvi_four(last_bop);
last_bop:=page_loc;cur_v:=mem[p+3].int+eqtb[5849].int;temp_ptr:=p;
if mem[p].hh.b0=1 then vlist_out else hlist_out;
begin dvi_buf[dvi_ptr]:=140;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;total_pages:=total_pages+1;
cur_s:=-1;30:{:640};if eqtb[5297].int<=0 then print_char(93);
dead_cycles:=0;break(term_out);
{639:}{if eqtb[5294].int>1 then begin print_nl(829);print_int(var_used);
print_char(38);print_int(dyn_used);print_char(59);end;}
flush_node_list(p);{if eqtb[5294].int>1 then begin print(830);
print_int(var_used);print_char(38);print_int(dyn_used);print(831);
print_int(hi_mem_min-lo_mem_max-1);print_ln;end;}{:639};end;
{:638}{645:}procedure scan_spec(c:group_code;three_codes:boolean);
label 40;var s:integer;spec_code:0..1;
begin if three_codes then s:=save_stack[save_ptr+0].int;
if scan_keyword(841)then spec_code:=0 else if scan_keyword(842)then
spec_code:=1 else begin spec_code:=1;cur_val:=0;goto 40;end;
scan_dimen(false,false,false);
40:if three_codes then begin save_stack[save_ptr+0].int:=s;
save_ptr:=save_ptr+1;end;save_stack[save_ptr+0].int:=spec_code;
save_stack[save_ptr+1].int:=cur_val;save_ptr:=save_ptr+2;
new_save_level(c);scan_left_brace;end;
{:645}{649:}function hpack(p:halfword;w:scaled;m:small_number):halfword;
label 21,50,10;var r:halfword;q:halfword;h,d,x:scaled;s:scaled;
g:halfword;o:glue_ord;f:internal_font_number;i:four_quarters;
hd:eight_bits;begin last_badness:=0;r:=get_node(7);mem[r].hh.b0:=0;
mem[r].hh.b1:=0;mem[r+4].int:=0;q:=r+5;mem[q].hh.rh:=p;h:=0;{650:}d:=0;
x:=0;total_stretch[0]:=0;total_shrink[0]:=0;total_stretch[1]:=0;
total_shrink[1]:=0;total_stretch[2]:=0;total_shrink[2]:=0;
total_stretch[3]:=0;total_shrink[3]:=0{:650};
while p<>0 do{651:}begin 21:while(p>=hi_mem_min)do{654:}begin f:=mem[p].
hh.b0;i:=font_info[char_base[f]+mem[p].hh.b1].qqqq;hd:=i.b1-0;
x:=x+font_info[width_base[f]+i.b0].int;
s:=font_info[height_base[f]+(hd)div 16].int;if s>h then h:=s;
s:=font_info[depth_base[f]+(hd)mod 16].int;if s>d then d:=s;
p:=mem[p].hh.rh;end{:654};
if p<>0 then begin case mem[p].hh.b0 of 0,1,2,13:{653:}begin x:=x+mem[p
+1].int;if mem[p].hh.b0>=2 then s:=0 else s:=mem[p+4].int;
if mem[p+3].int-s>h then h:=mem[p+3].int-s;
if mem[p+2].int+s>d then d:=mem[p+2].int+s;end{:653};
3,4,5:if adjust_tail<>0 then{655:}begin while mem[q].hh.rh<>p do q:=mem[
q].hh.rh;
if mem[p].hh.b0=5 then begin mem[adjust_tail].hh.rh:=mem[p+1].int;
while mem[adjust_tail].hh.rh<>0 do adjust_tail:=mem[adjust_tail].hh.rh;
p:=mem[p].hh.rh;free_node(mem[q].hh.rh,2);
end else begin mem[adjust_tail].hh.rh:=p;adjust_tail:=p;p:=mem[p].hh.rh;
end;mem[q].hh.rh:=p;p:=q;end{:655};8:{1360:}{:1360};
10:{656:}begin g:=mem[p+1].hh.lh;x:=x+mem[g+1].int;o:=mem[g].hh.b0;
total_stretch[o]:=total_stretch[o]+mem[g+2].int;o:=mem[g].hh.b1;
total_shrink[o]:=total_shrink[o]+mem[g+3].int;
if mem[p].hh.b1>=100 then begin g:=mem[p+1].hh.rh;
if mem[g+3].int>h then h:=mem[g+3].int;
if mem[g+2].int>d then d:=mem[g+2].int;end;end{:656};
11,9:x:=x+mem[p+1].int;6:{652:}begin mem[29988]:=mem[p+1];
mem[29988].hh.rh:=mem[p].hh.rh;p:=29988;goto 21;end{:652};others:end;
p:=mem[p].hh.rh;end;end{:651};
if adjust_tail<>0 then mem[adjust_tail].hh.rh:=0;mem[r+3].int:=h;
mem[r+2].int:=d;{657:}if m=1 then w:=x+w;mem[r+1].int:=w;x:=w-x;
if x=0 then begin mem[r+5].hh.b0:=0;mem[r+5].hh.b1:=0;mem[r+6].gr:=0.0;
goto 10;
end else if x>0 then{658:}begin{659:}if total_stretch[3]<>0 then o:=3
else if total_stretch[2]<>0 then o:=2 else if total_stretch[1]<>0 then o
:=1 else o:=0{:659};mem[r+5].hh.b1:=o;mem[r+5].hh.b0:=1;
if total_stretch[o]<>0 then mem[r+6].gr:=x/total_stretch[o]else begin
mem[r+5].hh.b0:=0;mem[r+6].gr:=0.0;end;
if o=0 then if mem[r+5].hh.rh<>0 then{660:}begin last_badness:=badness(x
,total_stretch[0]);if last_badness>eqtb[5289].int then begin print_ln;
if last_badness>100 then print_nl(843)else print_nl(844);print(845);
print_int(last_badness);goto 50;end;end{:660};goto 10;
end{:658}else{664:}begin{665:}if total_shrink[3]<>0 then o:=3 else if
total_shrink[2]<>0 then o:=2 else if total_shrink[1]<>0 then o:=1 else o
:=0{:665};mem[r+5].hh.b1:=o;mem[r+5].hh.b0:=2;
if total_shrink[o]<>0 then mem[r+6].gr:=(-x)/total_shrink[o]else begin
mem[r+5].hh.b0:=0;mem[r+6].gr:=0.0;end;
if(total_shrink[o]<-x)and(o=0)and(mem[r+5].hh.rh<>0)then begin
last_badness:=1000000;mem[r+6].gr:=1.0;
{666:}if(-x-total_shrink[0]>eqtb[5838].int)or(eqtb[5289].int<100)then
begin if(eqtb[5846].int>0)and(-x-total_shrink[0]>eqtb[5838].int)then
begin while mem[q].hh.rh<>0 do q:=mem[q].hh.rh;mem[q].hh.rh:=new_rule;
mem[mem[q].hh.rh+1].int:=eqtb[5846].int;end;print_ln;print_nl(851);
print_scaled(-x-total_shrink[0]);print(852);goto 50;end{:666};
end else if o=0 then if mem[r+5].hh.rh<>0 then{667:}begin last_badness:=
badness(-x,total_shrink[0]);
if last_badness>eqtb[5289].int then begin print_ln;print_nl(853);
print_int(last_badness);goto 50;end;end{:667};goto 10;end{:664}{:657};
50:{663:}if output_active then print(846)else begin if pack_begin_line<>
0 then begin if pack_begin_line>0 then print(847)else print(848);
print_int(abs(pack_begin_line));print(849);end else print(850);
print_int(line);end;print_ln;font_in_short_display:=0;
short_display(mem[r+5].hh.rh);print_ln;begin_diagnostic;show_box(r);
end_diagnostic(true){:663};10:hpack:=r;end;
{:649}{668:}function vpackage(p:halfword;h:scaled;m:small_number;
l:scaled):halfword;label 50,10;var r:halfword;w,d,x:scaled;s:scaled;
g:halfword;o:glue_ord;begin last_badness:=0;r:=get_node(7);
mem[r].hh.b0:=1;mem[r].hh.b1:=0;mem[r+4].int:=0;mem[r+5].hh.rh:=p;w:=0;
{650:}d:=0;x:=0;total_stretch[0]:=0;total_shrink[0]:=0;
total_stretch[1]:=0;total_shrink[1]:=0;total_stretch[2]:=0;
total_shrink[2]:=0;total_stretch[3]:=0;total_shrink[3]:=0{:650};
while p<>0 do{669:}begin if(p>=hi_mem_min)then confusion(854)else case
mem[p].hh.b0 of 0,1,2,13:{670:}begin x:=x+d+mem[p+3].int;
d:=mem[p+2].int;if mem[p].hh.b0>=2 then s:=0 else s:=mem[p+4].int;
if mem[p+1].int+s>w then w:=mem[p+1].int+s;end{:670};8:{1359:}{:1359};
10:{671:}begin x:=x+d;d:=0;g:=mem[p+1].hh.lh;x:=x+mem[g+1].int;
o:=mem[g].hh.b0;total_stretch[o]:=total_stretch[o]+mem[g+2].int;
o:=mem[g].hh.b1;total_shrink[o]:=total_shrink[o]+mem[g+3].int;
if mem[p].hh.b1>=100 then begin g:=mem[p+1].hh.rh;
if mem[g+1].int>w then w:=mem[g+1].int;end;end{:671};
11:begin x:=x+d+mem[p+1].int;d:=0;end;others:end;p:=mem[p].hh.rh;
end{:669};mem[r+1].int:=w;if d>l then begin x:=x+d-l;mem[r+2].int:=l;
end else mem[r+2].int:=d;{672:}if m=1 then h:=x+h;mem[r+3].int:=h;
x:=h-x;if x=0 then begin mem[r+5].hh.b0:=0;mem[r+5].hh.b1:=0;
mem[r+6].gr:=0.0;goto 10;
end else if x>0 then{673:}begin{659:}if total_stretch[3]<>0 then o:=3
else if total_stretch[2]<>0 then o:=2 else if total_stretch[1]<>0 then o
:=1 else o:=0{:659};mem[r+5].hh.b1:=o;mem[r+5].hh.b0:=1;
if total_stretch[o]<>0 then mem[r+6].gr:=x/total_stretch[o]else begin
mem[r+5].hh.b0:=0;mem[r+6].gr:=0.0;end;
if o=0 then if mem[r+5].hh.rh<>0 then{674:}begin last_badness:=badness(x
,total_stretch[0]);if last_badness>eqtb[5290].int then begin print_ln;
if last_badness>100 then print_nl(843)else print_nl(844);print(855);
print_int(last_badness);goto 50;end;end{:674};goto 10;
end{:673}else{676:}begin{665:}if total_shrink[3]<>0 then o:=3 else if
total_shrink[2]<>0 then o:=2 else if total_shrink[1]<>0 then o:=1 else o
:=0{:665};mem[r+5].hh.b1:=o;mem[r+5].hh.b0:=2;
if total_shrink[o]<>0 then mem[r+6].gr:=(-x)/total_shrink[o]else begin
mem[r+5].hh.b0:=0;mem[r+6].gr:=0.0;end;
if(total_shrink[o]<-x)and(o=0)and(mem[r+5].hh.rh<>0)then begin
last_badness:=1000000;mem[r+6].gr:=1.0;
{677:}if(-x-total_shrink[0]>eqtb[5839].int)or(eqtb[5290].int<100)then
begin print_ln;print_nl(856);print_scaled(-x-total_shrink[0]);
print(857);goto 50;end{:677};
end else if o=0 then if mem[r+5].hh.rh<>0 then{678:}begin last_badness:=
badness(-x,total_shrink[0]);
if last_badness>eqtb[5290].int then begin print_ln;print_nl(858);
print_int(last_badness);goto 50;end;end{:678};goto 10;end{:676}{:672};
50:{675:}if output_active then print(846)else begin if pack_begin_line<>
0 then begin print(848);print_int(abs(pack_begin_line));print(849);
end else print(850);print_int(line);print_ln;end;begin_diagnostic;
show_box(r);end_diagnostic(true){:675};10:vpackage:=r;end;
{:668}{679:}procedure append_to_vlist(b:halfword);var d:scaled;
p:halfword;
begin if cur_list.aux_field.int>-65536000 then begin d:=mem[eqtb[2883].
hh.rh+1].int-cur_list.aux_field.int-mem[b+3].int;
if d<eqtb[5832].int then p:=new_param_glue(0)else begin p:=
new_skip_param(1);mem[temp_ptr+1].int:=d;end;
mem[cur_list.tail_field].hh.rh:=p;cur_list.tail_field:=p;end;
mem[cur_list.tail_field].hh.rh:=b;cur_list.tail_field:=b;
cur_list.aux_field.int:=mem[b+2].int;end;
{:679}{686:}function new_noad:halfword;var p:halfword;
begin p:=get_node(4);mem[p].hh.b0:=16;mem[p].hh.b1:=0;
mem[p+1].hh:=empty_field;mem[p+3].hh:=empty_field;
mem[p+2].hh:=empty_field;new_noad:=p;end;
{:686}{688:}function new_style(s:small_number):halfword;var p:halfword;
begin p:=get_node(3);mem[p].hh.b0:=14;mem[p].hh.b1:=s;mem[p+1].int:=0;
mem[p+2].int:=0;new_style:=p;end;
{:688}{689:}function new_choice:halfword;var p:halfword;
begin p:=get_node(3);mem[p].hh.b0:=15;mem[p].hh.b1:=0;mem[p+1].hh.lh:=0;
mem[p+1].hh.rh:=0;mem[p+2].hh.lh:=0;mem[p+2].hh.rh:=0;new_choice:=p;end;
{:689}{693:}procedure show_info;
begin show_node_list(mem[temp_ptr].hh.lh);end;
{:693}{704:}function fraction_rule(t:scaled):halfword;var p:halfword;
begin p:=new_rule;mem[p+3].int:=t;mem[p+2].int:=0;fraction_rule:=p;end;
{:704}{705:}function overbar(b:halfword;k,t:scaled):halfword;
var p,q:halfword;begin p:=new_kern(k);mem[p].hh.rh:=b;
q:=fraction_rule(t);mem[q].hh.rh:=p;p:=new_kern(t);mem[p].hh.rh:=q;
overbar:=vpackage(p,0,1,1073741823);end;
{:705}{706:}{709:}function char_box(f:internal_font_number;
c:quarterword):halfword;var q:four_quarters;hd:eight_bits;b,p:halfword;
begin q:=font_info[char_base[f]+c].qqqq;hd:=q.b1-0;b:=new_null_box;
mem[b+1].int:=font_info[width_base[f]+q.b0].int+font_info[italic_base[f]
+(q.b2-0)div 4].int;
mem[b+3].int:=font_info[height_base[f]+(hd)div 16].int;
mem[b+2].int:=font_info[depth_base[f]+(hd)mod 16].int;p:=get_avail;
mem[p].hh.b1:=c;mem[p].hh.b0:=f;mem[b+5].hh.rh:=p;char_box:=b;end;
{:709}{711:}procedure stack_into_box(b:halfword;f:internal_font_number;
c:quarterword);var p:halfword;begin p:=char_box(f,c);
mem[p].hh.rh:=mem[b+5].hh.rh;mem[b+5].hh.rh:=p;
mem[b+3].int:=mem[p+3].int;end;
{:711}{712:}function height_plus_depth(f:internal_font_number;
c:quarterword):scaled;var q:four_quarters;hd:eight_bits;
begin q:=font_info[char_base[f]+c].qqqq;hd:=q.b1-0;
height_plus_depth:=font_info[height_base[f]+(hd)div 16].int+font_info[
depth_base[f]+(hd)mod 16].int;end;
{:712}function var_delimiter(d:halfword;s:small_number;
v:scaled):halfword;label 40,22;var b:halfword;f,g:internal_font_number;
c,x,y:quarterword;m,n:integer;u:scaled;w:scaled;q:four_quarters;
hd:eight_bits;r:four_quarters;z:small_number;large_attempt:boolean;
begin f:=0;w:=0;large_attempt:=false;z:=mem[d].qqqq.b0;
x:=mem[d].qqqq.b1;
while true do begin{707:}if(z<>0)or(x<>0)then begin z:=z+s+16;
repeat z:=z-16;g:=eqtb[3935+z].hh.rh;if g<>0 then{708:}begin y:=x;
if(y-0>=font_bc[g])and(y-0<=font_ec[g])then begin 22:q:=font_info[
char_base[g]+y].qqqq;
if(q.b0>0)then begin if((q.b2-0)mod 4)=3 then begin f:=g;c:=y;goto 40;
end;hd:=q.b1-0;
u:=font_info[height_base[g]+(hd)div 16].int+font_info[depth_base[g]+(hd)
mod 16].int;if u>w then begin f:=g;c:=y;w:=u;if u>=v then goto 40;end;
if((q.b2-0)mod 4)=2 then begin y:=q.b3;goto 22;end;end;end;end{:708};
until z<16;end{:707};if large_attempt then goto 40;large_attempt:=true;
z:=mem[d].qqqq.b2;x:=mem[d].qqqq.b3;end;
40:if f<>0 then{710:}if((q.b2-0)mod 4)=3 then{713:}begin b:=new_null_box
;mem[b].hh.b0:=1;r:=font_info[exten_base[f]+q.b3].qqqq;{714:}c:=r.b3;
u:=height_plus_depth(f,c);w:=0;q:=font_info[char_base[f]+c].qqqq;
mem[b+1].int:=font_info[width_base[f]+q.b0].int+font_info[italic_base[f]
+(q.b2-0)div 4].int;c:=r.b2;if c<>0 then w:=w+height_plus_depth(f,c);
c:=r.b1;if c<>0 then w:=w+height_plus_depth(f,c);c:=r.b0;
if c<>0 then w:=w+height_plus_depth(f,c);n:=0;
if u>0 then while w<v do begin w:=w+u;n:=n+1;if r.b1<>0 then w:=w+u;
end{:714};c:=r.b2;if c<>0 then stack_into_box(b,f,c);c:=r.b3;
for m:=1 to n do stack_into_box(b,f,c);c:=r.b1;
if c<>0 then begin stack_into_box(b,f,c);c:=r.b3;
for m:=1 to n do stack_into_box(b,f,c);end;c:=r.b0;
if c<>0 then stack_into_box(b,f,c);mem[b+2].int:=w-mem[b+3].int;
end{:713}else b:=char_box(f,c){:710}else begin b:=new_null_box;
mem[b+1].int:=eqtb[5841].int;end;
mem[b+4].int:=half(mem[b+3].int-mem[b+2].int)-font_info[22+param_base[
eqtb[3937+s].hh.rh]].int;var_delimiter:=b;end;
{:706}{715:}function rebox(b:halfword;w:scaled):halfword;var p:halfword;
f:internal_font_number;v:scaled;
begin if(mem[b+1].int<>w)and(mem[b+5].hh.rh<>0)then begin if mem[b].hh.
b0=1 then b:=hpack(b,0,1);p:=mem[b+5].hh.rh;
if((p>=hi_mem_min))and(mem[p].hh.rh=0)then begin f:=mem[p].hh.b0;
v:=font_info[width_base[f]+font_info[char_base[f]+mem[p].hh.b1].qqqq.b0]
.int;if v<>mem[b+1].int then mem[p].hh.rh:=new_kern(mem[b+1].int-v);end;
free_node(b,7);b:=new_glue(12);mem[b].hh.rh:=p;
while mem[p].hh.rh<>0 do p:=mem[p].hh.rh;mem[p].hh.rh:=new_glue(12);
rebox:=hpack(b,w,0);end else begin mem[b+1].int:=w;rebox:=b;end;end;
{:715}{716:}function math_glue(g:halfword;m:scaled):halfword;
var p:halfword;n:integer;f:scaled;begin n:=x_over_n(m,65536);
f:=remainder;if f<0 then begin n:=n-1;f:=f+65536;end;p:=get_node(4);
mem[p+1].int:=mult_and_add(n,mem[g+1].int,xn_over_d(mem[g+1].int,f,65536
),1073741823);mem[p].hh.b0:=mem[g].hh.b0;
if mem[p].hh.b0=0 then mem[p+2].int:=mult_and_add(n,mem[g+2].int,
xn_over_d(mem[g+2].int,f,65536),1073741823)else mem[p+2].int:=mem[g+2].
int;mem[p].hh.b1:=mem[g].hh.b1;
if mem[p].hh.b1=0 then mem[p+3].int:=mult_and_add(n,mem[g+3].int,
xn_over_d(mem[g+3].int,f,65536),1073741823)else mem[p+3].int:=mem[g+3].
int;math_glue:=p;end;{:716}{717:}procedure math_kern(p:halfword;
m:scaled);var n:integer;f:scaled;
begin if mem[p].hh.b1=99 then begin n:=x_over_n(m,65536);f:=remainder;
if f<0 then begin n:=n-1;f:=f+65536;end;
mem[p+1].int:=mult_and_add(n,mem[p+1].int,xn_over_d(mem[p+1].int,f,65536
),1073741823);mem[p].hh.b1:=1;end;end;{:717}{718:}procedure flush_math;
begin flush_node_list(mem[cur_list.head_field].hh.rh);
flush_node_list(cur_list.aux_field.int);
mem[cur_list.head_field].hh.rh:=0;
cur_list.tail_field:=cur_list.head_field;cur_list.aux_field.int:=0;end;
{:718}{720:}procedure mlist_to_hlist;forward;
function clean_box(p:halfword;s:small_number):halfword;label 40;
var q:halfword;save_style:small_number;x:halfword;r:halfword;
begin case mem[p].hh.rh of 1:begin cur_mlist:=new_noad;
mem[cur_mlist+1]:=mem[p];end;2:begin q:=mem[p].hh.lh;goto 40;end;
3:cur_mlist:=mem[p].hh.lh;others:begin q:=new_null_box;goto 40;end end;
save_style:=cur_style;cur_style:=s;mlist_penalties:=false;
mlist_to_hlist;q:=mem[29997].hh.rh;cur_style:=save_style;
{703:}begin if cur_style<4 then cur_size:=0 else cur_size:=16*((
cur_style-2)div 2);
cur_mu:=x_over_n(font_info[6+param_base[eqtb[3937+cur_size].hh.rh]].int,
18);end{:703};
40:if(q>=hi_mem_min)or(q=0)then x:=hpack(q,0,1)else if(mem[q].hh.rh=0)
and(mem[q].hh.b0<=1)and(mem[q+4].int=0)then x:=q else x:=hpack(q,0,1);
{721:}q:=mem[x+5].hh.rh;if(q>=hi_mem_min)then begin r:=mem[q].hh.rh;
if r<>0 then if mem[r].hh.rh=0 then if not(r>=hi_mem_min)then if mem[r].
hh.b0=11 then begin free_node(r,2);mem[q].hh.rh:=0;end;end{:721};
clean_box:=x;end;{:720}{722:}procedure fetch(a:halfword);
begin cur_c:=mem[a].hh.b1;cur_f:=eqtb[3935+mem[a].hh.b0+cur_size].hh.rh;
if cur_f=0 then{723:}begin begin if interaction=3 then;print_nl(262);
print(338);end;print_size(cur_size);print_char(32);
print_int(mem[a].hh.b0);print(883);print(cur_c-0);print_char(41);
begin help_ptr:=4;help_line[3]:=884;help_line[2]:=885;help_line[1]:=886;
help_line[0]:=887;end;error;cur_i:=null_character;mem[a].hh.rh:=0;
end{:723}else begin if(cur_c-0>=font_bc[cur_f])and(cur_c-0<=font_ec[
cur_f])then cur_i:=font_info[char_base[cur_f]+cur_c].qqqq else cur_i:=
null_character;
if not((cur_i.b0>0))then begin char_warning(cur_f,cur_c-0);
mem[a].hh.rh:=0;end;end;end;
{:722}{726:}{734:}procedure make_over(q:halfword);
begin mem[q+1].hh.lh:=overbar(clean_box(q+1,2*(cur_style div 2)+1),3*
font_info[8+param_base[eqtb[3938+cur_size].hh.rh]].int,font_info[8+
param_base[eqtb[3938+cur_size].hh.rh]].int);mem[q+1].hh.rh:=2;end;
{:734}{735:}procedure make_under(q:halfword);var p,x,y:halfword;
delta:scaled;begin x:=clean_box(q+1,cur_style);
p:=new_kern(3*font_info[8+param_base[eqtb[3938+cur_size].hh.rh]].int);
mem[x].hh.rh:=p;
mem[p].hh.rh:=fraction_rule(font_info[8+param_base[eqtb[3938+cur_size].
hh.rh]].int);y:=vpackage(x,0,1,1073741823);
delta:=mem[y+3].int+mem[y+2].int+font_info[8+param_base[eqtb[3938+
cur_size].hh.rh]].int;mem[y+3].int:=mem[x+3].int;
mem[y+2].int:=delta-mem[y+3].int;mem[q+1].hh.lh:=y;mem[q+1].hh.rh:=2;
end;{:735}{736:}procedure make_vcenter(q:halfword);var v:halfword;
delta:scaled;begin v:=mem[q+1].hh.lh;
if mem[v].hh.b0<>1 then confusion(539);delta:=mem[v+3].int+mem[v+2].int;
mem[v+3].int:=font_info[22+param_base[eqtb[3937+cur_size].hh.rh]].int+
half(delta);mem[v+2].int:=delta-mem[v+3].int;end;
{:736}{737:}procedure make_radical(q:halfword);var x,y:halfword;
delta,clr:scaled;begin x:=clean_box(q+1,2*(cur_style div 2)+1);
if cur_style<2 then clr:=font_info[8+param_base[eqtb[3938+cur_size].hh.
rh]].int+(abs(font_info[5+param_base[eqtb[3937+cur_size].hh.rh]].int)div
4)else begin clr:=font_info[8+param_base[eqtb[3938+cur_size].hh.rh]].int
;clr:=clr+(abs(clr)div 4);end;
y:=var_delimiter(q+4,cur_size,mem[x+3].int+mem[x+2].int+clr+font_info[8+
param_base[eqtb[3938+cur_size].hh.rh]].int);
delta:=mem[y+2].int-(mem[x+3].int+mem[x+2].int+clr);
if delta>0 then clr:=clr+half(delta);mem[y+4].int:=-(mem[x+3].int+clr);
mem[y].hh.rh:=overbar(x,clr,mem[y+3].int);mem[q+1].hh.lh:=hpack(y,0,1);
mem[q+1].hh.rh:=2;end;
{:737}{738:}procedure make_math_accent(q:halfword);label 30,31;
var p,x,y:halfword;a:integer;c:quarterword;f:internal_font_number;
i:four_quarters;s:scaled;h:scaled;delta:scaled;w:scaled;
begin fetch(q+4);if(cur_i.b0>0)then begin i:=cur_i;c:=cur_c;f:=cur_f;
{741:}s:=0;if mem[q+1].hh.rh=1 then begin fetch(q+1);
if((cur_i.b2-0)mod 4)=1 then begin a:=lig_kern_base[cur_f]+cur_i.b3;
cur_i:=font_info[a].qqqq;
if cur_i.b0>128 then begin a:=lig_kern_base[cur_f]+256*cur_i.b2+cur_i.b3
+32768-256*(128);cur_i:=font_info[a].qqqq;end;
while true do begin if cur_i.b1-0=skew_char[cur_f]then begin if cur_i.b2
>=128 then if cur_i.b0<=128 then s:=font_info[kern_base[cur_f]+256*cur_i
.b2+cur_i.b3].int;goto 31;end;if cur_i.b0>=128 then goto 31;
a:=a+cur_i.b0+1;cur_i:=font_info[a].qqqq;end;end;end;31:{:741};
x:=clean_box(q+1,2*(cur_style div 2)+1);w:=mem[x+1].int;h:=mem[x+3].int;
{740:}while true do begin if((i.b2-0)mod 4)<>2 then goto 30;y:=i.b3;
i:=font_info[char_base[f]+y].qqqq;if not(i.b0>0)then goto 30;
if font_info[width_base[f]+i.b0].int>w then goto 30;c:=y;end;30:{:740};
if h<font_info[5+param_base[f]].int then delta:=h else delta:=font_info[
5+param_base[f]].int;
if(mem[q+2].hh.rh<>0)or(mem[q+3].hh.rh<>0)then if mem[q+1].hh.rh=1 then
{742:}begin flush_node_list(x);x:=new_noad;mem[x+1]:=mem[q+1];
mem[x+2]:=mem[q+2];mem[x+3]:=mem[q+3];mem[q+2].hh:=empty_field;
mem[q+3].hh:=empty_field;mem[q+1].hh.rh:=3;mem[q+1].hh.lh:=x;
x:=clean_box(q+1,cur_style);delta:=delta+mem[x+3].int-h;h:=mem[x+3].int;
end{:742};y:=char_box(f,c);mem[y+4].int:=s+half(w-mem[y+1].int);
mem[y+1].int:=0;p:=new_kern(-delta);mem[p].hh.rh:=x;mem[y].hh.rh:=p;
y:=vpackage(y,0,1,1073741823);mem[y+1].int:=mem[x+1].int;
if mem[y+3].int<h then{739:}begin p:=new_kern(h-mem[y+3].int);
mem[p].hh.rh:=mem[y+5].hh.rh;mem[y+5].hh.rh:=p;mem[y+3].int:=h;
end{:739};mem[q+1].hh.lh:=y;mem[q+1].hh.rh:=2;end;end;
{:738}{743:}procedure make_fraction(q:halfword);var p,v,x,y,z:halfword;
delta,delta1,delta2,shift_up,shift_down,clr:scaled;
begin if mem[q+1].int=1073741824 then mem[q+1].int:=font_info[8+
param_base[eqtb[3938+cur_size].hh.rh]].int;
{744:}x:=clean_box(q+2,cur_style+2-2*(cur_style div 6));
z:=clean_box(q+3,2*(cur_style div 2)+3-2*(cur_style div 6));
if mem[x+1].int<mem[z+1].int then x:=rebox(x,mem[z+1].int)else z:=rebox(
z,mem[x+1].int);
if cur_style<2 then begin shift_up:=font_info[8+param_base[eqtb[3937+
cur_size].hh.rh]].int;
shift_down:=font_info[11+param_base[eqtb[3937+cur_size].hh.rh]].int;
end else begin shift_down:=font_info[12+param_base[eqtb[3937+cur_size].
hh.rh]].int;
if mem[q+1].int<>0 then shift_up:=font_info[9+param_base[eqtb[3937+
cur_size].hh.rh]].int else shift_up:=font_info[10+param_base[eqtb[3937+
cur_size].hh.rh]].int;end{:744};
if mem[q+1].int=0 then{745:}begin if cur_style<2 then clr:=7*font_info[
8+param_base[eqtb[3938+cur_size].hh.rh]].int else clr:=3*font_info[8+
param_base[eqtb[3938+cur_size].hh.rh]].int;
delta:=half(clr-((shift_up-mem[x+2].int)-(mem[z+3].int-shift_down)));
if delta>0 then begin shift_up:=shift_up+delta;
shift_down:=shift_down+delta;end;
end{:745}else{746:}begin if cur_style<2 then clr:=3*mem[q+1].int else
clr:=mem[q+1].int;delta:=half(mem[q+1].int);
delta1:=clr-((shift_up-mem[x+2].int)-(font_info[22+param_base[eqtb[3937+
cur_size].hh.rh]].int+delta));
delta2:=clr-((font_info[22+param_base[eqtb[3937+cur_size].hh.rh]].int-
delta)-(mem[z+3].int-shift_down));
if delta1>0 then shift_up:=shift_up+delta1;
if delta2>0 then shift_down:=shift_down+delta2;end{:746};
{747:}v:=new_null_box;mem[v].hh.b0:=1;
mem[v+3].int:=shift_up+mem[x+3].int;
mem[v+2].int:=mem[z+2].int+shift_down;mem[v+1].int:=mem[x+1].int;
if mem[q+1].int=0 then begin p:=new_kern((shift_up-mem[x+2].int)-(mem[z
+3].int-shift_down));mem[p].hh.rh:=z;
end else begin y:=fraction_rule(mem[q+1].int);
p:=new_kern((font_info[22+param_base[eqtb[3937+cur_size].hh.rh]].int-
delta)-(mem[z+3].int-shift_down));mem[y].hh.rh:=p;mem[p].hh.rh:=z;
p:=new_kern((shift_up-mem[x+2].int)-(font_info[22+param_base[eqtb[3937+
cur_size].hh.rh]].int+delta));mem[p].hh.rh:=y;end;mem[x].hh.rh:=p;
mem[v+5].hh.rh:=x{:747};
{748:}if cur_style<2 then delta:=font_info[20+param_base[eqtb[3937+
cur_size].hh.rh]].int else delta:=font_info[21+param_base[eqtb[3937+
cur_size].hh.rh]].int;x:=var_delimiter(q+4,cur_size,delta);
mem[x].hh.rh:=v;z:=var_delimiter(q+5,cur_size,delta);mem[v].hh.rh:=z;
mem[q+1].int:=hpack(x,0,1){:748};end;
{:743}{749:}function make_op(q:halfword):scaled;var delta:scaled;
p,v,x,y,z:halfword;c:quarterword;i:four_quarters;
shift_up,shift_down:scaled;
begin if(mem[q].hh.b1=0)and(cur_style<2)then mem[q].hh.b1:=1;
if mem[q+1].hh.rh=1 then begin fetch(q+1);
if(cur_style<2)and(((cur_i.b2-0)mod 4)=2)then begin c:=cur_i.b3;
i:=font_info[char_base[cur_f]+c].qqqq;if(i.b0>0)then begin cur_c:=c;
cur_i:=i;mem[q+1].hh.b1:=c;end;end;
delta:=font_info[italic_base[cur_f]+(cur_i.b2-0)div 4].int;
x:=clean_box(q+1,cur_style);
if(mem[q+3].hh.rh<>0)and(mem[q].hh.b1<>1)then mem[x+1].int:=mem[x+1].int
-delta;
mem[x+4].int:=half(mem[x+3].int-mem[x+2].int)-font_info[22+param_base[
eqtb[3937+cur_size].hh.rh]].int;mem[q+1].hh.rh:=2;mem[q+1].hh.lh:=x;
end else delta:=0;
if mem[q].hh.b1=1 then{750:}begin x:=clean_box(q+2,2*(cur_style div 4)
+4+(cur_style mod 2));y:=clean_box(q+1,cur_style);
z:=clean_box(q+3,2*(cur_style div 4)+5);v:=new_null_box;mem[v].hh.b0:=1;
mem[v+1].int:=mem[y+1].int;
if mem[x+1].int>mem[v+1].int then mem[v+1].int:=mem[x+1].int;
if mem[z+1].int>mem[v+1].int then mem[v+1].int:=mem[z+1].int;
x:=rebox(x,mem[v+1].int);y:=rebox(y,mem[v+1].int);
z:=rebox(z,mem[v+1].int);mem[x+4].int:=half(delta);
mem[z+4].int:=-mem[x+4].int;mem[v+3].int:=mem[y+3].int;
mem[v+2].int:=mem[y+2].int;
{751:}if mem[q+2].hh.rh=0 then begin free_node(x,7);mem[v+5].hh.rh:=y;
end else begin shift_up:=font_info[11+param_base[eqtb[3938+cur_size].hh.
rh]].int-mem[x+2].int;
if shift_up<font_info[9+param_base[eqtb[3938+cur_size].hh.rh]].int then
shift_up:=font_info[9+param_base[eqtb[3938+cur_size].hh.rh]].int;
p:=new_kern(shift_up);mem[p].hh.rh:=y;mem[x].hh.rh:=p;
p:=new_kern(font_info[13+param_base[eqtb[3938+cur_size].hh.rh]].int);
mem[p].hh.rh:=x;mem[v+5].hh.rh:=p;
mem[v+3].int:=mem[v+3].int+font_info[13+param_base[eqtb[3938+cur_size].
hh.rh]].int+mem[x+3].int+mem[x+2].int+shift_up;end;
if mem[q+3].hh.rh=0 then free_node(z,7)else begin shift_down:=font_info[
12+param_base[eqtb[3938+cur_size].hh.rh]].int-mem[z+3].int;
if shift_down<font_info[10+param_base[eqtb[3938+cur_size].hh.rh]].int
then shift_down:=font_info[10+param_base[eqtb[3938+cur_size].hh.rh]].int
;p:=new_kern(shift_down);mem[y].hh.rh:=p;mem[p].hh.rh:=z;
p:=new_kern(font_info[13+param_base[eqtb[3938+cur_size].hh.rh]].int);
mem[z].hh.rh:=p;
mem[v+2].int:=mem[v+2].int+font_info[13+param_base[eqtb[3938+cur_size].
hh.rh]].int+mem[z+3].int+mem[z+2].int+shift_down;end{:751};
mem[q+1].int:=v;end{:750};make_op:=delta;end;
{:749}{752:}procedure make_ord(q:halfword);label 20,10;var a:integer;
p,r:halfword;
begin 20:if mem[q+3].hh.rh=0 then if mem[q+2].hh.rh=0 then if mem[q+1].
hh.rh=1 then begin p:=mem[q].hh.rh;
if p<>0 then if(mem[p].hh.b0>=16)and(mem[p].hh.b0<=22)then if mem[p+1].
hh.rh=1 then if mem[p+1].hh.b0=mem[q+1].hh.b0 then begin mem[q+1].hh.rh
:=4;fetch(q+1);
if((cur_i.b2-0)mod 4)=1 then begin a:=lig_kern_base[cur_f]+cur_i.b3;
cur_c:=mem[p+1].hh.b1;cur_i:=font_info[a].qqqq;
if cur_i.b0>128 then begin a:=lig_kern_base[cur_f]+256*cur_i.b2+cur_i.b3
+32768-256*(128);cur_i:=font_info[a].qqqq;end;
while true do begin{753:}if cur_i.b1=cur_c then if cur_i.b0<=128 then if
cur_i.b2>=128 then begin p:=new_kern(font_info[kern_base[cur_f]+256*
cur_i.b2+cur_i.b3].int);mem[p].hh.rh:=mem[q].hh.rh;mem[q].hh.rh:=p;
goto 10;
end else begin begin if interrupt<>0 then pause_for_instructions;end;
case cur_i.b2 of 1,5:mem[q+1].hh.b1:=cur_i.b3;
2,6:mem[p+1].hh.b1:=cur_i.b3;3,7,11:begin r:=new_noad;
mem[r+1].hh.b1:=cur_i.b3;mem[r+1].hh.b0:=mem[q+1].hh.b0;mem[q].hh.rh:=r;
mem[r].hh.rh:=p;
if cur_i.b2<11 then mem[r+1].hh.rh:=1 else mem[r+1].hh.rh:=4;end;
others:begin mem[q].hh.rh:=mem[p].hh.rh;mem[q+1].hh.b1:=cur_i.b3;
mem[q+3]:=mem[p+3];mem[q+2]:=mem[p+2];free_node(p,4);end end;
if cur_i.b2>3 then goto 10;mem[q+1].hh.rh:=1;goto 20;end{:753};
if cur_i.b0>=128 then goto 10;a:=a+cur_i.b0+1;cur_i:=font_info[a].qqqq;
end;end;end;end;10:end;{:752}{756:}procedure make_scripts(q:halfword;
delta:scaled);var p,x,y,z:halfword;shift_up,shift_down,clr:scaled;
t:small_number;begin p:=mem[q+1].int;
if(p>=hi_mem_min)then begin shift_up:=0;shift_down:=0;
end else begin z:=hpack(p,0,1);if cur_style<4 then t:=16 else t:=32;
shift_up:=mem[z+3].int-font_info[18+param_base[eqtb[3937+t].hh.rh]].int;
shift_down:=mem[z+2].int+font_info[19+param_base[eqtb[3937+t].hh.rh]].
int;free_node(z,7);end;
if mem[q+2].hh.rh=0 then{757:}begin x:=clean_box(q+3,2*(cur_style div 4)
+5);mem[x+1].int:=mem[x+1].int+eqtb[5842].int;
if shift_down<font_info[16+param_base[eqtb[3937+cur_size].hh.rh]].int
then shift_down:=font_info[16+param_base[eqtb[3937+cur_size].hh.rh]].int
;
clr:=mem[x+3].int-(abs(font_info[5+param_base[eqtb[3937+cur_size].hh.rh]
].int*4)div 5);if shift_down<clr then shift_down:=clr;
mem[x+4].int:=shift_down;
end{:757}else begin{758:}begin x:=clean_box(q+2,2*(cur_style div 4)+4+(
cur_style mod 2));mem[x+1].int:=mem[x+1].int+eqtb[5842].int;
if odd(cur_style)then clr:=font_info[15+param_base[eqtb[3937+cur_size].
hh.rh]].int else if cur_style<2 then clr:=font_info[13+param_base[eqtb[
3937+cur_size].hh.rh]].int else clr:=font_info[14+param_base[eqtb[3937+
cur_size].hh.rh]].int;if shift_up<clr then shift_up:=clr;
clr:=mem[x+2].int+(abs(font_info[5+param_base[eqtb[3937+cur_size].hh.rh]
].int)div 4);if shift_up<clr then shift_up:=clr;end{:758};
if mem[q+3].hh.rh=0 then mem[x+4].int:=-shift_up else{759:}begin y:=
clean_box(q+3,2*(cur_style div 4)+5);
mem[y+1].int:=mem[y+1].int+eqtb[5842].int;
if shift_down<font_info[17+param_base[eqtb[3937+cur_size].hh.rh]].int
then shift_down:=font_info[17+param_base[eqtb[3937+cur_size].hh.rh]].int
;
clr:=4*font_info[8+param_base[eqtb[3938+cur_size].hh.rh]].int-((shift_up
-mem[x+2].int)-(mem[y+3].int-shift_down));
if clr>0 then begin shift_down:=shift_down+clr;
clr:=(abs(font_info[5+param_base[eqtb[3937+cur_size].hh.rh]].int*4)div 5
)-(shift_up-mem[x+2].int);if clr>0 then begin shift_up:=shift_up+clr;
shift_down:=shift_down-clr;end;end;mem[x+4].int:=delta;
p:=new_kern((shift_up-mem[x+2].int)-(mem[y+3].int-shift_down));
mem[x].hh.rh:=p;mem[p].hh.rh:=y;x:=vpackage(x,0,1,1073741823);
mem[x+4].int:=shift_down;end{:759};end;
if mem[q+1].int=0 then mem[q+1].int:=x else begin p:=mem[q+1].int;
while mem[p].hh.rh<>0 do p:=mem[p].hh.rh;mem[p].hh.rh:=x;end;end;
{:756}{762:}function make_left_right(q:halfword;style:small_number;
max_d,max_h:scaled):small_number;var delta,delta1,delta2:scaled;
begin if style<4 then cur_size:=0 else cur_size:=16*((style-2)div 2);
delta2:=max_d+font_info[22+param_base[eqtb[3937+cur_size].hh.rh]].int;
delta1:=max_h+max_d-delta2;if delta2>delta1 then delta1:=delta2;
delta:=(delta1 div 500)*eqtb[5281].int;
delta2:=delta1+delta1-eqtb[5840].int;if delta<delta2 then delta:=delta2;
mem[q+1].int:=var_delimiter(q+1,cur_size,delta);
make_left_right:=mem[q].hh.b0-(10);end;{:762}procedure mlist_to_hlist;
label 21,82,80,81,83,30;var mlist:halfword;penalties:boolean;
style:small_number;save_style:small_number;q:halfword;r:halfword;
r_type:small_number;t:small_number;p,x,y,z:halfword;pen:integer;
s:small_number;max_h,max_d:scaled;delta:scaled;begin mlist:=cur_mlist;
penalties:=mlist_penalties;style:=cur_style;q:=mlist;r:=0;r_type:=17;
max_h:=0;max_d:=0;
{703:}begin if cur_style<4 then cur_size:=0 else cur_size:=16*((
cur_style-2)div 2);
cur_mu:=x_over_n(font_info[6+param_base[eqtb[3937+cur_size].hh.rh]].int,
18);end{:703};while q<>0 do{727:}begin{728:}21:delta:=0;
case mem[q].hh.b0 of 18:case r_type of 18,17,19,20,22,30:begin mem[q].hh
.b0:=16;goto 21;end;others:end;
19,21,22,31:begin{729:}if r_type=18 then mem[r].hh.b0:=16{:729};
if mem[q].hh.b0=31 then goto 80;end;{733:}30:goto 80;
25:begin make_fraction(q);goto 82;end;17:begin delta:=make_op(q);
if mem[q].hh.b1=1 then goto 82;end;16:make_ord(q);20,23:;
24:make_radical(q);27:make_over(q);26:make_under(q);
28:make_math_accent(q);29:make_vcenter(q);
{:733}{730:}14:begin cur_style:=mem[q].hh.b1;
{703:}begin if cur_style<4 then cur_size:=0 else cur_size:=16*((
cur_style-2)div 2);
cur_mu:=x_over_n(font_info[6+param_base[eqtb[3937+cur_size].hh.rh]].int,
18);end{:703};goto 81;end;
15:{731:}begin case cur_style div 2 of 0:begin p:=mem[q+1].hh.lh;
mem[q+1].hh.lh:=0;end;1:begin p:=mem[q+1].hh.rh;mem[q+1].hh.rh:=0;end;
2:begin p:=mem[q+2].hh.lh;mem[q+2].hh.lh:=0;end;
3:begin p:=mem[q+2].hh.rh;mem[q+2].hh.rh:=0;end;end;
flush_node_list(mem[q+1].hh.lh);flush_node_list(mem[q+1].hh.rh);
flush_node_list(mem[q+2].hh.lh);flush_node_list(mem[q+2].hh.rh);
mem[q].hh.b0:=14;mem[q].hh.b1:=cur_style;mem[q+1].int:=0;
mem[q+2].int:=0;if p<>0 then begin z:=mem[q].hh.rh;mem[q].hh.rh:=p;
while mem[p].hh.rh<>0 do p:=mem[p].hh.rh;mem[p].hh.rh:=z;end;goto 81;
end{:731};3,4,5,8,12,7:goto 81;
2:begin if mem[q+3].int>max_h then max_h:=mem[q+3].int;
if mem[q+2].int>max_d then max_d:=mem[q+2].int;goto 81;end;
10:begin{732:}if mem[q].hh.b1=99 then begin x:=mem[q+1].hh.lh;
y:=math_glue(x,cur_mu);delete_glue_ref(x);mem[q+1].hh.lh:=y;
mem[q].hh.b1:=0;
end else if(cur_size<>0)and(mem[q].hh.b1=98)then begin p:=mem[q].hh.rh;
if p<>0 then if(mem[p].hh.b0=10)or(mem[p].hh.b0=11)then begin mem[q].hh.
rh:=mem[p].hh.rh;mem[p].hh.rh:=0;flush_node_list(p);end;end{:732};
goto 81;end;11:begin math_kern(q,cur_mu);goto 81;end;
{:730}others:confusion(888)end;
{754:}case mem[q+1].hh.rh of 1,4:{755:}begin fetch(q+1);
if(cur_i.b0>0)then begin delta:=font_info[italic_base[cur_f]+(cur_i.b2-0
)div 4].int;p:=new_character(cur_f,cur_c-0);
if(mem[q+1].hh.rh=4)and(font_info[2+param_base[cur_f]].int<>0)then delta
:=0;
if(mem[q+3].hh.rh=0)and(delta<>0)then begin mem[p].hh.rh:=new_kern(delta
);delta:=0;end;end else p:=0;end{:755};0:p:=0;2:p:=mem[q+1].hh.lh;
3:begin cur_mlist:=mem[q+1].hh.lh;save_style:=cur_style;
mlist_penalties:=false;mlist_to_hlist;cur_style:=save_style;
{703:}begin if cur_style<4 then cur_size:=0 else cur_size:=16*((
cur_style-2)div 2);
cur_mu:=x_over_n(font_info[6+param_base[eqtb[3937+cur_size].hh.rh]].int,
18);end{:703};p:=hpack(mem[29997].hh.rh,0,1);end;
others:confusion(889)end;mem[q+1].int:=p;
if(mem[q+3].hh.rh=0)and(mem[q+2].hh.rh=0)then goto 82;
make_scripts(q,delta){:754}{:728};82:z:=hpack(mem[q+1].int,0,1);
if mem[z+3].int>max_h then max_h:=mem[z+3].int;
if mem[z+2].int>max_d then max_d:=mem[z+2].int;free_node(z,7);80:r:=q;
r_type:=mem[r].hh.b0;81:q:=mem[q].hh.rh;end{:727};
{729:}if r_type=18 then mem[r].hh.b0:=16{:729};{760:}p:=29997;
mem[p].hh.rh:=0;q:=mlist;r_type:=0;cur_style:=style;
{703:}begin if cur_style<4 then cur_size:=0 else cur_size:=16*((
cur_style-2)div 2);
cur_mu:=x_over_n(font_info[6+param_base[eqtb[3937+cur_size].hh.rh]].int,
18);end{:703};while q<>0 do begin{761:}t:=16;s:=4;pen:=10000;
case mem[q].hh.b0 of 17,20,21,22,23:t:=mem[q].hh.b0;18:begin t:=18;
pen:=eqtb[5272].int;end;19:begin t:=19;pen:=eqtb[5273].int;end;
16,29,27,26:;24:s:=5;28:s:=5;25:begin t:=23;s:=6;end;
30,31:t:=make_left_right(q,style,max_d,max_h);
14:{763:}begin cur_style:=mem[q].hh.b1;s:=3;
{703:}begin if cur_style<4 then cur_size:=0 else cur_size:=16*((
cur_style-2)div 2);
cur_mu:=x_over_n(font_info[6+param_base[eqtb[3937+cur_size].hh.rh]].int,
18);end{:703};goto 83;end{:763};
8,12,2,7,5,3,4,10,11:begin mem[p].hh.rh:=q;p:=q;q:=mem[q].hh.rh;
mem[p].hh.rh:=0;goto 30;end;others:confusion(890)end{:761};
{766:}if r_type>0 then begin case str_pool[r_type*8+t+magic_offset]of 48
:x:=0;49:if cur_style<4 then x:=15 else x:=0;50:x:=15;
51:if cur_style<4 then x:=16 else x:=0;
52:if cur_style<4 then x:=17 else x:=0;others:confusion(892)end;
if x<>0 then begin y:=math_glue(eqtb[2882+x].hh.rh,cur_mu);
z:=new_glue(y);mem[y].hh.rh:=0;mem[p].hh.rh:=z;p:=z;mem[z].hh.b1:=x+1;
end;end{:766};
{767:}if mem[q+1].int<>0 then begin mem[p].hh.rh:=mem[q+1].int;
repeat p:=mem[p].hh.rh;until mem[p].hh.rh=0;end;
if penalties then if mem[q].hh.rh<>0 then if pen<10000 then begin r_type
:=mem[mem[q].hh.rh].hh.b0;
if r_type<>12 then if r_type<>19 then begin z:=new_penalty(pen);
mem[p].hh.rh:=z;p:=z;end;end{:767};r_type:=t;83:r:=q;q:=mem[q].hh.rh;
free_node(r,s);30:end{:760};end;{:726}{772:}procedure push_alignment;
var p:halfword;begin p:=get_node(5);mem[p].hh.rh:=align_ptr;
mem[p].hh.lh:=cur_align;mem[p+1].hh.lh:=mem[29992].hh.rh;
mem[p+1].hh.rh:=cur_span;mem[p+2].int:=cur_loop;
mem[p+3].int:=align_state;mem[p+4].hh.lh:=cur_head;
mem[p+4].hh.rh:=cur_tail;align_ptr:=p;cur_head:=get_avail;end;
procedure pop_alignment;var p:halfword;
begin begin mem[cur_head].hh.rh:=avail;avail:=cur_head;
{dyn_used:=dyn_used-1;}end;p:=align_ptr;cur_tail:=mem[p+4].hh.rh;
cur_head:=mem[p+4].hh.lh;align_state:=mem[p+3].int;
cur_loop:=mem[p+2].int;cur_span:=mem[p+1].hh.rh;
mem[29992].hh.rh:=mem[p+1].hh.lh;cur_align:=mem[p].hh.lh;
align_ptr:=mem[p].hh.rh;free_node(p,5);end;
{:772}{774:}{782:}procedure get_preamble_token;label 20;
begin 20:get_token;while(cur_chr=256)and(cur_cmd=4)do begin get_token;
if cur_cmd>100 then begin expand;get_token;end;end;
if cur_cmd=9 then fatal_error(595);
if(cur_cmd=75)and(cur_chr=2893)then begin scan_optional_equals;
scan_glue(2);
if eqtb[5306].int>0 then geq_define(2893,117,cur_val)else eq_define(2893
,117,cur_val);goto 20;end;end;{:782}procedure align_peek;forward;
procedure normal_paragraph;forward;procedure init_align;
label 30,31,32,22;var save_cs_ptr:halfword;p:halfword;
begin save_cs_ptr:=cur_cs;push_alignment;align_state:=-1000000;
{776:}if(cur_list.mode_field=203)and((cur_list.tail_field<>cur_list.
head_field)or(cur_list.aux_field.int<>0))then begin begin if interaction
=3 then;print_nl(262);print(680);end;print_esc(520);print(893);
begin help_ptr:=3;help_line[2]:=894;help_line[1]:=895;help_line[0]:=896;
end;error;flush_math;end{:776};push_nest;
{775:}if cur_list.mode_field=203 then begin cur_list.mode_field:=-1;
cur_list.aux_field.int:=nest[nest_ptr-2].aux_field.int;
end else if cur_list.mode_field>0 then cur_list.mode_field:=-cur_list.
mode_field{:775};scan_spec(6,false);{777:}mem[29992].hh.rh:=0;
cur_align:=29992;cur_loop:=0;scanner_status:=4;
warning_index:=save_cs_ptr;align_state:=-1000000;
while true do begin{778:}mem[cur_align].hh.rh:=new_param_glue(11);
cur_align:=mem[cur_align].hh.rh{:778};if cur_cmd=5 then goto 30;
{779:}{783:}p:=29996;mem[p].hh.rh:=0;
while true do begin get_preamble_token;if cur_cmd=6 then goto 31;
if(cur_cmd<=5)and(cur_cmd>=4)and(align_state=-1000000)then if(p=29996)
and(cur_loop=0)and(cur_cmd=4)then cur_loop:=cur_align else begin begin
if interaction=3 then;print_nl(262);print(902);end;begin help_ptr:=3;
help_line[2]:=903;help_line[1]:=904;help_line[0]:=905;end;back_error;
goto 31;
end else if(cur_cmd<>10)or(p<>29996)then begin mem[p].hh.rh:=get_avail;
p:=mem[p].hh.rh;mem[p].hh.lh:=cur_tok;end;end;31:{:783};
mem[cur_align].hh.rh:=new_null_box;cur_align:=mem[cur_align].hh.rh;
mem[cur_align].hh.lh:=29991;mem[cur_align+1].int:=-1073741824;
mem[cur_align+3].int:=mem[29996].hh.rh;{784:}p:=29996;mem[p].hh.rh:=0;
while true do begin 22:get_preamble_token;
if(cur_cmd<=5)and(cur_cmd>=4)and(align_state=-1000000)then goto 32;
if cur_cmd=6 then begin begin if interaction=3 then;print_nl(262);
print(906);end;begin help_ptr:=3;help_line[2]:=903;help_line[1]:=904;
help_line[0]:=907;end;error;goto 22;end;mem[p].hh.rh:=get_avail;
p:=mem[p].hh.rh;mem[p].hh.lh:=cur_tok;end;32:mem[p].hh.rh:=get_avail;
p:=mem[p].hh.rh;mem[p].hh.lh:=6714{:784};
mem[cur_align+2].int:=mem[29996].hh.rh{:779};end;
30:scanner_status:=0{:777};new_save_level(6);
if eqtb[3420].hh.rh<>0 then begin_token_list(eqtb[3420].hh.rh,13);
align_peek;end;{:774}{786:}{787:}procedure init_span(p:halfword);
begin push_nest;
if cur_list.mode_field=-102 then cur_list.aux_field.hh.lh:=1000 else
begin cur_list.aux_field.int:=-65536000;normal_paragraph;end;
cur_span:=p;end;{:787}procedure init_row;begin push_nest;
cur_list.mode_field:=(-103)-cur_list.mode_field;
if cur_list.mode_field=-102 then cur_list.aux_field.hh.lh:=0 else
cur_list.aux_field.int:=0;
begin mem[cur_list.tail_field].hh.rh:=new_glue(mem[mem[29992].hh.rh+1].
hh.lh);cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b1:=12;
cur_align:=mem[mem[29992].hh.rh].hh.rh;cur_tail:=cur_head;
init_span(cur_align);end;{:786}{788:}procedure init_col;
begin mem[cur_align+5].hh.lh:=cur_cmd;
if cur_cmd=63 then align_state:=0 else begin back_input;
begin_token_list(mem[cur_align+3].int,1);end;end;
{:788}{791:}function fin_col:boolean;label 10;var p:halfword;
q,r:halfword;s:halfword;u:halfword;w:scaled;o:glue_ord;n:halfword;
begin if cur_align=0 then confusion(908);q:=mem[cur_align].hh.rh;
if q=0 then confusion(908);if align_state<500000 then fatal_error(595);
p:=mem[q].hh.rh;
{792:}if(p=0)and(mem[cur_align+5].hh.lh<257)then if cur_loop<>0 then
{793:}begin mem[q].hh.rh:=new_null_box;p:=mem[q].hh.rh;
mem[p].hh.lh:=29991;mem[p+1].int:=-1073741824;
cur_loop:=mem[cur_loop].hh.rh;{794:}q:=29996;r:=mem[cur_loop+3].int;
while r<>0 do begin mem[q].hh.rh:=get_avail;q:=mem[q].hh.rh;
mem[q].hh.lh:=mem[r].hh.lh;r:=mem[r].hh.rh;end;mem[q].hh.rh:=0;
mem[p+3].int:=mem[29996].hh.rh;q:=29996;r:=mem[cur_loop+2].int;
while r<>0 do begin mem[q].hh.rh:=get_avail;q:=mem[q].hh.rh;
mem[q].hh.lh:=mem[r].hh.lh;r:=mem[r].hh.rh;end;mem[q].hh.rh:=0;
mem[p+2].int:=mem[29996].hh.rh{:794};cur_loop:=mem[cur_loop].hh.rh;
mem[p].hh.rh:=new_glue(mem[cur_loop+1].hh.lh);
end{:793}else begin begin if interaction=3 then;print_nl(262);
print(909);end;print_esc(898);begin help_ptr:=3;help_line[2]:=910;
help_line[1]:=911;help_line[0]:=912;end;mem[cur_align+5].hh.lh:=257;
error;end{:792};if mem[cur_align+5].hh.lh<>256 then begin unsave;
new_save_level(6);
{796:}begin if cur_list.mode_field=-102 then begin adjust_tail:=cur_tail
;u:=hpack(mem[cur_list.head_field].hh.rh,0,1);w:=mem[u+1].int;
cur_tail:=adjust_tail;adjust_tail:=0;
end else begin u:=vpackage(mem[cur_list.head_field].hh.rh,0,1,0);
w:=mem[u+3].int;end;n:=0;
if cur_span<>cur_align then{798:}begin q:=cur_span;repeat n:=n+1;
q:=mem[mem[q].hh.rh].hh.rh;until q=cur_align;
if n>255 then confusion(913);q:=cur_span;
while mem[mem[q].hh.lh].hh.rh<n do q:=mem[q].hh.lh;
if mem[mem[q].hh.lh].hh.rh>n then begin s:=get_node(2);
mem[s].hh.lh:=mem[q].hh.lh;mem[s].hh.rh:=n;mem[q].hh.lh:=s;
mem[s+1].int:=w;
end else if mem[mem[q].hh.lh+1].int<w then mem[mem[q].hh.lh+1].int:=w;
end{:798}else if w>mem[cur_align+1].int then mem[cur_align+1].int:=w;
mem[u].hh.b0:=13;mem[u].hh.b1:=n;
{659:}if total_stretch[3]<>0 then o:=3 else if total_stretch[2]<>0 then
o:=2 else if total_stretch[1]<>0 then o:=1 else o:=0{:659};
mem[u+5].hh.b1:=o;mem[u+6].int:=total_stretch[o];
{665:}if total_shrink[3]<>0 then o:=3 else if total_shrink[2]<>0 then o
:=2 else if total_shrink[1]<>0 then o:=1 else o:=0{:665};
mem[u+5].hh.b0:=o;mem[u+4].int:=total_shrink[o];pop_nest;
mem[cur_list.tail_field].hh.rh:=u;cur_list.tail_field:=u;end{:796};
{795:}begin mem[cur_list.tail_field].hh.rh:=new_glue(mem[mem[cur_align].
hh.rh+1].hh.lh);cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b1:=12{:795};
if mem[cur_align+5].hh.lh>=257 then begin fin_col:=true;goto 10;end;
init_span(p);end;align_state:=1000000;{406:}repeat get_x_token;
until cur_cmd<>10{:406};cur_align:=p;init_col;fin_col:=false;10:end;
{:791}{799:}procedure fin_row;var p:halfword;
begin if cur_list.mode_field=-102 then begin p:=hpack(mem[cur_list.
head_field].hh.rh,0,1);pop_nest;append_to_vlist(p);
if cur_head<>cur_tail then begin mem[cur_list.tail_field].hh.rh:=mem[
cur_head].hh.rh;cur_list.tail_field:=cur_tail;end;
end else begin p:=vpackage(mem[cur_list.head_field].hh.rh,0,1,1073741823
);pop_nest;mem[cur_list.tail_field].hh.rh:=p;cur_list.tail_field:=p;
cur_list.aux_field.hh.lh:=1000;end;mem[p].hh.b0:=13;mem[p+6].int:=0;
if eqtb[3420].hh.rh<>0 then begin_token_list(eqtb[3420].hh.rh,13);
align_peek;end;{:799}{800:}procedure do_assignments;forward;
procedure resume_after_display;forward;procedure build_page;forward;
procedure fin_align;var p,q,r,s,u,v:halfword;t,w:scaled;o:scaled;
n:halfword;rule_save:scaled;aux_save:memory_word;
begin if cur_group<>6 then confusion(914);unsave;
if cur_group<>6 then confusion(915);unsave;
if nest[nest_ptr-1].mode_field=203 then o:=eqtb[5845].int else o:=0;
{801:}q:=mem[mem[29992].hh.rh].hh.rh;repeat flush_list(mem[q+3].int);
flush_list(mem[q+2].int);p:=mem[mem[q].hh.rh].hh.rh;
if mem[q+1].int=-1073741824 then{802:}begin mem[q+1].int:=0;
r:=mem[q].hh.rh;s:=mem[r+1].hh.lh;
if s<>0 then begin mem[0].hh.rh:=mem[0].hh.rh+1;delete_glue_ref(s);
mem[r+1].hh.lh:=0;end;end{:802};
if mem[q].hh.lh<>29991 then{803:}begin t:=mem[q+1].int+mem[mem[mem[q].hh
.rh+1].hh.lh+1].int;r:=mem[q].hh.lh;s:=29991;mem[s].hh.lh:=p;n:=1;
repeat mem[r+1].int:=mem[r+1].int-t;u:=mem[r].hh.lh;
while mem[r].hh.rh>n do begin s:=mem[s].hh.lh;
n:=mem[mem[s].hh.lh].hh.rh+1;end;
if mem[r].hh.rh<n then begin mem[r].hh.lh:=mem[s].hh.lh;mem[s].hh.lh:=r;
mem[r].hh.rh:=mem[r].hh.rh-1;s:=r;
end else begin if mem[r+1].int>mem[mem[s].hh.lh+1].int then mem[mem[s].
hh.lh+1].int:=mem[r+1].int;free_node(r,2);end;r:=u;until r=29991;
end{:803};mem[q].hh.b0:=13;mem[q].hh.b1:=0;mem[q+3].int:=0;
mem[q+2].int:=0;mem[q+5].hh.b1:=0;mem[q+5].hh.b0:=0;mem[q+6].int:=0;
mem[q+4].int:=0;q:=p;until q=0{:801};{804:}save_ptr:=save_ptr-2;
pack_begin_line:=-cur_list.ml_field;
if cur_list.mode_field=-1 then begin rule_save:=eqtb[5846].int;
eqtb[5846].int:=0;
p:=hpack(mem[29992].hh.rh,save_stack[save_ptr+1].int,save_stack[save_ptr
+0].int);eqtb[5846].int:=rule_save;
end else begin q:=mem[mem[29992].hh.rh].hh.rh;
repeat mem[q+3].int:=mem[q+1].int;mem[q+1].int:=0;
q:=mem[mem[q].hh.rh].hh.rh;until q=0;
p:=vpackage(mem[29992].hh.rh,save_stack[save_ptr+1].int,save_stack[
save_ptr+0].int,1073741823);q:=mem[mem[29992].hh.rh].hh.rh;
repeat mem[q+1].int:=mem[q+3].int;mem[q+3].int:=0;
q:=mem[mem[q].hh.rh].hh.rh;until q=0;end;pack_begin_line:=0{:804};
{805:}q:=mem[cur_list.head_field].hh.rh;s:=cur_list.head_field;
while q<>0 do begin if not(q>=hi_mem_min)then if mem[q].hh.b0=13 then
{807:}begin if cur_list.mode_field=-1 then begin mem[q].hh.b0:=0;
mem[q+1].int:=mem[p+1].int;end else begin mem[q].hh.b0:=1;
mem[q+3].int:=mem[p+3].int;end;mem[q+5].hh.b1:=mem[p+5].hh.b1;
mem[q+5].hh.b0:=mem[p+5].hh.b0;mem[q+6].gr:=mem[p+6].gr;mem[q+4].int:=o;
r:=mem[mem[q+5].hh.rh].hh.rh;s:=mem[mem[p+5].hh.rh].hh.rh;
repeat{808:}n:=mem[r].hh.b1;t:=mem[s+1].int;w:=t;u:=29996;
while n>0 do begin n:=n-1;{809:}s:=mem[s].hh.rh;v:=mem[s+1].hh.lh;
mem[u].hh.rh:=new_glue(v);u:=mem[u].hh.rh;mem[u].hh.b1:=12;
t:=t+mem[v+1].int;
if mem[p+5].hh.b0=1 then begin if mem[v].hh.b0=mem[p+5].hh.b1 then t:=t+
round(mem[p+6].gr*mem[v+2].int);
end else if mem[p+5].hh.b0=2 then begin if mem[v].hh.b1=mem[p+5].hh.b1
then t:=t-round(mem[p+6].gr*mem[v+3].int);end;s:=mem[s].hh.rh;
mem[u].hh.rh:=new_null_box;u:=mem[u].hh.rh;t:=t+mem[s+1].int;
if cur_list.mode_field=-1 then mem[u+1].int:=mem[s+1].int else begin mem
[u].hh.b0:=1;mem[u+3].int:=mem[s+1].int;end{:809};end;
if cur_list.mode_field=-1 then{810:}begin mem[r+3].int:=mem[q+3].int;
mem[r+2].int:=mem[q+2].int;
if t=mem[r+1].int then begin mem[r+5].hh.b0:=0;mem[r+5].hh.b1:=0;
mem[r+6].gr:=0.0;
end else if t>mem[r+1].int then begin mem[r+5].hh.b0:=1;
if mem[r+6].int=0 then mem[r+6].gr:=0.0 else mem[r+6].gr:=(t-mem[r+1].
int)/mem[r+6].int;end else begin mem[r+5].hh.b1:=mem[r+5].hh.b0;
mem[r+5].hh.b0:=2;
if mem[r+4].int=0 then mem[r+6].gr:=0.0 else if(mem[r+5].hh.b1=0)and(mem
[r+1].int-t>mem[r+4].int)then mem[r+6].gr:=1.0 else mem[r+6].gr:=(mem[r
+1].int-t)/mem[r+4].int;end;mem[r+1].int:=w;mem[r].hh.b0:=0;
end{:810}else{811:}begin mem[r+1].int:=mem[q+1].int;
if t=mem[r+3].int then begin mem[r+5].hh.b0:=0;mem[r+5].hh.b1:=0;
mem[r+6].gr:=0.0;
end else if t>mem[r+3].int then begin mem[r+5].hh.b0:=1;
if mem[r+6].int=0 then mem[r+6].gr:=0.0 else mem[r+6].gr:=(t-mem[r+3].
int)/mem[r+6].int;end else begin mem[r+5].hh.b1:=mem[r+5].hh.b0;
mem[r+5].hh.b0:=2;
if mem[r+4].int=0 then mem[r+6].gr:=0.0 else if(mem[r+5].hh.b1=0)and(mem
[r+3].int-t>mem[r+4].int)then mem[r+6].gr:=1.0 else mem[r+6].gr:=(mem[r
+3].int-t)/mem[r+4].int;end;mem[r+3].int:=w;mem[r].hh.b0:=1;end{:811};
mem[r+4].int:=0;if u<>29996 then begin mem[u].hh.rh:=mem[r].hh.rh;
mem[r].hh.rh:=mem[29996].hh.rh;r:=u;end{:808};
r:=mem[mem[r].hh.rh].hh.rh;s:=mem[mem[s].hh.rh].hh.rh;until r=0;
end{:807}else if mem[q].hh.b0=2 then{806:}begin if(mem[q+1].int=
-1073741824)then mem[q+1].int:=mem[p+1].int;
if(mem[q+3].int=-1073741824)then mem[q+3].int:=mem[p+3].int;
if(mem[q+2].int=-1073741824)then mem[q+2].int:=mem[p+2].int;
if o<>0 then begin r:=mem[q].hh.rh;mem[q].hh.rh:=0;q:=hpack(q,0,1);
mem[q+4].int:=o;mem[q].hh.rh:=r;mem[s].hh.rh:=q;end;end{:806};s:=q;
q:=mem[q].hh.rh;end{:805};flush_node_list(p);pop_alignment;
{812:}aux_save:=cur_list.aux_field;p:=mem[cur_list.head_field].hh.rh;
q:=cur_list.tail_field;pop_nest;
if cur_list.mode_field=203 then{1206:}begin do_assignments;
if cur_cmd<>3 then{1207:}begin begin if interaction=3 then;
print_nl(262);print(1169);end;begin help_ptr:=2;help_line[1]:=894;
help_line[0]:=895;end;back_error;end{:1207}else{1197:}begin get_x_token;
if cur_cmd<>3 then begin begin if interaction=3 then;print_nl(262);
print(1165);end;begin help_ptr:=2;help_line[1]:=1166;help_line[0]:=1167;
end;back_error;end;end{:1197};pop_nest;
begin mem[cur_list.tail_field].hh.rh:=new_penalty(eqtb[5274].int);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
begin mem[cur_list.tail_field].hh.rh:=new_param_glue(3);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.rh:=p;if p<>0 then cur_list.tail_field:=q;
begin mem[cur_list.tail_field].hh.rh:=new_penalty(eqtb[5275].int);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
begin mem[cur_list.tail_field].hh.rh:=new_param_glue(4);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
cur_list.aux_field.int:=aux_save.int;resume_after_display;
end{:1206}else begin cur_list.aux_field:=aux_save;
mem[cur_list.tail_field].hh.rh:=p;if p<>0 then cur_list.tail_field:=q;
if cur_list.mode_field=1 then build_page;end{:812};end;
{785:}procedure align_peek;label 20;begin 20:align_state:=1000000;
{406:}repeat get_x_token;until cur_cmd<>10{:406};
if cur_cmd=34 then begin scan_left_brace;new_save_level(7);
if cur_list.mode_field=-1 then normal_paragraph;
end else if cur_cmd=2 then fin_align else if(cur_cmd=5)and(cur_chr=258)
then goto 20 else begin init_row;init_col;end;end;
{:785}{:800}{815:}{826:}function finite_shrink(p:halfword):halfword;
var q:halfword;
begin if no_shrink_error_yet then begin no_shrink_error_yet:=false;
begin if interaction=3 then;print_nl(262);print(916);end;
begin help_ptr:=5;help_line[4]:=917;help_line[3]:=918;help_line[2]:=919;
help_line[1]:=920;help_line[0]:=921;end;error;end;q:=new_spec(p);
mem[q].hh.b1:=0;delete_glue_ref(p);finite_shrink:=q;end;
{:826}{829:}procedure try_break(pi:integer;break_type:small_number);
label 10,30,31,22,60;var r:halfword;prev_r:halfword;old_l:halfword;
no_break_yet:boolean;{830:}prev_prev_r:halfword;s:halfword;q:halfword;
v:halfword;t:integer;f:internal_font_number;l:halfword;
node_r_stays_active:boolean;line_width:scaled;fit_class:0..3;b:halfword;
d:integer;artificial_demerits:boolean;save_link:halfword;
shortfall:scaled;
{:830}begin{831:}if abs(pi)>=10000 then if pi>0 then goto 10 else pi:=
-10000{:831};no_break_yet:=true;prev_r:=29993;old_l:=0;
cur_active_width[1]:=active_width[1];
cur_active_width[2]:=active_width[2];
cur_active_width[3]:=active_width[3];
cur_active_width[4]:=active_width[4];
cur_active_width[5]:=active_width[5];
cur_active_width[6]:=active_width[6];
while true do begin 22:r:=mem[prev_r].hh.rh;
{832:}if mem[r].hh.b0=2 then begin cur_active_width[1]:=cur_active_width
[1]+mem[r+1].int;cur_active_width[2]:=cur_active_width[2]+mem[r+2].int;
cur_active_width[3]:=cur_active_width[3]+mem[r+3].int;
cur_active_width[4]:=cur_active_width[4]+mem[r+4].int;
cur_active_width[5]:=cur_active_width[5]+mem[r+5].int;
cur_active_width[6]:=cur_active_width[6]+mem[r+6].int;
prev_prev_r:=prev_r;prev_r:=r;goto 22;end{:832};
{835:}begin l:=mem[r+1].hh.lh;
if l>old_l then begin if(minimum_demerits<1073741823)and((old_l<>
easy_line)or(r=29993))then{836:}begin if no_break_yet then{837:}begin
no_break_yet:=false;break_width[1]:=background[1];
break_width[2]:=background[2];break_width[3]:=background[3];
break_width[4]:=background[4];break_width[5]:=background[5];
break_width[6]:=background[6];s:=cur_p;
if break_type>0 then if cur_p<>0 then{840:}begin t:=mem[cur_p].hh.b1;
v:=cur_p;s:=mem[cur_p+1].hh.rh;while t>0 do begin t:=t-1;
v:=mem[v].hh.rh;{841:}if(v>=hi_mem_min)then begin f:=mem[v].hh.b0;
break_width[1]:=break_width[1]-font_info[width_base[f]+font_info[
char_base[f]+mem[v].hh.b1].qqqq.b0].int;
end else case mem[v].hh.b0 of 6:begin f:=mem[v+1].hh.b0;
break_width[1]:=break_width[1]-font_info[width_base[f]+font_info[
char_base[f]+mem[v+1].hh.b1].qqqq.b0].int;end;
0,1,2,11:break_width[1]:=break_width[1]-mem[v+1].int;
others:confusion(922)end{:841};end;
while s<>0 do begin{842:}if(s>=hi_mem_min)then begin f:=mem[s].hh.b0;
break_width[1]:=break_width[1]+font_info[width_base[f]+font_info[
char_base[f]+mem[s].hh.b1].qqqq.b0].int;
end else case mem[s].hh.b0 of 6:begin f:=mem[s+1].hh.b0;
break_width[1]:=break_width[1]+font_info[width_base[f]+font_info[
char_base[f]+mem[s+1].hh.b1].qqqq.b0].int;end;
0,1,2,11:break_width[1]:=break_width[1]+mem[s+1].int;
others:confusion(923)end{:842};s:=mem[s].hh.rh;end;
break_width[1]:=break_width[1]+disc_width;
if mem[cur_p+1].hh.rh=0 then s:=mem[v].hh.rh;end{:840};
while s<>0 do begin if(s>=hi_mem_min)then goto 30;
case mem[s].hh.b0 of 10:{838:}begin v:=mem[s+1].hh.lh;
break_width[1]:=break_width[1]-mem[v+1].int;
break_width[2+mem[v].hh.b0]:=break_width[2+mem[v].hh.b0]-mem[v+2].int;
break_width[6]:=break_width[6]-mem[v+3].int;end{:838};12:;
9:break_width[1]:=break_width[1]-mem[s+1].int;
11:if mem[s].hh.b1<>1 then goto 30 else break_width[1]:=break_width[1]-
mem[s+1].int;others:goto 30 end;s:=mem[s].hh.rh;end;30:end{:837};
{843:}if mem[prev_r].hh.b0=2 then begin mem[prev_r+1].int:=mem[prev_r+1]
.int-cur_active_width[1]+break_width[1];
mem[prev_r+2].int:=mem[prev_r+2].int-cur_active_width[2]+break_width[2];
mem[prev_r+3].int:=mem[prev_r+3].int-cur_active_width[3]+break_width[3];
mem[prev_r+4].int:=mem[prev_r+4].int-cur_active_width[4]+break_width[4];
mem[prev_r+5].int:=mem[prev_r+5].int-cur_active_width[5]+break_width[5];
mem[prev_r+6].int:=mem[prev_r+6].int-cur_active_width[6]+break_width[6];
end else if prev_r=29993 then begin active_width[1]:=break_width[1];
active_width[2]:=break_width[2];active_width[3]:=break_width[3];
active_width[4]:=break_width[4];active_width[5]:=break_width[5];
active_width[6]:=break_width[6];end else begin q:=get_node(7);
mem[q].hh.rh:=r;mem[q].hh.b0:=2;mem[q].hh.b1:=0;
mem[q+1].int:=break_width[1]-cur_active_width[1];
mem[q+2].int:=break_width[2]-cur_active_width[2];
mem[q+3].int:=break_width[3]-cur_active_width[3];
mem[q+4].int:=break_width[4]-cur_active_width[4];
mem[q+5].int:=break_width[5]-cur_active_width[5];
mem[q+6].int:=break_width[6]-cur_active_width[6];mem[prev_r].hh.rh:=q;
prev_prev_r:=prev_r;prev_r:=q;end{:843};
if abs(eqtb[5279].int)>=1073741823-minimum_demerits then
minimum_demerits:=1073741822 else minimum_demerits:=minimum_demerits+abs
(eqtb[5279].int);
for fit_class:=0 to 3 do begin if minimal_demerits[fit_class]<=
minimum_demerits then{845:}begin q:=get_node(2);mem[q].hh.rh:=passive;
passive:=q;mem[q+1].hh.rh:=cur_p;{pass_number:=pass_number+1;
mem[q].hh.lh:=pass_number;}mem[q+1].hh.lh:=best_place[fit_class];
q:=get_node(3);mem[q+1].hh.rh:=passive;
mem[q+1].hh.lh:=best_pl_line[fit_class]+1;mem[q].hh.b1:=fit_class;
mem[q].hh.b0:=break_type;mem[q+2].int:=minimal_demerits[fit_class];
mem[q].hh.rh:=r;mem[prev_r].hh.rh:=q;prev_r:=q;
{if eqtb[5295].int>0 then[846:]begin print_nl(924);
print_int(mem[passive].hh.lh);print(925);print_int(mem[q+1].hh.lh-1);
print_char(46);print_int(fit_class);if break_type=1 then print_char(45);
print(926);print_int(mem[q+2].int);print(927);
if mem[passive+1].hh.lh=0 then print_char(48)else print_int(mem[mem[
passive+1].hh.lh].hh.lh);end[:846];}end{:845};
minimal_demerits[fit_class]:=1073741823;end;
minimum_demerits:=1073741823;
{844:}if r<>29993 then begin q:=get_node(7);mem[q].hh.rh:=r;
mem[q].hh.b0:=2;mem[q].hh.b1:=0;
mem[q+1].int:=cur_active_width[1]-break_width[1];
mem[q+2].int:=cur_active_width[2]-break_width[2];
mem[q+3].int:=cur_active_width[3]-break_width[3];
mem[q+4].int:=cur_active_width[4]-break_width[4];
mem[q+5].int:=cur_active_width[5]-break_width[5];
mem[q+6].int:=cur_active_width[6]-break_width[6];mem[prev_r].hh.rh:=q;
prev_prev_r:=prev_r;prev_r:=q;end{:844};end{:836};
if r=29993 then goto 10;
{850:}if l>easy_line then begin line_width:=second_width;old_l:=65534;
end else begin old_l:=l;
if l>last_special_line then line_width:=second_width else if eqtb[3412].
hh.rh=0 then line_width:=first_width else line_width:=mem[eqtb[3412].hh.
rh+2*l].int;end{:850};end;end{:835};
{851:}begin artificial_demerits:=false;
shortfall:=line_width-cur_active_width[1];
if shortfall>0 then{852:}if(cur_active_width[3]<>0)or(cur_active_width[4
]<>0)or(cur_active_width[5]<>0)then begin b:=0;fit_class:=2;
end else begin if shortfall>7230584 then if cur_active_width[2]<1663497
then begin b:=10000;fit_class:=0;goto 31;end;
b:=badness(shortfall,cur_active_width[2]);
if b>12 then if b>99 then fit_class:=0 else fit_class:=1 else fit_class
:=2;31:end{:852}else{853:}begin if-shortfall>cur_active_width[6]then b:=
10001 else b:=badness(-shortfall,cur_active_width[6]);
if b>12 then fit_class:=3 else fit_class:=2;end{:853};
if(b>10000)or(pi=-10000)then{854:}begin if final_pass and(
minimum_demerits=1073741823)and(mem[r].hh.rh=29993)and(prev_r=29993)then
artificial_demerits:=true else if b>threshold then goto 60;
node_r_stays_active:=false;end{:854}else begin prev_r:=r;
if b>threshold then goto 22;node_r_stays_active:=true;end;
{855:}if artificial_demerits then d:=0 else{859:}begin d:=eqtb[5265].int
+b;if abs(d)>=10000 then d:=100000000 else d:=d*d;
if pi<>0 then if pi>0 then d:=d+pi*pi else if pi>-10000 then d:=d-pi*pi;
if(break_type=1)and(mem[r].hh.b0=1)then if cur_p<>0 then d:=d+eqtb[5277]
.int else d:=d+eqtb[5278].int;
if abs(fit_class-mem[r].hh.b1)>1 then d:=d+eqtb[5279].int;end{:859};
{if eqtb[5295].int>0 then[856:]begin if printed_node<>cur_p then[857:]
begin print_nl(338);
if cur_p=0 then short_display(mem[printed_node].hh.rh)else begin
save_link:=mem[cur_p].hh.rh;mem[cur_p].hh.rh:=0;print_nl(338);
short_display(mem[printed_node].hh.rh);mem[cur_p].hh.rh:=save_link;end;
printed_node:=cur_p;end[:857];print_nl(64);
if cur_p=0 then print_esc(597)else if mem[cur_p].hh.b0<>10 then begin if
mem[cur_p].hh.b0=12 then print_esc(531)else if mem[cur_p].hh.b0=7 then
print_esc(349)else if mem[cur_p].hh.b0=11 then print_esc(340)else
print_esc(343);end;print(928);
if mem[r+1].hh.rh=0 then print_char(48)else print_int(mem[mem[r+1].hh.rh
].hh.lh);print(929);if b>10000 then print_char(42)else print_int(b);
print(930);print_int(pi);print(931);
if artificial_demerits then print_char(42)else print_int(d);end[:856];}
d:=d+mem[r+2].int;
if d<=minimal_demerits[fit_class]then begin minimal_demerits[fit_class]
:=d;best_place[fit_class]:=mem[r+1].hh.rh;best_pl_line[fit_class]:=l;
if d<minimum_demerits then minimum_demerits:=d;end{:855};
if node_r_stays_active then goto 22;
60:{860:}mem[prev_r].hh.rh:=mem[r].hh.rh;free_node(r,3);
if prev_r=29993 then{861:}begin r:=mem[29993].hh.rh;
if mem[r].hh.b0=2 then begin active_width[1]:=active_width[1]+mem[r+1].
int;active_width[2]:=active_width[2]+mem[r+2].int;
active_width[3]:=active_width[3]+mem[r+3].int;
active_width[4]:=active_width[4]+mem[r+4].int;
active_width[5]:=active_width[5]+mem[r+5].int;
active_width[6]:=active_width[6]+mem[r+6].int;
cur_active_width[1]:=active_width[1];
cur_active_width[2]:=active_width[2];
cur_active_width[3]:=active_width[3];
cur_active_width[4]:=active_width[4];
cur_active_width[5]:=active_width[5];
cur_active_width[6]:=active_width[6];mem[29993].hh.rh:=mem[r].hh.rh;
free_node(r,7);end;
end{:861}else if mem[prev_r].hh.b0=2 then begin r:=mem[prev_r].hh.rh;
if r=29993 then begin cur_active_width[1]:=cur_active_width[1]-mem[
prev_r+1].int;
cur_active_width[2]:=cur_active_width[2]-mem[prev_r+2].int;
cur_active_width[3]:=cur_active_width[3]-mem[prev_r+3].int;
cur_active_width[4]:=cur_active_width[4]-mem[prev_r+4].int;
cur_active_width[5]:=cur_active_width[5]-mem[prev_r+5].int;
cur_active_width[6]:=cur_active_width[6]-mem[prev_r+6].int;
mem[prev_prev_r].hh.rh:=29993;free_node(prev_r,7);prev_r:=prev_prev_r;
end else if mem[r].hh.b0=2 then begin cur_active_width[1]:=
cur_active_width[1]+mem[r+1].int;
cur_active_width[2]:=cur_active_width[2]+mem[r+2].int;
cur_active_width[3]:=cur_active_width[3]+mem[r+3].int;
cur_active_width[4]:=cur_active_width[4]+mem[r+4].int;
cur_active_width[5]:=cur_active_width[5]+mem[r+5].int;
cur_active_width[6]:=cur_active_width[6]+mem[r+6].int;
mem[prev_r+1].int:=mem[prev_r+1].int+mem[r+1].int;
mem[prev_r+2].int:=mem[prev_r+2].int+mem[r+2].int;
mem[prev_r+3].int:=mem[prev_r+3].int+mem[r+3].int;
mem[prev_r+4].int:=mem[prev_r+4].int+mem[r+4].int;
mem[prev_r+5].int:=mem[prev_r+5].int+mem[r+5].int;
mem[prev_r+6].int:=mem[prev_r+6].int+mem[r+6].int;
mem[prev_r].hh.rh:=mem[r].hh.rh;free_node(r,7);end;end{:860};end{:851};
end;
10:{[858:]if cur_p=printed_node then if cur_p<>0 then if mem[cur_p].hh.
b0=7 then begin t:=mem[cur_p].hh.b1;while t>0 do begin t:=t-1;
printed_node:=mem[printed_node].hh.rh;end;end[:858]}end;
{:829}{877:}procedure post_line_break(final_widow_penalty:integer);
label 30,31;var q,r,s:halfword;disc_break:boolean;
post_disc_break:boolean;cur_width:scaled;cur_indent:scaled;
t:quarterword;pen:integer;cur_line:halfword;
begin{878:}q:=mem[best_bet+1].hh.rh;cur_p:=0;repeat r:=q;
q:=mem[q+1].hh.lh;mem[r+1].hh.lh:=cur_p;cur_p:=r;until q=0{:878};
cur_line:=cur_list.pg_field+1;repeat{880:}{881:}q:=mem[cur_p+1].hh.rh;
disc_break:=false;post_disc_break:=false;
if q<>0 then if mem[q].hh.b0=10 then begin delete_glue_ref(mem[q+1].hh.
lh);mem[q+1].hh.lh:=eqtb[2890].hh.rh;mem[q].hh.b1:=9;
mem[eqtb[2890].hh.rh].hh.rh:=mem[eqtb[2890].hh.rh].hh.rh+1;goto 30;
end else begin if mem[q].hh.b0=7 then{882:}begin t:=mem[q].hh.b1;
{883:}if t=0 then r:=mem[q].hh.rh else begin r:=q;
while t>1 do begin r:=mem[r].hh.rh;t:=t-1;end;s:=mem[r].hh.rh;
r:=mem[s].hh.rh;mem[s].hh.rh:=0;flush_node_list(mem[q].hh.rh);
mem[q].hh.b1:=0;end{:883};
if mem[q+1].hh.rh<>0 then{884:}begin s:=mem[q+1].hh.rh;
while mem[s].hh.rh<>0 do s:=mem[s].hh.rh;mem[s].hh.rh:=r;
r:=mem[q+1].hh.rh;mem[q+1].hh.rh:=0;post_disc_break:=true;end{:884};
if mem[q+1].hh.lh<>0 then{885:}begin s:=mem[q+1].hh.lh;mem[q].hh.rh:=s;
while mem[s].hh.rh<>0 do s:=mem[s].hh.rh;mem[q+1].hh.lh:=0;q:=s;
end{:885};mem[q].hh.rh:=r;disc_break:=true;
end{:882}else if(mem[q].hh.b0=9)or(mem[q].hh.b0=11)then mem[q+1].int:=0;
end else begin q:=29997;while mem[q].hh.rh<>0 do q:=mem[q].hh.rh;end;
{886:}r:=new_param_glue(8);mem[r].hh.rh:=mem[q].hh.rh;mem[q].hh.rh:=r;
q:=r{:886};30:{:881};{887:}r:=mem[q].hh.rh;mem[q].hh.rh:=0;
q:=mem[29997].hh.rh;mem[29997].hh.rh:=r;
if eqtb[2889].hh.rh<>0 then begin r:=new_param_glue(7);mem[r].hh.rh:=q;
q:=r;end{:887};
{889:}if cur_line>last_special_line then begin cur_width:=second_width;
cur_indent:=second_indent;
end else if eqtb[3412].hh.rh=0 then begin cur_width:=first_width;
cur_indent:=first_indent;
end else begin cur_width:=mem[eqtb[3412].hh.rh+2*cur_line].int;
cur_indent:=mem[eqtb[3412].hh.rh+2*cur_line-1].int;end;
adjust_tail:=29995;just_box:=hpack(q,cur_width,0);
mem[just_box+4].int:=cur_indent{:889};{888:}append_to_vlist(just_box);
if 29995<>adjust_tail then begin mem[cur_list.tail_field].hh.rh:=mem[
29995].hh.rh;cur_list.tail_field:=adjust_tail;end;adjust_tail:=0{:888};
{890:}if cur_line+1<>best_line then begin pen:=eqtb[5276].int;
if cur_line=cur_list.pg_field+1 then pen:=pen+eqtb[5268].int;
if cur_line+2=best_line then pen:=pen+final_widow_penalty;
if disc_break then pen:=pen+eqtb[5271].int;
if pen<>0 then begin r:=new_penalty(pen);
mem[cur_list.tail_field].hh.rh:=r;cur_list.tail_field:=r;end;
end{:890}{:880};cur_line:=cur_line+1;cur_p:=mem[cur_p+1].hh.lh;
if cur_p<>0 then if not post_disc_break then{879:}begin r:=29997;
while true do begin q:=mem[r].hh.rh;
if q=mem[cur_p+1].hh.rh then goto 31;if(q>=hi_mem_min)then goto 31;
if(mem[q].hh.b0<9)then goto 31;
if mem[q].hh.b0=11 then if mem[q].hh.b1<>1 then goto 31;r:=q;end;
31:if r<>29997 then begin mem[r].hh.rh:=0;
flush_node_list(mem[29997].hh.rh);mem[29997].hh.rh:=q;end;end{:879};
until cur_p=0;
if(cur_line<>best_line)or(mem[29997].hh.rh<>0)then confusion(938);
cur_list.pg_field:=best_line-1;end;
{:877}{895:}{906:}function reconstitute(j,n:small_number;
bchar,hchar:halfword):small_number;label 22,30;var p:halfword;
t:halfword;q:four_quarters;cur_rh:halfword;test_char:halfword;w:scaled;
k:font_index;begin hyphen_passed:=0;t:=29996;w:=0;mem[29996].hh.rh:=0;
{908:}cur_l:=hu[j]+0;cur_q:=t;
if j=0 then begin ligature_present:=init_lig;p:=init_list;
if ligature_present then lft_hit:=init_lft;
while p>0 do begin begin mem[t].hh.rh:=get_avail;t:=mem[t].hh.rh;
mem[t].hh.b0:=hf;mem[t].hh.b1:=mem[p].hh.b1;end;p:=mem[p].hh.rh;end;
end else if cur_l<256 then begin mem[t].hh.rh:=get_avail;
t:=mem[t].hh.rh;mem[t].hh.b0:=hf;mem[t].hh.b1:=cur_l;end;lig_stack:=0;
begin if j<n then cur_r:=hu[j+1]+0 else cur_r:=bchar;
if odd(hyf[j])then cur_rh:=hchar else cur_rh:=256;end{:908};
22:{909:}if cur_l=256 then begin k:=bchar_label[hf];
if k=0 then goto 30 else q:=font_info[k].qqqq;
end else begin q:=font_info[char_base[hf]+cur_l].qqqq;
if((q.b2-0)mod 4)<>1 then goto 30;k:=lig_kern_base[hf]+q.b3;
q:=font_info[k].qqqq;
if q.b0>128 then begin k:=lig_kern_base[hf]+256*q.b2+q.b3+32768-256*(128
);q:=font_info[k].qqqq;end;end;
if cur_rh<256 then test_char:=cur_rh else test_char:=cur_r;
while true do begin if q.b1=test_char then if q.b0<=128 then if cur_rh<
256 then begin hyphen_passed:=j;hchar:=256;cur_rh:=256;goto 22;
end else begin if hchar<256 then if odd(hyf[j])then begin hyphen_passed
:=j;hchar:=256;end;
if q.b2<128 then{911:}begin if cur_l=256 then lft_hit:=true;
if j=n then if lig_stack=0 then rt_hit:=true;
begin if interrupt<>0 then pause_for_instructions;end;
case q.b2 of 1,5:begin cur_l:=q.b3;ligature_present:=true;end;
2,6:begin cur_r:=q.b3;
if lig_stack>0 then mem[lig_stack].hh.b1:=cur_r else begin lig_stack:=
new_lig_item(cur_r);if j=n then bchar:=256 else begin p:=get_avail;
mem[lig_stack+1].hh.rh:=p;mem[p].hh.b1:=hu[j+1]+0;mem[p].hh.b0:=hf;end;
end;end;3:begin cur_r:=q.b3;p:=lig_stack;lig_stack:=new_lig_item(cur_r);
mem[lig_stack].hh.rh:=p;end;
7,11:begin if ligature_present then begin p:=new_ligature(hf,cur_l,mem[
cur_q].hh.rh);if lft_hit then begin mem[p].hh.b1:=2;lft_hit:=false;end;
if false then if lig_stack=0 then begin mem[p].hh.b1:=mem[p].hh.b1+1;
rt_hit:=false;end;mem[cur_q].hh.rh:=p;t:=p;ligature_present:=false;end;
cur_q:=t;cur_l:=q.b3;ligature_present:=true;end;
others:begin cur_l:=q.b3;ligature_present:=true;
if lig_stack>0 then begin if mem[lig_stack+1].hh.rh>0 then begin mem[t].
hh.rh:=mem[lig_stack+1].hh.rh;t:=mem[t].hh.rh;j:=j+1;end;p:=lig_stack;
lig_stack:=mem[p].hh.rh;free_node(p,2);
if lig_stack=0 then begin if j<n then cur_r:=hu[j+1]+0 else cur_r:=bchar
;if odd(hyf[j])then cur_rh:=hchar else cur_rh:=256;
end else cur_r:=mem[lig_stack].hh.b1;
end else if j=n then goto 30 else begin begin mem[t].hh.rh:=get_avail;
t:=mem[t].hh.rh;mem[t].hh.b0:=hf;mem[t].hh.b1:=cur_r;end;j:=j+1;
begin if j<n then cur_r:=hu[j+1]+0 else cur_r:=bchar;
if odd(hyf[j])then cur_rh:=hchar else cur_rh:=256;end;end;end end;
if q.b2>4 then if q.b2<>7 then goto 30;goto 22;end{:911};
w:=font_info[kern_base[hf]+256*q.b2+q.b3].int;goto 30;end;
if q.b0>=128 then if cur_rh=256 then goto 30 else begin cur_rh:=256;
goto 22;end;k:=k+q.b0+1;q:=font_info[k].qqqq;end;30:{:909};
{910:}if ligature_present then begin p:=new_ligature(hf,cur_l,mem[cur_q]
.hh.rh);if lft_hit then begin mem[p].hh.b1:=2;lft_hit:=false;end;
if rt_hit then if lig_stack=0 then begin mem[p].hh.b1:=mem[p].hh.b1+1;
rt_hit:=false;end;mem[cur_q].hh.rh:=p;t:=p;ligature_present:=false;end;
if w<>0 then begin mem[t].hh.rh:=new_kern(w);t:=mem[t].hh.rh;w:=0;end;
if lig_stack>0 then begin cur_q:=t;cur_l:=mem[lig_stack].hh.b1;
ligature_present:=true;
begin if mem[lig_stack+1].hh.rh>0 then begin mem[t].hh.rh:=mem[lig_stack
+1].hh.rh;t:=mem[t].hh.rh;j:=j+1;end;p:=lig_stack;
lig_stack:=mem[p].hh.rh;free_node(p,2);
if lig_stack=0 then begin if j<n then cur_r:=hu[j+1]+0 else cur_r:=bchar
;if odd(hyf[j])then cur_rh:=hchar else cur_rh:=256;
end else cur_r:=mem[lig_stack].hh.b1;end;goto 22;end{:910};
reconstitute:=j;end;{:906}procedure hyphenate;
label 50,30,40,41,42,45,10;var{901:}i,j,l:0..65;q,r,s:halfword;
bchar:halfword;{:901}{912:}major_tail,minor_tail:halfword;c:ASCII_code;
c_loc:0..63;r_count:integer;hyf_node:halfword;
{:912}{922:}z:trie_pointer;v:integer;{:922}{929:}h:hyph_pointer;
k:str_number;u:pool_pointer;
{:929}begin{923:}for j:=0 to hn do hyf[j]:=0;{930:}h:=hc[1];hn:=hn+1;
hc[hn]:=cur_lang;for j:=2 to hn do h:=(h+h+hc[j])mod 307;
while true do begin{931:}k:=hyph_word[h];if k=0 then goto 45;
if(str_start[k+1]-str_start[k])<hn then goto 45;
if(str_start[k+1]-str_start[k])=hn then begin j:=1;u:=str_start[k];
repeat if str_pool[u]<hc[j]then goto 45;
if str_pool[u]>hc[j]then goto 30;j:=j+1;u:=u+1;until j>hn;
{932:}s:=hyph_list[h];while s<>0 do begin hyf[mem[s].hh.lh]:=1;
s:=mem[s].hh.rh;end{:932};hn:=hn-1;goto 40;end;30:{:931};
if h>0 then h:=h-1 else h:=307;end;45:hn:=hn-1{:930};
if trie[cur_lang+1].b1<>cur_lang+0 then goto 10;hc[0]:=0;hc[hn+1]:=0;
hc[hn+2]:=256;
for j:=0 to hn-r_hyf+1 do begin z:=trie[cur_lang+1].rh+hc[j];l:=j;
while hc[l]=trie[z].b1-0 do begin if trie[z].b0<>0 then{924:}begin v:=
trie[z].b0;repeat v:=v+op_start[cur_lang];i:=l-hyf_distance[v];
if hyf_num[v]>hyf[i]then hyf[i]:=hyf_num[v];v:=hyf_next[v];until v=0;
end{:924};l:=l+1;z:=trie[z].rh+hc[l];end;end;
40:for j:=0 to l_hyf-1 do hyf[j]:=0;
for j:=0 to r_hyf-1 do hyf[hn-j]:=0{:923};
{902:}for j:=l_hyf to hn-r_hyf do if odd(hyf[j])then goto 41;goto 10;
41:{:902};{903:}q:=mem[hb].hh.rh;mem[hb].hh.rh:=0;r:=mem[ha].hh.rh;
mem[ha].hh.rh:=0;bchar:=hyf_bchar;
if(ha>=hi_mem_min)then if mem[ha].hh.b0<>hf then goto 42 else begin
init_list:=ha;init_lig:=false;hu[0]:=mem[ha].hh.b1-0;
end else if mem[ha].hh.b0=6 then if mem[ha+1].hh.b0<>hf then goto 42
else begin init_list:=mem[ha+1].hh.rh;init_lig:=true;
init_lft:=(mem[ha].hh.b1>1);hu[0]:=mem[ha+1].hh.b1-0;
if init_list=0 then if init_lft then begin hu[0]:=256;init_lig:=false;
end;free_node(ha,2);
end else begin if not(r>=hi_mem_min)then if mem[r].hh.b0=6 then if mem[r
].hh.b1>1 then goto 42;j:=1;s:=ha;init_list:=0;goto 50;end;s:=cur_p;
while mem[s].hh.rh<>ha do s:=mem[s].hh.rh;j:=0;goto 50;42:s:=ha;j:=0;
hu[0]:=256;init_lig:=false;init_list:=0;50:flush_node_list(r);
{913:}repeat l:=j;j:=reconstitute(j,hn,bchar,hyf_char+0)+1;
if hyphen_passed=0 then begin mem[s].hh.rh:=mem[29996].hh.rh;
while mem[s].hh.rh>0 do s:=mem[s].hh.rh;if odd(hyf[j-1])then begin l:=j;
hyphen_passed:=j-1;mem[29996].hh.rh:=0;end;end;
if hyphen_passed>0 then{914:}repeat r:=get_node(2);
mem[r].hh.rh:=mem[29996].hh.rh;mem[r].hh.b0:=7;major_tail:=r;r_count:=0;
while mem[major_tail].hh.rh>0 do begin major_tail:=mem[major_tail].hh.rh
;r_count:=r_count+1;end;i:=hyphen_passed;hyf[i]:=0;{915:}minor_tail:=0;
mem[r+1].hh.lh:=0;hyf_node:=new_character(hf,hyf_char);
if hyf_node<>0 then begin i:=i+1;c:=hu[i];hu[i]:=hyf_char;
begin mem[hyf_node].hh.rh:=avail;avail:=hyf_node;{dyn_used:=dyn_used-1;}
end;end;while l<=i do begin l:=reconstitute(l,i,font_bchar[hf],256)+1;
if mem[29996].hh.rh>0 then begin if minor_tail=0 then mem[r+1].hh.lh:=
mem[29996].hh.rh else mem[minor_tail].hh.rh:=mem[29996].hh.rh;
minor_tail:=mem[29996].hh.rh;
while mem[minor_tail].hh.rh>0 do minor_tail:=mem[minor_tail].hh.rh;end;
end;if hyf_node<>0 then begin hu[i]:=c;l:=i;i:=i-1;end{:915};
{916:}minor_tail:=0;mem[r+1].hh.rh:=0;c_loc:=0;
if bchar_label[hf]<>0 then begin l:=l-1;c:=hu[l];c_loc:=l;hu[l]:=256;
end;while l<j do begin repeat l:=reconstitute(l,hn,bchar,256)+1;
if c_loc>0 then begin hu[c_loc]:=c;c_loc:=0;end;
if mem[29996].hh.rh>0 then begin if minor_tail=0 then mem[r+1].hh.rh:=
mem[29996].hh.rh else mem[minor_tail].hh.rh:=mem[29996].hh.rh;
minor_tail:=mem[29996].hh.rh;
while mem[minor_tail].hh.rh>0 do minor_tail:=mem[minor_tail].hh.rh;end;
until l>=j;while l>j do{917:}begin j:=reconstitute(j,hn,bchar,256)+1;
mem[major_tail].hh.rh:=mem[29996].hh.rh;
while mem[major_tail].hh.rh>0 do begin major_tail:=mem[major_tail].hh.rh
;r_count:=r_count+1;end;end{:917};end{:916};
{918:}if r_count>127 then begin mem[s].hh.rh:=mem[r].hh.rh;
mem[r].hh.rh:=0;flush_node_list(r);end else begin mem[s].hh.rh:=r;
mem[r].hh.b1:=r_count;end;s:=major_tail{:918};hyphen_passed:=j-1;
mem[29996].hh.rh:=0;until not odd(hyf[j-1]){:914};until j>hn;
mem[s].hh.rh:=q{:913};flush_list(init_list){:903};10:end;
{:895}{942:}{944:}function new_trie_op(d,n:small_number;
v:quarterword):quarterword;label 10;var h:-trie_op_size..trie_op_size;
u:quarterword;l:0..trie_op_size;
begin h:=abs(n+313*d+361*v+1009*cur_lang)mod(trie_op_size+trie_op_size)-
trie_op_size;while true do begin l:=trie_op_hash[h];
if l=0 then begin if trie_op_ptr=trie_op_size then overflow(948,
trie_op_size);u:=trie_used[cur_lang];if u=255 then overflow(949,255);
trie_op_ptr:=trie_op_ptr+1;u:=u+1;trie_used[cur_lang]:=u;
hyf_distance[trie_op_ptr]:=d;hyf_num[trie_op_ptr]:=n;
hyf_next[trie_op_ptr]:=v;trie_op_lang[trie_op_ptr]:=cur_lang;
trie_op_hash[h]:=trie_op_ptr;trie_op_val[trie_op_ptr]:=u;new_trie_op:=u;
goto 10;end;
if(hyf_distance[l]=d)and(hyf_num[l]=n)and(hyf_next[l]=v)and(trie_op_lang
[l]=cur_lang)then begin new_trie_op:=trie_op_val[l];goto 10;end;
if h>-trie_op_size then h:=h-1 else h:=trie_op_size;end;10:end;
{:944}{948:}function trie_node(p:trie_pointer):trie_pointer;label 10;
var h:trie_pointer;q:trie_pointer;
begin h:=abs(trie_c[p]+1009*trie_o[p]+2718*trie_l[p]+3142*trie_r[p])mod
trie_size;while true do begin q:=trie_hash[h];
if q=0 then begin trie_hash[h]:=p;trie_node:=p;goto 10;end;
if(trie_c[q]=trie_c[p])and(trie_o[q]=trie_o[p])and(trie_l[q]=trie_l[p])
and(trie_r[q]=trie_r[p])then begin trie_node:=q;goto 10;end;
if h>0 then h:=h-1 else h:=trie_size;end;10:end;
{:948}{949:}function compress_trie(p:trie_pointer):trie_pointer;
begin if p=0 then compress_trie:=0 else begin trie_l[p]:=compress_trie(
trie_l[p]);trie_r[p]:=compress_trie(trie_r[p]);
compress_trie:=trie_node(p);end;end;
{:949}{953:}procedure first_fit(p:trie_pointer);label 45,40;
var h:trie_pointer;z:trie_pointer;q:trie_pointer;c:ASCII_code;
l,r:trie_pointer;ll:1..256;begin c:=trie_c[p];z:=trie_min[c];
while true do begin h:=z-c;
{954:}if trie_max<h+256 then begin if trie_size<=h+256 then overflow(950
,trie_size);repeat trie_max:=trie_max+1;trie_taken[trie_max]:=false;
trie[trie_max].rh:=trie_max+1;trie[trie_max].lh:=trie_max-1;
until trie_max=h+256;end{:954};if trie_taken[h]then goto 45;
{955:}q:=trie_r[p];
while q>0 do begin if trie[h+trie_c[q]].rh=0 then goto 45;q:=trie_r[q];
end;goto 40{:955};45:z:=trie[z].rh;end;40:{956:}trie_taken[h]:=true;
trie_hash[p]:=h;q:=p;repeat z:=h+trie_c[q];l:=trie[z].lh;r:=trie[z].rh;
trie[r].lh:=l;trie[l].rh:=r;trie[z].rh:=0;
if l<256 then begin if z<256 then ll:=z else ll:=256;
repeat trie_min[l]:=r;l:=l+1;until l=ll;end;q:=trie_r[q];
until q=0{:956};end;{:953}{957:}procedure trie_pack(p:trie_pointer);
var q:trie_pointer;begin repeat q:=trie_l[p];
if(q>0)and(trie_hash[q]=0)then begin first_fit(q);trie_pack(q);end;
p:=trie_r[p];until p=0;end;
{:957}{959:}procedure trie_fix(p:trie_pointer);var q:trie_pointer;
c:ASCII_code;z:trie_pointer;begin z:=trie_hash[p];repeat q:=trie_l[p];
c:=trie_c[p];trie[z+c].rh:=trie_hash[q];trie[z+c].b1:=c+0;
trie[z+c].b0:=trie_o[p];if q>0 then trie_fix(q);p:=trie_r[p];until p=0;
end;{:959}{960:}procedure new_patterns;label 30,31;var k,l:0..64;
digit_sensed:boolean;v:quarterword;p,q:trie_pointer;first_child:boolean;
c:ASCII_code;
begin if trie_not_ready then begin if eqtb[5313].int<=0 then cur_lang:=0
else if eqtb[5313].int>255 then cur_lang:=0 else cur_lang:=eqtb[5313].
int;scan_left_brace;{961:}k:=0;hyf[0]:=0;digit_sensed:=false;
while true do begin get_x_token;
case cur_cmd of 11,12:{962:}if digit_sensed or(cur_chr<48)or(cur_chr>57)
then begin if cur_chr=46 then cur_chr:=0 else begin cur_chr:=eqtb[4239+
cur_chr].hh.rh;if cur_chr=0 then begin begin if interaction=3 then;
print_nl(262);print(956);end;begin help_ptr:=1;help_line[0]:=955;end;
error;end;end;if k<63 then begin k:=k+1;hc[k]:=cur_chr;hyf[k]:=0;
digit_sensed:=false;end;end else if k<63 then begin hyf[k]:=cur_chr-48;
digit_sensed:=true;end{:962};
10,2:begin if k>0 then{963:}begin{965:}if hc[1]=0 then hyf[0]:=0;
if hc[k]=0 then hyf[k]:=0;l:=k;v:=0;
while true do begin if hyf[l]<>0 then v:=new_trie_op(k-l,hyf[l],v);
if l>0 then l:=l-1 else goto 31;end;31:{:965};q:=0;hc[0]:=cur_lang;
while l<=k do begin c:=hc[l];l:=l+1;p:=trie_l[q];first_child:=true;
while(p>0)and(c>trie_c[p])do begin q:=p;p:=trie_r[q];first_child:=false;
end;if(p=0)or(c<trie_c[p])then{964:}begin if trie_ptr=trie_size then
overflow(950,trie_size);trie_ptr:=trie_ptr+1;trie_r[trie_ptr]:=p;
p:=trie_ptr;trie_l[p]:=0;
if first_child then trie_l[q]:=p else trie_r[q]:=p;trie_c[p]:=c;
trie_o[p]:=0;end{:964};q:=p;end;
if trie_o[q]<>0 then begin begin if interaction=3 then;print_nl(262);
print(957);end;begin help_ptr:=1;help_line[0]:=955;end;error;end;
trie_o[q]:=v;end{:963};if cur_cmd=2 then goto 30;k:=0;hyf[0]:=0;
digit_sensed:=false;end;others:begin begin if interaction=3 then;
print_nl(262);print(954);end;print_esc(952);begin help_ptr:=1;
help_line[0]:=955;end;error;end end;end;30:{:961};
end else begin begin if interaction=3 then;print_nl(262);print(951);end;
print_esc(952);begin help_ptr:=1;help_line[0]:=953;end;error;
mem[29988].hh.rh:=scan_toks(false,false);flush_list(def_ref);end;end;
{:960}{966:}procedure init_trie;var p:trie_pointer;j,k,t:integer;
r,s:trie_pointer;h:two_halves;begin{952:}{945:}op_start[0]:=-0;
for j:=1 to 255 do op_start[j]:=op_start[j-1]+trie_used[j-1]-0;
for j:=1 to trie_op_ptr do trie_op_hash[j]:=op_start[trie_op_lang[j]]+
trie_op_val[j];
for j:=1 to trie_op_ptr do while trie_op_hash[j]>j do begin k:=
trie_op_hash[j];t:=hyf_distance[k];hyf_distance[k]:=hyf_distance[j];
hyf_distance[j]:=t;t:=hyf_num[k];hyf_num[k]:=hyf_num[j];hyf_num[j]:=t;
t:=hyf_next[k];hyf_next[k]:=hyf_next[j];hyf_next[j]:=t;
trie_op_hash[j]:=trie_op_hash[k];trie_op_hash[k]:=k;end{:945};
for p:=0 to trie_size do trie_hash[p]:=0;
trie_l[0]:=compress_trie(trie_l[0]);
for p:=0 to trie_ptr do trie_hash[p]:=0;
for p:=0 to 255 do trie_min[p]:=p+1;trie[0].rh:=1;trie_max:=0{:952};
if trie_l[0]<>0 then begin first_fit(trie_l[0]);trie_pack(trie_l[0]);
end;{958:}h.rh:=0;h.b0:=0;h.b1:=0;
if trie_l[0]=0 then begin for r:=0 to 256 do trie[r]:=h;trie_max:=256;
end else begin trie_fix(trie_l[0]);r:=0;repeat s:=trie[r].rh;trie[r]:=h;
r:=s;until r>trie_max;end;trie[0].b1:=63;{:958};trie_not_ready:=false;
end;{:966}{:942}procedure line_break(final_widow_penalty:integer);
label 30,31,32,33,34,35,22;var{862:}auto_breaking:boolean;
prev_p:halfword;q,r,s,prev_s:halfword;f:internal_font_number;
{:862}{893:}j:small_number;c:0..255;
{:893}begin pack_begin_line:=cur_list.ml_field;
{816:}mem[29997].hh.rh:=mem[cur_list.head_field].hh.rh;
if(cur_list.tail_field>=hi_mem_min)then begin mem[cur_list.tail_field].
hh.rh:=new_penalty(10000);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;
end else if mem[cur_list.tail_field].hh.b0<>10 then begin mem[cur_list.
tail_field].hh.rh:=new_penalty(10000);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;
end else begin mem[cur_list.tail_field].hh.b0:=12;
delete_glue_ref(mem[cur_list.tail_field+1].hh.lh);
flush_node_list(mem[cur_list.tail_field+1].hh.rh);
mem[cur_list.tail_field+1].int:=10000;end;
mem[cur_list.tail_field].hh.rh:=new_param_glue(14);
init_cur_lang:=cur_list.pg_field mod 65536;
init_l_hyf:=cur_list.pg_field div 4194304;
init_r_hyf:=(cur_list.pg_field div 65536)mod 64;pop_nest;
{:816}{827:}no_shrink_error_yet:=true;
if(mem[eqtb[2889].hh.rh].hh.b1<>0)and(mem[eqtb[2889].hh.rh+3].int<>0)
then begin eqtb[2889].hh.rh:=finite_shrink(eqtb[2889].hh.rh);end;
if(mem[eqtb[2890].hh.rh].hh.b1<>0)and(mem[eqtb[2890].hh.rh+3].int<>0)
then begin eqtb[2890].hh.rh:=finite_shrink(eqtb[2890].hh.rh);end;
q:=eqtb[2889].hh.rh;r:=eqtb[2890].hh.rh;
background[1]:=mem[q+1].int+mem[r+1].int;background[2]:=0;
background[3]:=0;background[4]:=0;background[5]:=0;
background[2+mem[q].hh.b0]:=mem[q+2].int;
background[2+mem[r].hh.b0]:=background[2+mem[r].hh.b0]+mem[r+2].int;
background[6]:=mem[q+3].int+mem[r+3].int;
{:827}{834:}minimum_demerits:=1073741823;
minimal_demerits[3]:=1073741823;minimal_demerits[2]:=1073741823;
minimal_demerits[1]:=1073741823;minimal_demerits[0]:=1073741823;
{:834}{848:}if eqtb[3412].hh.rh=0 then if eqtb[5847].int=0 then begin
last_special_line:=0;second_width:=eqtb[5833].int;second_indent:=0;
end else{849:}begin last_special_line:=abs(eqtb[5304].int);
if eqtb[5304].int<0 then begin first_width:=eqtb[5833].int-abs(eqtb[5847
].int);
if eqtb[5847].int>=0 then first_indent:=eqtb[5847].int else first_indent
:=0;second_width:=eqtb[5833].int;second_indent:=0;
end else begin first_width:=eqtb[5833].int;first_indent:=0;
second_width:=eqtb[5833].int-abs(eqtb[5847].int);
if eqtb[5847].int>=0 then second_indent:=eqtb[5847].int else
second_indent:=0;end;
end{:849}else begin last_special_line:=mem[eqtb[3412].hh.rh].hh.lh-1;
second_width:=mem[eqtb[3412].hh.rh+2*(last_special_line+1)].int;
second_indent:=mem[eqtb[3412].hh.rh+2*last_special_line+1].int;end;
if eqtb[5282].int=0 then easy_line:=last_special_line else easy_line:=
65535{:848};{863:}threshold:=eqtb[5263].int;
if threshold>=0 then begin{if eqtb[5295].int>0 then begin
begin_diagnostic;print_nl(932);end;}second_pass:=false;
final_pass:=false;end else begin threshold:=eqtb[5264].int;
second_pass:=true;final_pass:=(eqtb[5850].int<=0);
{if eqtb[5295].int>0 then begin_diagnostic;}end;
while true do begin if threshold>10000 then threshold:=10000;
if second_pass then{891:}begin if trie_not_ready then init_trie;
cur_lang:=init_cur_lang;l_hyf:=init_l_hyf;r_hyf:=init_r_hyf;end{:891};
{864:}q:=get_node(3);mem[q].hh.b0:=0;mem[q].hh.b1:=2;
mem[q].hh.rh:=29993;mem[q+1].hh.rh:=0;
mem[q+1].hh.lh:=cur_list.pg_field+1;mem[q+2].int:=0;mem[29993].hh.rh:=q;
active_width[1]:=background[1];active_width[2]:=background[2];
active_width[3]:=background[3];active_width[4]:=background[4];
active_width[5]:=background[5];active_width[6]:=background[6];
passive:=0;printed_node:=29997;pass_number:=0;
font_in_short_display:=0{:864};cur_p:=mem[29997].hh.rh;
auto_breaking:=true;prev_p:=cur_p;
while(cur_p<>0)and(mem[29993].hh.rh<>29993)do{866:}begin if(cur_p>=
hi_mem_min)then{867:}begin prev_p:=cur_p;repeat f:=mem[cur_p].hh.b0;
active_width[1]:=active_width[1]+font_info[width_base[f]+font_info[
char_base[f]+mem[cur_p].hh.b1].qqqq.b0].int;cur_p:=mem[cur_p].hh.rh;
until not(cur_p>=hi_mem_min);end{:867};
case mem[cur_p].hh.b0 of 0,1,2:active_width[1]:=active_width[1]+mem[
cur_p+1].int;
8:{1362:}if mem[cur_p].hh.b1=4 then begin cur_lang:=mem[cur_p+1].hh.rh;
l_hyf:=mem[cur_p+1].hh.b0;r_hyf:=mem[cur_p+1].hh.b1;end{:1362};
10:begin{868:}if auto_breaking then begin if(prev_p>=hi_mem_min)then
try_break(0,0)else if(mem[prev_p].hh.b0<9)then try_break(0,0)else if(mem
[prev_p].hh.b0=11)and(mem[prev_p].hh.b1<>1)then try_break(0,0);end;
if(mem[mem[cur_p+1].hh.lh].hh.b1<>0)and(mem[mem[cur_p+1].hh.lh+3].int<>0
)then begin mem[cur_p+1].hh.lh:=finite_shrink(mem[cur_p+1].hh.lh);end;
q:=mem[cur_p+1].hh.lh;active_width[1]:=active_width[1]+mem[q+1].int;
active_width[2+mem[q].hh.b0]:=active_width[2+mem[q].hh.b0]+mem[q+2].int;
active_width[6]:=active_width[6]+mem[q+3].int{:868};
if second_pass and auto_breaking then{894:}begin prev_s:=cur_p;
s:=mem[prev_s].hh.rh;
if s<>0 then begin{896:}while true do begin if(s>=hi_mem_min)then begin
c:=mem[s].hh.b1-0;hf:=mem[s].hh.b0;
end else if mem[s].hh.b0=6 then if mem[s+1].hh.rh=0 then goto 22 else
begin q:=mem[s+1].hh.rh;c:=mem[q].hh.b1-0;hf:=mem[q].hh.b0;
end else if(mem[s].hh.b0=11)and(mem[s].hh.b1=0)then goto 22 else if mem[
s].hh.b0=8 then begin{1363:}if mem[s].hh.b1=4 then begin cur_lang:=mem[s
+1].hh.rh;l_hyf:=mem[s+1].hh.b0;r_hyf:=mem[s+1].hh.b1;end{:1363};
goto 22;end else goto 31;
if eqtb[4239+c].hh.rh<>0 then if(eqtb[4239+c].hh.rh=c)or(eqtb[5301].int>
0)then goto 32 else goto 31;22:prev_s:=s;s:=mem[prev_s].hh.rh;end;
32:hyf_char:=hyphen_char[hf];if hyf_char<0 then goto 31;
if hyf_char>255 then goto 31;ha:=prev_s{:896};
if l_hyf+r_hyf>63 then goto 31;{897:}hn:=0;
while true do begin if(s>=hi_mem_min)then begin if mem[s].hh.b0<>hf then
goto 33;hyf_bchar:=mem[s].hh.b1;c:=hyf_bchar-0;
if eqtb[4239+c].hh.rh=0 then goto 33;if hn=63 then goto 33;hb:=s;
hn:=hn+1;hu[hn]:=c;hc[hn]:=eqtb[4239+c].hh.rh;hyf_bchar:=256;
end else if mem[s].hh.b0=6 then{898:}begin if mem[s+1].hh.b0<>hf then
goto 33;j:=hn;q:=mem[s+1].hh.rh;if q>0 then hyf_bchar:=mem[q].hh.b1;
while q>0 do begin c:=mem[q].hh.b1-0;
if eqtb[4239+c].hh.rh=0 then goto 33;if j=63 then goto 33;j:=j+1;
hu[j]:=c;hc[j]:=eqtb[4239+c].hh.rh;q:=mem[q].hh.rh;end;hb:=s;hn:=j;
if odd(mem[s].hh.b1)then hyf_bchar:=font_bchar[hf]else hyf_bchar:=256;
end{:898}else if(mem[s].hh.b0=11)and(mem[s].hh.b1=0)then begin hb:=s;
hyf_bchar:=font_bchar[hf];end else goto 33;s:=mem[s].hh.rh;end;
33:{:897};{899:}if hn<l_hyf+r_hyf then goto 31;
while true do begin if not((s>=hi_mem_min))then case mem[s].hh.b0 of 6:;
11:if mem[s].hh.b1<>0 then goto 34;8,10,12,3,5,4:goto 34;
others:goto 31 end;s:=mem[s].hh.rh;end;34:{:899};hyphenate;end;
31:end{:894};end;
11:if mem[cur_p].hh.b1=1 then begin if not(mem[cur_p].hh.rh>=hi_mem_min)
and auto_breaking then if mem[mem[cur_p].hh.rh].hh.b0=10 then try_break(
0,0);active_width[1]:=active_width[1]+mem[cur_p+1].int;
end else active_width[1]:=active_width[1]+mem[cur_p+1].int;
6:begin f:=mem[cur_p+1].hh.b0;
active_width[1]:=active_width[1]+font_info[width_base[f]+font_info[
char_base[f]+mem[cur_p+1].hh.b1].qqqq.b0].int;end;
7:{869:}begin s:=mem[cur_p+1].hh.lh;disc_width:=0;
if s=0 then try_break(eqtb[5267].int,1)else begin repeat{870:}if(s>=
hi_mem_min)then begin f:=mem[s].hh.b0;
disc_width:=disc_width+font_info[width_base[f]+font_info[char_base[f]+
mem[s].hh.b1].qqqq.b0].int;
end else case mem[s].hh.b0 of 6:begin f:=mem[s+1].hh.b0;
disc_width:=disc_width+font_info[width_base[f]+font_info[char_base[f]+
mem[s+1].hh.b1].qqqq.b0].int;end;
0,1,2,11:disc_width:=disc_width+mem[s+1].int;
others:confusion(936)end{:870};s:=mem[s].hh.rh;until s=0;
active_width[1]:=active_width[1]+disc_width;try_break(eqtb[5266].int,1);
active_width[1]:=active_width[1]-disc_width;end;r:=mem[cur_p].hh.b1;
s:=mem[cur_p].hh.rh;
while r>0 do begin{871:}if(s>=hi_mem_min)then begin f:=mem[s].hh.b0;
active_width[1]:=active_width[1]+font_info[width_base[f]+font_info[
char_base[f]+mem[s].hh.b1].qqqq.b0].int;
end else case mem[s].hh.b0 of 6:begin f:=mem[s+1].hh.b0;
active_width[1]:=active_width[1]+font_info[width_base[f]+font_info[
char_base[f]+mem[s+1].hh.b1].qqqq.b0].int;end;
0,1,2,11:active_width[1]:=active_width[1]+mem[s+1].int;
others:confusion(937)end{:871};r:=r-1;s:=mem[s].hh.rh;end;prev_p:=cur_p;
cur_p:=s;goto 35;end{:869};9:begin auto_breaking:=(mem[cur_p].hh.b1=1);
begin if not(mem[cur_p].hh.rh>=hi_mem_min)and auto_breaking then if mem[
mem[cur_p].hh.rh].hh.b0=10 then try_break(0,0);
active_width[1]:=active_width[1]+mem[cur_p+1].int;end;end;
12:try_break(mem[cur_p+1].int,0);4,3,5:;others:confusion(935)end;
prev_p:=cur_p;cur_p:=mem[cur_p].hh.rh;35:end{:866};
if cur_p=0 then{873:}begin try_break(-10000,1);
if mem[29993].hh.rh<>29993 then begin{874:}r:=mem[29993].hh.rh;
fewest_demerits:=1073741823;
repeat if mem[r].hh.b0<>2 then if mem[r+2].int<fewest_demerits then
begin fewest_demerits:=mem[r+2].int;best_bet:=r;end;r:=mem[r].hh.rh;
until r=29993;best_line:=mem[best_bet+1].hh.lh{:874};
if eqtb[5282].int=0 then goto 30;{875:}begin r:=mem[29993].hh.rh;
actual_looseness:=0;
repeat if mem[r].hh.b0<>2 then begin line_diff:=mem[r+1].hh.lh-best_line
;if((line_diff<actual_looseness)and(eqtb[5282].int<=line_diff))or((
line_diff>actual_looseness)and(eqtb[5282].int>=line_diff))then begin
best_bet:=r;actual_looseness:=line_diff;fewest_demerits:=mem[r+2].int;
end else if(line_diff=actual_looseness)and(mem[r+2].int<fewest_demerits)
then begin best_bet:=r;fewest_demerits:=mem[r+2].int;end;end;
r:=mem[r].hh.rh;until r=29993;best_line:=mem[best_bet+1].hh.lh;
end{:875};if(actual_looseness=eqtb[5282].int)or final_pass then goto 30;
end;end{:873};{865:}q:=mem[29993].hh.rh;
while q<>29993 do begin cur_p:=mem[q].hh.rh;
if mem[q].hh.b0=2 then free_node(q,7)else free_node(q,3);q:=cur_p;end;
q:=passive;while q<>0 do begin cur_p:=mem[q].hh.rh;free_node(q,2);
q:=cur_p;end{:865};
if not second_pass then begin{if eqtb[5295].int>0 then print_nl(933);}
threshold:=eqtb[5264].int;second_pass:=true;
final_pass:=(eqtb[5850].int<=0);
end else begin{if eqtb[5295].int>0 then print_nl(934);}
background[2]:=background[2]+eqtb[5850].int;final_pass:=true;end;end;
30:{if eqtb[5295].int>0 then begin end_diagnostic(true);
normalize_selector;end;}{:863};
{876:}post_line_break(final_widow_penalty){:876};
{865:}q:=mem[29993].hh.rh;while q<>29993 do begin cur_p:=mem[q].hh.rh;
if mem[q].hh.b0=2 then free_node(q,7)else free_node(q,3);q:=cur_p;end;
q:=passive;while q<>0 do begin cur_p:=mem[q].hh.rh;free_node(q,2);
q:=cur_p;end{:865};pack_begin_line:=0;end;
{:815}{934:}procedure new_hyph_exceptions;label 21,10,40,45;var n:0..64;
j:0..64;h:hyph_pointer;k:str_number;p:halfword;q:halfword;
s,t:str_number;u,v:pool_pointer;begin scan_left_brace;
if eqtb[5313].int<=0 then cur_lang:=0 else if eqtb[5313].int>255 then
cur_lang:=0 else cur_lang:=eqtb[5313].int;{935:}n:=0;p:=0;
while true do begin get_x_token;
21:case cur_cmd of 11,12,68:{937:}if cur_chr=45 then{938:}begin if n<63
then begin q:=get_avail;mem[q].hh.rh:=p;mem[q].hh.lh:=n;p:=q;end;
end{:938}else begin if eqtb[4239+cur_chr].hh.rh=0 then begin begin if
interaction=3 then;print_nl(262);print(944);end;begin help_ptr:=2;
help_line[1]:=945;help_line[0]:=946;end;error;
end else if n<63 then begin n:=n+1;hc[n]:=eqtb[4239+cur_chr].hh.rh;end;
end{:937};16:begin scan_char_num;cur_chr:=cur_val;cur_cmd:=68;goto 21;
end;10,2:begin if n>1 then{939:}begin n:=n+1;hc[n]:=cur_lang;
begin if pool_ptr+n>pool_size then overflow(257,pool_size-init_pool_ptr)
;end;h:=0;for j:=1 to n do begin h:=(h+h+hc[j])mod 307;
begin str_pool[pool_ptr]:=hc[j];pool_ptr:=pool_ptr+1;end;end;
s:=make_string;{940:}if hyph_count=307 then overflow(947,307);
hyph_count:=hyph_count+1;
while hyph_word[h]<>0 do begin{941:}k:=hyph_word[h];
if(str_start[k+1]-str_start[k])<(str_start[s+1]-str_start[s])then goto
40;
if(str_start[k+1]-str_start[k])>(str_start[s+1]-str_start[s])then goto
45;u:=str_start[k];v:=str_start[s];
repeat if str_pool[u]<str_pool[v]then goto 40;
if str_pool[u]>str_pool[v]then goto 45;u:=u+1;v:=v+1;
until u=str_start[k+1];40:q:=hyph_list[h];hyph_list[h]:=p;p:=q;
t:=hyph_word[h];hyph_word[h]:=s;s:=t;45:{:941};
if h>0 then h:=h-1 else h:=307;end;hyph_word[h]:=s;
hyph_list[h]:=p{:940};end{:939};if cur_cmd=2 then goto 10;n:=0;p:=0;end;
others:{936:}begin begin if interaction=3 then;print_nl(262);print(680);
end;print_esc(940);print(941);begin help_ptr:=2;help_line[1]:=942;
help_line[0]:=943;end;error;end{:936}end;end{:935};10:end;
{:934}{968:}function prune_page_top(p:halfword):halfword;
var prev_p:halfword;q:halfword;begin prev_p:=29997;mem[29997].hh.rh:=p;
while p<>0 do case mem[p].hh.b0 of 0,1,2:{969:}begin q:=new_skip_param(
10);mem[prev_p].hh.rh:=q;mem[q].hh.rh:=p;
if mem[temp_ptr+1].int>mem[p+3].int then mem[temp_ptr+1].int:=mem[
temp_ptr+1].int-mem[p+3].int else mem[temp_ptr+1].int:=0;p:=0;end{:969};
8,4,3:begin prev_p:=p;p:=mem[prev_p].hh.rh;end;10,11,12:begin q:=p;
p:=mem[q].hh.rh;mem[q].hh.rh:=0;mem[prev_p].hh.rh:=p;flush_node_list(q);
end;others:confusion(958)end;prune_page_top:=mem[29997].hh.rh;end;
{:968}{970:}function vert_break(p:halfword;h,d:scaled):halfword;
label 30,45,90;var prev_p:halfword;q,r:halfword;pi:integer;b:integer;
least_cost:integer;best_place:halfword;prev_dp:scaled;t:small_number;
begin prev_p:=p;least_cost:=1073741823;active_width[1]:=0;
active_width[2]:=0;active_width[3]:=0;active_width[4]:=0;
active_width[5]:=0;active_width[6]:=0;prev_dp:=0;
while true do begin{972:}if p=0 then pi:=-10000 else{973:}case mem[p].hh
.b0 of 0,1,2:begin active_width[1]:=active_width[1]+prev_dp+mem[p+3].int
;prev_dp:=mem[p+2].int;goto 45;end;8:{1365:}goto 45{:1365};
10:if(mem[prev_p].hh.b0<9)then pi:=0 else goto 90;
11:begin if mem[p].hh.rh=0 then t:=12 else t:=mem[mem[p].hh.rh].hh.b0;
if t=10 then pi:=0 else goto 90;end;12:pi:=mem[p+1].int;4,3:goto 45;
others:confusion(959)end{:973};
{974:}if pi<10000 then begin{975:}if active_width[1]<h then if(
active_width[3]<>0)or(active_width[4]<>0)or(active_width[5]<>0)then b:=0
else b:=badness(h-active_width[1],active_width[2])else if active_width[1
]-h>active_width[6]then b:=1073741823 else b:=badness(active_width[1]-h,
active_width[6]){:975};
if b<1073741823 then if pi<=-10000 then b:=pi else if b<10000 then b:=b+
pi else b:=100000;if b<=least_cost then begin best_place:=p;
least_cost:=b;best_height_plus_depth:=active_width[1]+prev_dp;end;
if(b=1073741823)or(pi<=-10000)then goto 30;end{:974};
if(mem[p].hh.b0<10)or(mem[p].hh.b0>11)then goto 45;
90:{976:}if mem[p].hh.b0=11 then q:=p else begin q:=mem[p+1].hh.lh;
active_width[2+mem[q].hh.b0]:=active_width[2+mem[q].hh.b0]+mem[q+2].int;
active_width[6]:=active_width[6]+mem[q+3].int;
if(mem[q].hh.b1<>0)and(mem[q+3].int<>0)then begin begin if interaction=3
then;print_nl(262);print(960);end;begin help_ptr:=4;help_line[3]:=961;
help_line[2]:=962;help_line[1]:=963;help_line[0]:=921;end;error;
r:=new_spec(q);mem[r].hh.b1:=0;delete_glue_ref(q);mem[p+1].hh.lh:=r;
q:=r;end;end;active_width[1]:=active_width[1]+prev_dp+mem[q+1].int;
prev_dp:=0{:976};
45:if prev_dp>d then begin active_width[1]:=active_width[1]+prev_dp-d;
prev_dp:=d;end;{:972};prev_p:=p;p:=mem[prev_p].hh.rh;end;
30:vert_break:=best_place;end;{:970}{977:}function vsplit(n:eight_bits;
h:scaled):halfword;label 10,30;var v:halfword;p:halfword;q:halfword;
begin v:=eqtb[3678+n].hh.rh;
if cur_mark[3]<>0 then begin delete_token_ref(cur_mark[3]);
cur_mark[3]:=0;delete_token_ref(cur_mark[4]);cur_mark[4]:=0;end;
{978:}if v=0 then begin vsplit:=0;goto 10;end;
if mem[v].hh.b0<>1 then begin begin if interaction=3 then;print_nl(262);
print(338);end;print_esc(964);print(965);print_esc(966);
begin help_ptr:=2;help_line[1]:=967;help_line[0]:=968;end;error;
vsplit:=0;goto 10;end{:978};
q:=vert_break(mem[v+5].hh.rh,h,eqtb[5836].int);{979:}p:=mem[v+5].hh.rh;
if p=q then mem[v+5].hh.rh:=0 else while true do begin if mem[p].hh.b0=4
then if cur_mark[3]=0 then begin cur_mark[3]:=mem[p+1].int;
cur_mark[4]:=cur_mark[3];
mem[cur_mark[3]].hh.lh:=mem[cur_mark[3]].hh.lh+2;
end else begin delete_token_ref(cur_mark[4]);cur_mark[4]:=mem[p+1].int;
mem[cur_mark[4]].hh.lh:=mem[cur_mark[4]].hh.lh+1;end;
if mem[p].hh.rh=q then begin mem[p].hh.rh:=0;goto 30;end;
p:=mem[p].hh.rh;end;30:{:979};q:=prune_page_top(q);p:=mem[v+5].hh.rh;
free_node(v,7);
if q=0 then eqtb[3678+n].hh.rh:=0 else eqtb[3678+n].hh.rh:=vpackage(q,0,
1,1073741823);vsplit:=vpackage(p,h,0,eqtb[5836].int);10:end;
{:977}{985:}procedure print_totals;begin print_scaled(page_so_far[1]);
if page_so_far[2]<>0 then begin print(312);print_scaled(page_so_far[2]);
print(338);end;if page_so_far[3]<>0 then begin print(312);
print_scaled(page_so_far[3]);print(311);end;
if page_so_far[4]<>0 then begin print(312);print_scaled(page_so_far[4]);
print(977);end;if page_so_far[5]<>0 then begin print(312);
print_scaled(page_so_far[5]);print(978);end;
if page_so_far[6]<>0 then begin print(313);print_scaled(page_so_far[6]);
end;end;{:985}{987:}procedure freeze_page_specs(s:small_number);
begin page_contents:=s;page_so_far[0]:=eqtb[5834].int;
page_max_depth:=eqtb[5835].int;page_so_far[7]:=0;page_so_far[1]:=0;
page_so_far[2]:=0;page_so_far[3]:=0;page_so_far[4]:=0;page_so_far[5]:=0;
page_so_far[6]:=0;least_page_cost:=1073741823;
{if eqtb[5296].int>0 then begin begin_diagnostic;print_nl(986);
print_scaled(page_so_far[0]);print(987);print_scaled(page_max_depth);
end_diagnostic(false);end;}end;
{:987}{992:}procedure box_error(n:eight_bits);begin error;
begin_diagnostic;print_nl(835);show_box(eqtb[3678+n].hh.rh);
end_diagnostic(true);flush_node_list(eqtb[3678+n].hh.rh);
eqtb[3678+n].hh.rh:=0;end;
{:992}{993:}procedure ensure_vbox(n:eight_bits);var p:halfword;
begin p:=eqtb[3678+n].hh.rh;
if p<>0 then if mem[p].hh.b0=0 then begin begin if interaction=3 then;
print_nl(262);print(988);end;begin help_ptr:=3;help_line[2]:=989;
help_line[1]:=990;help_line[0]:=991;end;box_error(n);end;end;
{:993}{994:}{1012:}procedure fire_up(c:halfword);label 10;
var p,q,r,s:halfword;prev_p:halfword;n:0..255;wait:boolean;
save_vbadness:integer;save_vfuzz:scaled;save_split_top_skip:halfword;
begin{1013:}if mem[best_page_break].hh.b0=12 then begin geq_word_define(
5302,mem[best_page_break+1].int);mem[best_page_break+1].int:=10000;
end else geq_word_define(5302,10000){:1013};
if cur_mark[2]<>0 then begin if cur_mark[0]<>0 then delete_token_ref(
cur_mark[0]);cur_mark[0]:=cur_mark[2];
mem[cur_mark[0]].hh.lh:=mem[cur_mark[0]].hh.lh+1;
delete_token_ref(cur_mark[1]);cur_mark[1]:=0;end;
{1014:}if c=best_page_break then best_page_break:=0;
{1015:}if eqtb[3933].hh.rh<>0 then begin begin if interaction=3 then;
print_nl(262);print(338);end;print_esc(409);print(1002);
begin help_ptr:=2;help_line[1]:=1003;help_line[0]:=991;end;
box_error(255);end{:1015};insert_penalties:=0;
save_split_top_skip:=eqtb[2892].hh.rh;
if eqtb[5316].int<=0 then{1018:}begin r:=mem[30000].hh.rh;
while r<>30000 do begin if mem[r+2].hh.lh<>0 then begin n:=mem[r].hh.b1
-0;ensure_vbox(n);
if eqtb[3678+n].hh.rh=0 then eqtb[3678+n].hh.rh:=new_null_box;
p:=eqtb[3678+n].hh.rh+5;while mem[p].hh.rh<>0 do p:=mem[p].hh.rh;
mem[r+2].hh.rh:=p;end;r:=mem[r].hh.rh;end;end{:1018};q:=29996;
mem[q].hh.rh:=0;prev_p:=29998;p:=mem[prev_p].hh.rh;
while p<>best_page_break do begin if mem[p].hh.b0=3 then begin if eqtb[
5316].int<=0 then{1020:}begin r:=mem[30000].hh.rh;
while mem[r].hh.b1<>mem[p].hh.b1 do r:=mem[r].hh.rh;
if mem[r+2].hh.lh=0 then wait:=true else begin wait:=false;
s:=mem[r+2].hh.rh;mem[s].hh.rh:=mem[p+4].hh.lh;
if mem[r+2].hh.lh=p then{1021:}begin if mem[r].hh.b0=1 then if(mem[r+1].
hh.lh=p)and(mem[r+1].hh.rh<>0)then begin while mem[s].hh.rh<>mem[r+1].hh
.rh do s:=mem[s].hh.rh;mem[s].hh.rh:=0;eqtb[2892].hh.rh:=mem[p+4].hh.rh;
mem[p+4].hh.lh:=prune_page_top(mem[r+1].hh.rh);
if mem[p+4].hh.lh<>0 then begin temp_ptr:=vpackage(mem[p+4].hh.lh,0,1,
1073741823);mem[p+3].int:=mem[temp_ptr+3].int+mem[temp_ptr+2].int;
free_node(temp_ptr,7);wait:=true;end;end;mem[r+2].hh.lh:=0;
n:=mem[r].hh.b1-0;temp_ptr:=mem[eqtb[3678+n].hh.rh+5].hh.rh;
free_node(eqtb[3678+n].hh.rh,7);
eqtb[3678+n].hh.rh:=vpackage(temp_ptr,0,1,1073741823);
end{:1021}else begin while mem[s].hh.rh<>0 do s:=mem[s].hh.rh;
mem[r+2].hh.rh:=s;end;end;{1022:}mem[prev_p].hh.rh:=mem[p].hh.rh;
mem[p].hh.rh:=0;if wait then begin mem[q].hh.rh:=p;q:=p;
insert_penalties:=insert_penalties+1;
end else begin delete_glue_ref(mem[p+4].hh.rh);free_node(p,5);end;
p:=prev_p{:1022};end{:1020};
end else if mem[p].hh.b0=4 then{1016:}begin if cur_mark[1]=0 then begin
cur_mark[1]:=mem[p+1].int;
mem[cur_mark[1]].hh.lh:=mem[cur_mark[1]].hh.lh+1;end;
if cur_mark[2]<>0 then delete_token_ref(cur_mark[2]);
cur_mark[2]:=mem[p+1].int;
mem[cur_mark[2]].hh.lh:=mem[cur_mark[2]].hh.lh+1;end{:1016};prev_p:=p;
p:=mem[prev_p].hh.rh;end;eqtb[2892].hh.rh:=save_split_top_skip;
{1017:}if p<>0 then begin if mem[29999].hh.rh=0 then if nest_ptr=0 then
cur_list.tail_field:=page_tail else nest[0].tail_field:=page_tail;
mem[page_tail].hh.rh:=mem[29999].hh.rh;mem[29999].hh.rh:=p;
mem[prev_p].hh.rh:=0;end;save_vbadness:=eqtb[5290].int;
eqtb[5290].int:=10000;save_vfuzz:=eqtb[5839].int;
eqtb[5839].int:=1073741823;
eqtb[3933].hh.rh:=vpackage(mem[29998].hh.rh,best_size,0,page_max_depth);
eqtb[5290].int:=save_vbadness;eqtb[5839].int:=save_vfuzz;
if last_glue<>65535 then delete_glue_ref(last_glue);
{991:}page_contents:=0;page_tail:=29998;mem[29998].hh.rh:=0;
last_glue:=65535;last_penalty:=0;last_kern:=0;page_so_far[7]:=0;
page_max_depth:=0{:991};
if q<>29996 then begin mem[29998].hh.rh:=mem[29996].hh.rh;page_tail:=q;
end{:1017};{1019:}r:=mem[30000].hh.rh;
while r<>30000 do begin q:=mem[r].hh.rh;free_node(r,4);r:=q;end;
mem[30000].hh.rh:=30000{:1019}{:1014};
if(cur_mark[0]<>0)and(cur_mark[1]=0)then begin cur_mark[1]:=cur_mark[0];
mem[cur_mark[0]].hh.lh:=mem[cur_mark[0]].hh.lh+1;end;
if eqtb[3413].hh.rh<>0 then if dead_cycles>=eqtb[5303].int then{1024:}
begin begin if interaction=3 then;print_nl(262);print(1004);end;
print_int(dead_cycles);print(1005);begin help_ptr:=3;help_line[2]:=1006;
help_line[1]:=1007;help_line[0]:=1008;end;error;
end{:1024}else{1025:}begin output_active:=true;
dead_cycles:=dead_cycles+1;push_nest;cur_list.mode_field:=-1;
cur_list.aux_field.int:=-65536000;cur_list.ml_field:=-line;
begin_token_list(eqtb[3413].hh.rh,6);new_save_level(8);normal_paragraph;
scan_left_brace;goto 10;end{:1025};
{1023:}begin if mem[29998].hh.rh<>0 then begin if mem[29999].hh.rh=0
then if nest_ptr=0 then cur_list.tail_field:=page_tail else nest[0].
tail_field:=page_tail else mem[page_tail].hh.rh:=mem[29999].hh.rh;
mem[29999].hh.rh:=mem[29998].hh.rh;mem[29998].hh.rh:=0;page_tail:=29998;
end;ship_out(eqtb[3933].hh.rh);eqtb[3933].hh.rh:=0;end{:1023};10:end;
{:1012}procedure build_page;label 10,30,31,22,80,90;var p:halfword;
q,r:halfword;b,c:integer;pi:integer;n:0..255;delta,h,w:scaled;
begin if(mem[29999].hh.rh=0)or output_active then goto 10;
repeat 22:p:=mem[29999].hh.rh;
{996:}if last_glue<>65535 then delete_glue_ref(last_glue);
last_penalty:=0;last_kern:=0;
if mem[p].hh.b0=10 then begin last_glue:=mem[p+1].hh.lh;
mem[last_glue].hh.rh:=mem[last_glue].hh.rh+1;
end else begin last_glue:=65535;
if mem[p].hh.b0=12 then last_penalty:=mem[p+1].int else if mem[p].hh.b0=
11 then last_kern:=mem[p+1].int;end{:996};
{997:}{1000:}case mem[p].hh.b0 of 0,1,2:if page_contents<2 then{1001:}
begin if page_contents=0 then freeze_page_specs(2)else page_contents:=2;
q:=new_skip_param(9);
if mem[temp_ptr+1].int>mem[p+3].int then mem[temp_ptr+1].int:=mem[
temp_ptr+1].int-mem[p+3].int else mem[temp_ptr+1].int:=0;
mem[q].hh.rh:=p;mem[29999].hh.rh:=q;goto 22;
end{:1001}else{1002:}begin page_so_far[1]:=page_so_far[1]+page_so_far[7]
+mem[p+3].int;page_so_far[7]:=mem[p+2].int;goto 80;end{:1002};
8:{1364:}goto 80{:1364};
10:if page_contents<2 then goto 31 else if(mem[page_tail].hh.b0<9)then
pi:=0 else goto 90;
11:if page_contents<2 then goto 31 else if mem[p].hh.rh=0 then goto 10
else if mem[mem[p].hh.rh].hh.b0=10 then pi:=0 else goto 90;
12:if page_contents<2 then goto 31 else pi:=mem[p+1].int;4:goto 80;
3:{1008:}begin if page_contents=0 then freeze_page_specs(1);
n:=mem[p].hh.b1;r:=30000;
while n>=mem[mem[r].hh.rh].hh.b1 do r:=mem[r].hh.rh;n:=n-0;
if mem[r].hh.b1<>n+0 then{1009:}begin q:=get_node(4);
mem[q].hh.rh:=mem[r].hh.rh;mem[r].hh.rh:=q;r:=q;mem[r].hh.b1:=n+0;
mem[r].hh.b0:=0;ensure_vbox(n);
if eqtb[3678+n].hh.rh=0 then mem[r+3].int:=0 else mem[r+3].int:=mem[eqtb
[3678+n].hh.rh+3].int+mem[eqtb[3678+n].hh.rh+2].int;mem[r+2].hh.lh:=0;
q:=eqtb[2900+n].hh.rh;
if eqtb[5318+n].int=1000 then h:=mem[r+3].int else h:=x_over_n(mem[r+3].
int,1000)*eqtb[5318+n].int;
page_so_far[0]:=page_so_far[0]-h-mem[q+1].int;
page_so_far[2+mem[q].hh.b0]:=page_so_far[2+mem[q].hh.b0]+mem[q+2].int;
page_so_far[6]:=page_so_far[6]+mem[q+3].int;
if(mem[q].hh.b1<>0)and(mem[q+3].int<>0)then begin begin if interaction=3
then;print_nl(262);print(997);end;print_esc(395);print_int(n);
begin help_ptr:=3;help_line[2]:=998;help_line[1]:=999;help_line[0]:=921;
end;error;end;end{:1009};
if mem[r].hh.b0=1 then insert_penalties:=insert_penalties+mem[p+1].int
else begin mem[r+2].hh.rh:=p;
delta:=page_so_far[0]-page_so_far[1]-page_so_far[7]+page_so_far[6];
if eqtb[5318+n].int=1000 then h:=mem[p+3].int else h:=x_over_n(mem[p+3].
int,1000)*eqtb[5318+n].int;
if((h<=0)or(h<=delta))and(mem[p+3].int+mem[r+3].int<=eqtb[5851+n].int)
then begin page_so_far[0]:=page_so_far[0]-h;
mem[r+3].int:=mem[r+3].int+mem[p+3].int;
end else{1010:}begin if eqtb[5318+n].int<=0 then w:=1073741823 else
begin w:=page_so_far[0]-page_so_far[1]-page_so_far[7];
if eqtb[5318+n].int<>1000 then w:=x_over_n(w,eqtb[5318+n].int)*1000;end;
if w>eqtb[5851+n].int-mem[r+3].int then w:=eqtb[5851+n].int-mem[r+3].int
;q:=vert_break(mem[p+4].hh.lh,w,mem[p+2].int);
mem[r+3].int:=mem[r+3].int+best_height_plus_depth;
{if eqtb[5296].int>0 then[1011:]begin begin_diagnostic;print_nl(1000);
print_int(n);print(1001);print_scaled(w);print_char(44);
print_scaled(best_height_plus_depth);print(930);
if q=0 then print_int(-10000)else if mem[q].hh.b0=12 then print_int(mem[
q+1].int)else print_char(48);end_diagnostic(false);end[:1011];}
if eqtb[5318+n].int<>1000 then best_height_plus_depth:=x_over_n(
best_height_plus_depth,1000)*eqtb[5318+n].int;
page_so_far[0]:=page_so_far[0]-best_height_plus_depth;mem[r].hh.b0:=1;
mem[r+1].hh.rh:=q;mem[r+1].hh.lh:=p;
if q=0 then insert_penalties:=insert_penalties-10000 else if mem[q].hh.
b0=12 then insert_penalties:=insert_penalties+mem[q+1].int;end{:1010};
end;goto 80;end{:1008};others:confusion(992)end{:1000};
{1005:}if pi<10000 then begin{1007:}if page_so_far[1]<page_so_far[0]then
if(page_so_far[3]<>0)or(page_so_far[4]<>0)or(page_so_far[5]<>0)then b:=0
else b:=badness(page_so_far[0]-page_so_far[1],page_so_far[2])else if
page_so_far[1]-page_so_far[0]>page_so_far[6]then b:=1073741823 else b:=
badness(page_so_far[1]-page_so_far[0],page_so_far[6]){:1007};
if b<1073741823 then if pi<=-10000 then c:=pi else if b<10000 then c:=b+
pi+insert_penalties else c:=100000 else c:=b;
if insert_penalties>=10000 then c:=1073741823;
{if eqtb[5296].int>0 then[1006:]begin begin_diagnostic;print_nl(37);
print(926);print_totals;print(995);print_scaled(page_so_far[0]);
print(929);if b=1073741823 then print_char(42)else print_int(b);
print(930);print_int(pi);print(996);
if c=1073741823 then print_char(42)else print_int(c);
if c<=least_page_cost then print_char(35);end_diagnostic(false);
end[:1006];}if c<=least_page_cost then begin best_page_break:=p;
best_size:=page_so_far[0];least_page_cost:=c;r:=mem[30000].hh.rh;
while r<>30000 do begin mem[r+2].hh.lh:=mem[r+2].hh.rh;r:=mem[r].hh.rh;
end;end;if(c=1073741823)or(pi<=-10000)then begin fire_up(p);
if output_active then goto 10;goto 30;end;end{:1005};
if(mem[p].hh.b0<10)or(mem[p].hh.b0>11)then goto 80;
90:{1004:}if mem[p].hh.b0=11 then q:=p else begin q:=mem[p+1].hh.lh;
page_so_far[2+mem[q].hh.b0]:=page_so_far[2+mem[q].hh.b0]+mem[q+2].int;
page_so_far[6]:=page_so_far[6]+mem[q+3].int;
if(mem[q].hh.b1<>0)and(mem[q+3].int<>0)then begin begin if interaction=3
then;print_nl(262);print(993);end;begin help_ptr:=4;help_line[3]:=994;
help_line[2]:=962;help_line[1]:=963;help_line[0]:=921;end;error;
r:=new_spec(q);mem[r].hh.b1:=0;delete_glue_ref(q);mem[p+1].hh.lh:=r;
q:=r;end;end;page_so_far[1]:=page_so_far[1]+page_so_far[7]+mem[q+1].int;
page_so_far[7]:=0{:1004};
80:{1003:}if page_so_far[7]>page_max_depth then begin page_so_far[1]:=
page_so_far[1]+page_so_far[7]-page_max_depth;
page_so_far[7]:=page_max_depth;end;{:1003};
{998:}mem[page_tail].hh.rh:=p;page_tail:=p;
mem[29999].hh.rh:=mem[p].hh.rh;mem[p].hh.rh:=0;goto 30{:998};
31:{999:}mem[29999].hh.rh:=mem[p].hh.rh;mem[p].hh.rh:=0;
flush_node_list(p){:999};30:{:997};until mem[29999].hh.rh=0;
{995:}if nest_ptr=0 then cur_list.tail_field:=29999 else nest[0].
tail_field:=29999{:995};10:end;{:994}{1030:}{1043:}procedure app_space;
var q:halfword;
begin if(cur_list.aux_field.hh.lh>=2000)and(eqtb[2895].hh.rh<>0)then q:=
new_param_glue(13)else begin if eqtb[2894].hh.rh<>0 then main_p:=eqtb[
2894].hh.rh else{1042:}begin main_p:=font_glue[eqtb[3934].hh.rh];
if main_p=0 then begin main_p:=new_spec(0);
main_k:=param_base[eqtb[3934].hh.rh]+2;
mem[main_p+1].int:=font_info[main_k].int;
mem[main_p+2].int:=font_info[main_k+1].int;
mem[main_p+3].int:=font_info[main_k+2].int;
font_glue[eqtb[3934].hh.rh]:=main_p;end;end{:1042};
main_p:=new_spec(main_p);
{1044:}if cur_list.aux_field.hh.lh>=2000 then mem[main_p+1].int:=mem[
main_p+1].int+font_info[7+param_base[eqtb[3934].hh.rh]].int;
mem[main_p+2].int:=xn_over_d(mem[main_p+2].int,cur_list.aux_field.hh.lh,
1000);
mem[main_p+3].int:=xn_over_d(mem[main_p+3].int,1000,cur_list.aux_field.
hh.lh){:1044};q:=new_glue(main_p);mem[main_p].hh.rh:=0;end;
mem[cur_list.tail_field].hh.rh:=q;cur_list.tail_field:=q;end;
{:1043}{1047:}procedure insert_dollar_sign;begin back_input;
cur_tok:=804;begin if interaction=3 then;print_nl(262);print(1016);end;
begin help_ptr:=2;help_line[1]:=1017;help_line[0]:=1018;end;ins_error;
end;{:1047}{1049:}procedure you_cant;begin begin if interaction=3 then;
print_nl(262);print(685);end;print_cmd_chr(cur_cmd,cur_chr);print(1019);
print_mode(cur_list.mode_field);end;
{:1049}{1050:}procedure report_illegal_case;begin you_cant;
begin help_ptr:=4;help_line[3]:=1020;help_line[2]:=1021;
help_line[1]:=1022;help_line[0]:=1023;end;error;end;
{:1050}{1051:}function privileged:boolean;
begin if cur_list.mode_field>0 then privileged:=true else begin
report_illegal_case;privileged:=false;end;end;
{:1051}{1054:}function its_all_over:boolean;label 10;
begin if privileged then begin if(29998=page_tail)and(cur_list.
head_field=cur_list.tail_field)and(dead_cycles=0)then begin its_all_over
:=true;goto 10;end;back_input;
begin mem[cur_list.tail_field].hh.rh:=new_null_box;
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field+1].int:=eqtb[5833].int;
begin mem[cur_list.tail_field].hh.rh:=new_glue(8);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
begin mem[cur_list.tail_field].hh.rh:=new_penalty(-1073741824);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;build_page;end;
its_all_over:=false;10:end;{:1054}{1060:}procedure append_glue;
var s:small_number;begin s:=cur_chr;case s of 0:cur_val:=4;1:cur_val:=8;
2:cur_val:=12;3:cur_val:=16;4:scan_glue(2);5:scan_glue(3);end;
begin mem[cur_list.tail_field].hh.rh:=new_glue(cur_val);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
if s>=4 then begin mem[cur_val].hh.rh:=mem[cur_val].hh.rh-1;
if s>4 then mem[cur_list.tail_field].hh.b1:=99;end;end;
{:1060}{1061:}procedure append_kern;var s:quarterword;begin s:=cur_chr;
scan_dimen(s=99,false,false);
begin mem[cur_list.tail_field].hh.rh:=new_kern(cur_val);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b1:=s;end;{:1061}{1064:}procedure off_save;
var p:halfword;
begin if cur_group=0 then{1066:}begin begin if interaction=3 then;
print_nl(262);print(776);end;print_cmd_chr(cur_cmd,cur_chr);
begin help_ptr:=1;help_line[0]:=1042;end;error;
end{:1066}else begin back_input;p:=get_avail;mem[29997].hh.rh:=p;
begin if interaction=3 then;print_nl(262);print(625);end;
{1065:}case cur_group of 14:begin mem[p].hh.lh:=6711;print_esc(516);end;
15:begin mem[p].hh.lh:=804;print_char(36);end;
16:begin mem[p].hh.lh:=6712;mem[p].hh.rh:=get_avail;p:=mem[p].hh.rh;
mem[p].hh.lh:=3118;print_esc(1041);end;others:begin mem[p].hh.lh:=637;
print_char(125);end end{:1065};print(626);
begin_token_list(mem[29997].hh.rh,4);begin help_ptr:=5;
help_line[4]:=1036;help_line[3]:=1037;help_line[2]:=1038;
help_line[1]:=1039;help_line[0]:=1040;end;error;end;end;
{:1064}{1069:}procedure extra_right_brace;
begin begin if interaction=3 then;print_nl(262);print(1047);end;
case cur_group of 14:print_esc(516);15:print_char(36);16:print_esc(876);
end;begin help_ptr:=5;help_line[4]:=1048;help_line[3]:=1049;
help_line[2]:=1050;help_line[1]:=1051;help_line[0]:=1052;end;error;
align_state:=align_state+1;end;{:1069}{1070:}procedure normal_paragraph;
begin if eqtb[5282].int<>0 then eq_word_define(5282,0);
if eqtb[5847].int<>0 then eq_word_define(5847,0);
if eqtb[5304].int<>1 then eq_word_define(5304,1);
if eqtb[3412].hh.rh<>0 then eq_define(3412,118,0);end;
{:1070}{1075:}procedure box_end(box_context:integer);var p:halfword;
begin if box_context<1073741824 then{1076:}begin if cur_box<>0 then
begin mem[cur_box+4].int:=box_context;
if abs(cur_list.mode_field)=1 then begin append_to_vlist(cur_box);
if adjust_tail<>0 then begin if 29995<>adjust_tail then begin mem[
cur_list.tail_field].hh.rh:=mem[29995].hh.rh;
cur_list.tail_field:=adjust_tail;end;adjust_tail:=0;end;
if cur_list.mode_field>0 then build_page;
end else begin if abs(cur_list.mode_field)=102 then cur_list.aux_field.
hh.lh:=1000 else begin p:=new_noad;mem[p+1].hh.rh:=2;
mem[p+1].hh.lh:=cur_box;cur_box:=p;end;
mem[cur_list.tail_field].hh.rh:=cur_box;cur_list.tail_field:=cur_box;
end;end;
end{:1076}else if box_context<1073742336 then{1077:}if box_context<
1073742080 then eq_define(-1073738146+box_context,119,cur_box)else
geq_define(-1073738402+box_context,119,cur_box){:1077}else if cur_box<>0
then if box_context>1073742336 then{1078:}begin{404:}repeat get_x_token;
until(cur_cmd<>10)and(cur_cmd<>0){:404};
if((cur_cmd=26)and(abs(cur_list.mode_field)<>1))or((cur_cmd=27)and(abs(
cur_list.mode_field)=1))then begin append_glue;
mem[cur_list.tail_field].hh.b1:=box_context-(1073742237);
mem[cur_list.tail_field+1].hh.rh:=cur_box;
end else begin begin if interaction=3 then;print_nl(262);print(1065);
end;begin help_ptr:=3;help_line[2]:=1066;help_line[1]:=1067;
help_line[0]:=1068;end;back_error;flush_node_list(cur_box);end;
end{:1078}else ship_out(cur_box);end;
{:1075}{1079:}procedure begin_box(box_context:integer);label 10,30;
var p,q:halfword;m:quarterword;k:halfword;n:eight_bits;
begin case cur_chr of 0:begin scan_eight_bit_int;
cur_box:=eqtb[3678+cur_val].hh.rh;eqtb[3678+cur_val].hh.rh:=0;end;
1:begin scan_eight_bit_int;
cur_box:=copy_node_list(eqtb[3678+cur_val].hh.rh);end;
2:{1080:}begin cur_box:=0;
if abs(cur_list.mode_field)=203 then begin you_cant;begin help_ptr:=1;
help_line[0]:=1069;end;error;
end else if(cur_list.mode_field=1)and(cur_list.head_field=cur_list.
tail_field)then begin you_cant;begin help_ptr:=2;help_line[1]:=1070;
help_line[0]:=1071;end;error;
end else begin if not(cur_list.tail_field>=hi_mem_min)then if(mem[
cur_list.tail_field].hh.b0=0)or(mem[cur_list.tail_field].hh.b0=1)then
{1081:}begin q:=cur_list.head_field;repeat p:=q;
if not(q>=hi_mem_min)then if mem[q].hh.b0=7 then begin for m:=1 to mem[q
].hh.b1 do p:=mem[p].hh.rh;if p=cur_list.tail_field then goto 30;end;
q:=mem[p].hh.rh;until q=cur_list.tail_field;
cur_box:=cur_list.tail_field;mem[cur_box+4].int:=0;
cur_list.tail_field:=p;mem[p].hh.rh:=0;30:end{:1081};end;end{:1080};
3:{1082:}begin scan_eight_bit_int;n:=cur_val;
if not scan_keyword(841)then begin begin if interaction=3 then;
print_nl(262);print(1072);end;begin help_ptr:=2;help_line[1]:=1073;
help_line[0]:=1074;end;error;end;scan_dimen(false,false,false);
cur_box:=vsplit(n,cur_val);end{:1082};others:{1083:}begin k:=cur_chr-4;
save_stack[save_ptr+0].int:=box_context;
if k=102 then if(box_context<1073741824)and(abs(cur_list.mode_field)=1)
then scan_spec(3,true)else scan_spec(2,true)else begin if k=1 then
scan_spec(4,true)else begin scan_spec(5,true);k:=1;end;normal_paragraph;
end;push_nest;cur_list.mode_field:=-k;
if k=1 then begin cur_list.aux_field.int:=-65536000;
if eqtb[3418].hh.rh<>0 then begin_token_list(eqtb[3418].hh.rh,11);
end else begin cur_list.aux_field.hh.lh:=1000;
if eqtb[3417].hh.rh<>0 then begin_token_list(eqtb[3417].hh.rh,10);end;
goto 10;end{:1083}end;box_end(box_context);10:end;
{:1079}{1084:}procedure scan_box(box_context:integer);
begin{404:}repeat get_x_token;until(cur_cmd<>10)and(cur_cmd<>0){:404};
if cur_cmd=20 then begin_box(box_context)else if(box_context>=1073742337
)and((cur_cmd=36)or(cur_cmd=35))then begin cur_box:=scan_rule_spec;
box_end(box_context);end else begin begin if interaction=3 then;
print_nl(262);print(1075);end;begin help_ptr:=3;help_line[2]:=1076;
help_line[1]:=1077;help_line[0]:=1078;end;back_error;end;end;
{:1084}{1086:}procedure package(c:small_number);var h:scaled;p:halfword;
d:scaled;begin d:=eqtb[5837].int;unsave;save_ptr:=save_ptr-3;
if cur_list.mode_field=-102 then cur_box:=hpack(mem[cur_list.head_field]
.hh.rh,save_stack[save_ptr+2].int,save_stack[save_ptr+1].int)else begin
cur_box:=vpackage(mem[cur_list.head_field].hh.rh,save_stack[save_ptr+2].
int,save_stack[save_ptr+1].int,d);if c=4 then{1087:}begin h:=0;
p:=mem[cur_box+5].hh.rh;
if p<>0 then if mem[p].hh.b0<=2 then h:=mem[p+3].int;
mem[cur_box+2].int:=mem[cur_box+2].int-h+mem[cur_box+3].int;
mem[cur_box+3].int:=h;end{:1087};end;pop_nest;
box_end(save_stack[save_ptr+0].int);end;
{:1086}{1091:}function norm_min(h:integer):small_number;
begin if h<=0 then norm_min:=1 else if h>=63 then norm_min:=63 else
norm_min:=h;end;procedure new_graf(indented:boolean);
begin cur_list.pg_field:=0;
if(cur_list.mode_field=1)or(cur_list.head_field<>cur_list.tail_field)
then begin mem[cur_list.tail_field].hh.rh:=new_param_glue(2);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;push_nest;
cur_list.mode_field:=102;cur_list.aux_field.hh.lh:=1000;
if eqtb[5313].int<=0 then cur_lang:=0 else if eqtb[5313].int>255 then
cur_lang:=0 else cur_lang:=eqtb[5313].int;
cur_list.aux_field.hh.rh:=cur_lang;
cur_list.pg_field:=(norm_min(eqtb[5314].int)*64+norm_min(eqtb[5315].int)
)*65536+cur_lang;
if indented then begin cur_list.tail_field:=new_null_box;
mem[cur_list.head_field].hh.rh:=cur_list.tail_field;
mem[cur_list.tail_field+1].int:=eqtb[5830].int;end;
if eqtb[3414].hh.rh<>0 then begin_token_list(eqtb[3414].hh.rh,7);
if nest_ptr=1 then build_page;end;
{:1091}{1093:}procedure indent_in_hmode;var p,q:halfword;
begin if cur_chr>0 then begin p:=new_null_box;
mem[p+1].int:=eqtb[5830].int;
if abs(cur_list.mode_field)=102 then cur_list.aux_field.hh.lh:=1000 else
begin q:=new_noad;mem[q+1].hh.rh:=2;mem[q+1].hh.lh:=p;p:=q;end;
begin mem[cur_list.tail_field].hh.rh:=p;
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;end;end;
{:1093}{1095:}procedure head_for_vmode;
begin if cur_list.mode_field<0 then if cur_cmd<>36 then off_save else
begin begin if interaction=3 then;print_nl(262);print(685);end;
print_esc(521);print(1081);begin help_ptr:=2;help_line[1]:=1082;
help_line[0]:=1083;end;error;end else begin back_input;
cur_tok:=par_token;back_input;cur_input.index_field:=4;end;end;
{:1095}{1096:}procedure end_graf;
begin if cur_list.mode_field=102 then begin if cur_list.head_field=
cur_list.tail_field then pop_nest else line_break(eqtb[5269].int);
normal_paragraph;error_count:=0;end;end;
{:1096}{1099:}procedure begin_insert_or_adjust;
begin if cur_cmd=38 then cur_val:=255 else begin scan_eight_bit_int;
if cur_val=255 then begin begin if interaction=3 then;print_nl(262);
print(1084);end;print_esc(330);print_int(255);begin help_ptr:=1;
help_line[0]:=1085;end;error;cur_val:=0;end;end;
save_stack[save_ptr+0].int:=cur_val;save_ptr:=save_ptr+1;
new_save_level(11);scan_left_brace;normal_paragraph;push_nest;
cur_list.mode_field:=-1;cur_list.aux_field.int:=-65536000;end;
{:1099}{1101:}procedure make_mark;var p:halfword;
begin p:=scan_toks(false,true);p:=get_node(2);mem[p].hh.b0:=4;
mem[p].hh.b1:=0;mem[p+1].int:=def_ref;mem[cur_list.tail_field].hh.rh:=p;
cur_list.tail_field:=p;end;{:1101}{1103:}procedure append_penalty;
begin scan_int;
begin mem[cur_list.tail_field].hh.rh:=new_penalty(cur_val);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
if cur_list.mode_field=1 then build_page;end;
{:1103}{1105:}procedure delete_last;label 10;var p,q:halfword;
m:quarterword;
begin if(cur_list.mode_field=1)and(cur_list.tail_field=cur_list.
head_field)then{1106:}begin if(cur_chr<>10)or(last_glue<>65535)then
begin you_cant;begin help_ptr:=2;help_line[1]:=1070;help_line[0]:=1086;
end;if cur_chr=11 then help_line[0]:=(1087)else if cur_chr<>10 then
help_line[0]:=(1088);error;end;
end{:1106}else begin if not(cur_list.tail_field>=hi_mem_min)then if mem[
cur_list.tail_field].hh.b0=cur_chr then begin q:=cur_list.head_field;
repeat p:=q;
if not(q>=hi_mem_min)then if mem[q].hh.b0=7 then begin for m:=1 to mem[q
].hh.b1 do p:=mem[p].hh.rh;if p=cur_list.tail_field then goto 10;end;
q:=mem[p].hh.rh;until q=cur_list.tail_field;mem[p].hh.rh:=0;
flush_node_list(cur_list.tail_field);cur_list.tail_field:=p;end;end;
10:end;{:1105}{1110:}procedure unpackage;label 10;var p:halfword;c:0..1;
begin c:=cur_chr;scan_eight_bit_int;p:=eqtb[3678+cur_val].hh.rh;
if p=0 then goto 10;
if(abs(cur_list.mode_field)=203)or((abs(cur_list.mode_field)=1)and(mem[p
].hh.b0<>1))or((abs(cur_list.mode_field)=102)and(mem[p].hh.b0<>0))then
begin begin if interaction=3 then;print_nl(262);print(1096);end;
begin help_ptr:=3;help_line[2]:=1097;help_line[1]:=1098;
help_line[0]:=1099;end;error;goto 10;end;
if c=1 then mem[cur_list.tail_field].hh.rh:=copy_node_list(mem[p+5].hh.
rh)else begin mem[cur_list.tail_field].hh.rh:=mem[p+5].hh.rh;
eqtb[3678+cur_val].hh.rh:=0;free_node(p,7);end;
while mem[cur_list.tail_field].hh.rh<>0 do cur_list.tail_field:=mem[
cur_list.tail_field].hh.rh;10:end;
{:1110}{1113:}procedure append_italic_correction;label 10;
var p:halfword;f:internal_font_number;
begin if cur_list.tail_field<>cur_list.head_field then begin if(cur_list
.tail_field>=hi_mem_min)then p:=cur_list.tail_field else if mem[cur_list
.tail_field].hh.b0=6 then p:=cur_list.tail_field+1 else goto 10;
f:=mem[p].hh.b0;
begin mem[cur_list.tail_field].hh.rh:=new_kern(font_info[italic_base[f]+
(font_info[char_base[f]+mem[p].hh.b1].qqqq.b2-0)div 4].int);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b1:=1;end;10:end;
{:1113}{1117:}procedure append_discretionary;var c:integer;
begin begin mem[cur_list.tail_field].hh.rh:=new_disc;
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
if cur_chr=1 then begin c:=hyphen_char[eqtb[3934].hh.rh];
if c>=0 then if c<256 then mem[cur_list.tail_field+1].hh.lh:=
new_character(eqtb[3934].hh.rh,c);end else begin save_ptr:=save_ptr+1;
save_stack[save_ptr-1].int:=0;new_save_level(10);scan_left_brace;
push_nest;cur_list.mode_field:=-102;cur_list.aux_field.hh.lh:=1000;end;
end;{:1117}{1119:}procedure build_discretionary;label 30,10;
var p,q:halfword;n:integer;begin unsave;{1121:}q:=cur_list.head_field;
p:=mem[q].hh.rh;n:=0;
while p<>0 do begin if not(p>=hi_mem_min)then if mem[p].hh.b0>2 then if
mem[p].hh.b0<>11 then if mem[p].hh.b0<>6 then begin begin if interaction
=3 then;print_nl(262);print(1106);end;begin help_ptr:=1;
help_line[0]:=1107;end;error;begin_diagnostic;print_nl(1108);
show_box(p);end_diagnostic(true);flush_node_list(p);mem[q].hh.rh:=0;
goto 30;end;q:=p;p:=mem[q].hh.rh;n:=n+1;end;30:{:1121};
p:=mem[cur_list.head_field].hh.rh;pop_nest;
case save_stack[save_ptr-1].int of 0:mem[cur_list.tail_field+1].hh.lh:=p
;1:mem[cur_list.tail_field+1].hh.rh:=p;
2:{1120:}begin if(n>0)and(abs(cur_list.mode_field)=203)then begin begin
if interaction=3 then;print_nl(262);print(1100);end;print_esc(349);
begin help_ptr:=2;help_line[1]:=1101;help_line[0]:=1102;end;
flush_node_list(p);n:=0;error;
end else mem[cur_list.tail_field].hh.rh:=p;
if n<=255 then mem[cur_list.tail_field].hh.b1:=n else begin begin if
interaction=3 then;print_nl(262);print(1103);end;begin help_ptr:=2;
help_line[1]:=1104;help_line[0]:=1105;end;error;end;
if n>0 then cur_list.tail_field:=q;save_ptr:=save_ptr-1;goto 10;
end{:1120};end;save_stack[save_ptr-1].int:=save_stack[save_ptr-1].int+1;
new_save_level(10);scan_left_brace;push_nest;cur_list.mode_field:=-102;
cur_list.aux_field.hh.lh:=1000;10:end;
{:1119}{1123:}procedure make_accent;var s,t:real;p,q,r:halfword;
f:internal_font_number;a,h,x,w,delta:scaled;i:four_quarters;
begin scan_char_num;f:=eqtb[3934].hh.rh;p:=new_character(f,cur_val);
if p<>0 then begin x:=font_info[5+param_base[f]].int;
s:=font_info[1+param_base[f]].int/65536.0;
a:=font_info[width_base[f]+font_info[char_base[f]+mem[p].hh.b1].qqqq.b0]
.int;do_assignments;{1124:}q:=0;f:=eqtb[3934].hh.rh;
if(cur_cmd=11)or(cur_cmd=12)or(cur_cmd=68)then q:=new_character(f,
cur_chr)else if cur_cmd=16 then begin scan_char_num;
q:=new_character(f,cur_val);end else back_input{:1124};
if q<>0 then{1125:}begin t:=font_info[1+param_base[f]].int/65536.0;
i:=font_info[char_base[f]+mem[q].hh.b1].qqqq;
w:=font_info[width_base[f]+i.b0].int;
h:=font_info[height_base[f]+(i.b1-0)div 16].int;
if h<>x then begin p:=hpack(p,0,1);mem[p+4].int:=x-h;end;
delta:=round((w-a)/2.0+h*t-x*s);r:=new_kern(delta);mem[r].hh.b1:=2;
mem[cur_list.tail_field].hh.rh:=r;mem[r].hh.rh:=p;
cur_list.tail_field:=new_kern(-a-delta);
mem[cur_list.tail_field].hh.b1:=2;mem[p].hh.rh:=cur_list.tail_field;
p:=q;end{:1125};mem[cur_list.tail_field].hh.rh:=p;
cur_list.tail_field:=p;cur_list.aux_field.hh.lh:=1000;end;end;
{:1123}{1127:}procedure align_error;
begin if abs(align_state)>2 then{1128:}begin begin if interaction=3 then
;print_nl(262);print(1113);end;print_cmd_chr(cur_cmd,cur_chr);
if cur_tok=1062 then begin begin help_ptr:=6;help_line[5]:=1114;
help_line[4]:=1115;help_line[3]:=1116;help_line[2]:=1117;
help_line[1]:=1118;help_line[0]:=1119;end;
end else begin begin help_ptr:=5;help_line[4]:=1114;help_line[3]:=1120;
help_line[2]:=1117;help_line[1]:=1118;help_line[0]:=1119;end;end;error;
end{:1128}else begin back_input;
if align_state<0 then begin begin if interaction=3 then;print_nl(262);
print(657);end;align_state:=align_state+1;cur_tok:=379;
end else begin begin if interaction=3 then;print_nl(262);print(1109);
end;align_state:=align_state-1;cur_tok:=637;end;begin help_ptr:=3;
help_line[2]:=1110;help_line[1]:=1111;help_line[0]:=1112;end;ins_error;
end;end;{:1127}{1129:}procedure no_align_error;
begin begin if interaction=3 then;print_nl(262);print(1113);end;
print_esc(527);begin help_ptr:=2;help_line[1]:=1121;help_line[0]:=1122;
end;error;end;procedure omit_error;begin begin if interaction=3 then;
print_nl(262);print(1113);end;print_esc(530);begin help_ptr:=2;
help_line[1]:=1123;help_line[0]:=1122;end;error;end;
{:1129}{1131:}procedure do_endv;begin base_ptr:=input_ptr;
input_stack[base_ptr]:=cur_input;
while(input_stack[base_ptr].index_field<>2)and(input_stack[base_ptr].
loc_field=0)and(input_stack[base_ptr].state_field=0)do base_ptr:=
base_ptr-1;
if(input_stack[base_ptr].index_field<>2)or(input_stack[base_ptr].
loc_field<>0)or(input_stack[base_ptr].state_field<>0)then fatal_error(
595);if cur_group=6 then begin end_graf;if fin_col then fin_row;
end else off_save;end;{:1131}{1135:}procedure cs_error;
begin begin if interaction=3 then;print_nl(262);print(776);end;
print_esc(505);begin help_ptr:=1;help_line[0]:=1125;end;error;end;
{:1135}{1136:}procedure push_math(c:group_code);begin push_nest;
cur_list.mode_field:=-203;cur_list.aux_field.int:=0;new_save_level(c);
end;{:1136}{1138:}procedure init_math;label 21,40,45,30;var w:scaled;
l:scaled;s:scaled;p:halfword;q:halfword;f:internal_font_number;
n:integer;v:scaled;d:scaled;begin get_token;
if(cur_cmd=3)and(cur_list.mode_field>0)then{1145:}begin if cur_list.
head_field=cur_list.tail_field then begin pop_nest;w:=-1073741823;
end else begin line_break(eqtb[5270].int);
{1146:}v:=mem[just_box+4].int+2*font_info[6+param_base[eqtb[3934].hh.rh]
].int;w:=-1073741823;p:=mem[just_box+5].hh.rh;
while p<>0 do begin{1147:}21:if(p>=hi_mem_min)then begin f:=mem[p].hh.b0
;
d:=font_info[width_base[f]+font_info[char_base[f]+mem[p].hh.b1].qqqq.b0]
.int;goto 40;end;case mem[p].hh.b0 of 0,1,2:begin d:=mem[p+1].int;
goto 40;end;6:{652:}begin mem[29988]:=mem[p+1];
mem[29988].hh.rh:=mem[p].hh.rh;p:=29988;goto 21;end{:652};
11,9:d:=mem[p+1].int;10:{1148:}begin q:=mem[p+1].hh.lh;d:=mem[q+1].int;
if mem[just_box+5].hh.b0=1 then begin if(mem[just_box+5].hh.b1=mem[q].hh
.b0)and(mem[q+2].int<>0)then v:=1073741823;
end else if mem[just_box+5].hh.b0=2 then begin if(mem[just_box+5].hh.b1=
mem[q].hh.b1)and(mem[q+3].int<>0)then v:=1073741823;end;
if mem[p].hh.b1>=100 then goto 40;end{:1148};8:{1361:}d:=0{:1361};
others:d:=0 end{:1147};if v<1073741823 then v:=v+d;goto 45;
40:if v<1073741823 then begin v:=v+d;w:=v;end else begin w:=1073741823;
goto 30;end;45:p:=mem[p].hh.rh;end;30:{:1146};end;
{1149:}if eqtb[3412].hh.rh=0 then if(eqtb[5847].int<>0)and(((eqtb[5304].
int>=0)and(cur_list.pg_field+2>eqtb[5304].int))or(cur_list.pg_field+1<-
eqtb[5304].int))then begin l:=eqtb[5833].int-abs(eqtb[5847].int);
if eqtb[5847].int>0 then s:=eqtb[5847].int else s:=0;
end else begin l:=eqtb[5833].int;s:=0;
end else begin n:=mem[eqtb[3412].hh.rh].hh.lh;
if cur_list.pg_field+2>=n then p:=eqtb[3412].hh.rh+2*n else p:=eqtb[3412
].hh.rh+2*(cur_list.pg_field+2);s:=mem[p-1].int;l:=mem[p].int;
end{:1149};push_math(15);cur_list.mode_field:=203;
eq_word_define(5307,-1);eq_word_define(5843,w);eq_word_define(5844,l);
eq_word_define(5845,s);
if eqtb[3416].hh.rh<>0 then begin_token_list(eqtb[3416].hh.rh,9);
if nest_ptr=1 then build_page;end{:1145}else begin back_input;
{1139:}begin push_math(15);eq_word_define(5307,-1);
if eqtb[3415].hh.rh<>0 then begin_token_list(eqtb[3415].hh.rh,8);
end{:1139};end;end;{:1138}{1142:}procedure start_eq_no;
begin save_stack[save_ptr+0].int:=cur_chr;save_ptr:=save_ptr+1;
{1139:}begin push_math(15);eq_word_define(5307,-1);
if eqtb[3415].hh.rh<>0 then begin_token_list(eqtb[3415].hh.rh,8);
end{:1139};end;{:1142}{1151:}procedure scan_math(p:halfword);
label 20,21,10;var c:integer;begin 20:{404:}repeat get_x_token;
until(cur_cmd<>10)and(cur_cmd<>0){:404};
21:case cur_cmd of 11,12,68:begin c:=eqtb[5007+cur_chr].hh.rh-0;
if c=32768 then begin{1152:}begin cur_cs:=cur_chr+1;
cur_cmd:=eqtb[cur_cs].hh.b0;cur_chr:=eqtb[cur_cs].hh.rh;x_token;
back_input;end{:1152};goto 20;end;end;16:begin scan_char_num;
cur_chr:=cur_val;cur_cmd:=68;goto 21;end;17:begin scan_fifteen_bit_int;
c:=cur_val;end;69:c:=cur_chr;15:begin scan_twenty_seven_bit_int;
c:=cur_val div 4096;end;others:{1153:}begin back_input;scan_left_brace;
save_stack[save_ptr+0].int:=p;save_ptr:=save_ptr+1;push_math(9);goto 10;
end{:1153}end;mem[p].hh.rh:=1;mem[p].hh.b1:=c mod 256+0;
if(c>=28672)and((eqtb[5307].int>=0)and(eqtb[5307].int<16))then mem[p].hh
.b0:=eqtb[5307].int else mem[p].hh.b0:=(c div 256)mod 16;10:end;
{:1151}{1155:}procedure set_math_char(c:integer);var p:halfword;
begin if c>=32768 then{1152:}begin cur_cs:=cur_chr+1;
cur_cmd:=eqtb[cur_cs].hh.b0;cur_chr:=eqtb[cur_cs].hh.rh;x_token;
back_input;end{:1152}else begin p:=new_noad;mem[p+1].hh.rh:=1;
mem[p+1].hh.b1:=c mod 256+0;mem[p+1].hh.b0:=(c div 256)mod 16;
if c>=28672 then begin if((eqtb[5307].int>=0)and(eqtb[5307].int<16))then
mem[p+1].hh.b0:=eqtb[5307].int;mem[p].hh.b0:=16;
end else mem[p].hh.b0:=16+(c div 4096);
mem[cur_list.tail_field].hh.rh:=p;cur_list.tail_field:=p;end;end;
{:1155}{1159:}procedure math_limit_switch;label 10;
begin if cur_list.head_field<>cur_list.tail_field then if mem[cur_list.
tail_field].hh.b0=17 then begin mem[cur_list.tail_field].hh.b1:=cur_chr;
goto 10;end;begin if interaction=3 then;print_nl(262);print(1129);end;
begin help_ptr:=1;help_line[0]:=1130;end;error;10:end;
{:1159}{1160:}procedure scan_delimiter(p:halfword;r:boolean);
begin if r then scan_twenty_seven_bit_int else begin{404:}repeat
get_x_token;until(cur_cmd<>10)and(cur_cmd<>0){:404};
case cur_cmd of 11,12:cur_val:=eqtb[5574+cur_chr].int;
15:scan_twenty_seven_bit_int;others:cur_val:=-1 end;end;
if cur_val<0 then{1161:}begin begin if interaction=3 then;print_nl(262);
print(1131);end;begin help_ptr:=6;help_line[5]:=1132;help_line[4]:=1133;
help_line[3]:=1134;help_line[2]:=1135;help_line[1]:=1136;
help_line[0]:=1137;end;back_error;cur_val:=0;end{:1161};
mem[p].qqqq.b0:=(cur_val div 1048576)mod 16;
mem[p].qqqq.b1:=(cur_val div 4096)mod 256+0;
mem[p].qqqq.b2:=(cur_val div 256)mod 16;
mem[p].qqqq.b3:=cur_val mod 256+0;end;
{:1160}{1163:}procedure math_radical;
begin begin mem[cur_list.tail_field].hh.rh:=get_node(5);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b0:=24;mem[cur_list.tail_field].hh.b1:=0;
mem[cur_list.tail_field+1].hh:=empty_field;
mem[cur_list.tail_field+3].hh:=empty_field;
mem[cur_list.tail_field+2].hh:=empty_field;
scan_delimiter(cur_list.tail_field+4,true);
scan_math(cur_list.tail_field+1);end;{:1163}{1165:}procedure math_ac;
begin if cur_cmd=45 then{1166:}begin begin if interaction=3 then;
print_nl(262);print(1138);end;print_esc(523);print(1139);
begin help_ptr:=2;help_line[1]:=1140;help_line[0]:=1141;end;error;
end{:1166};begin mem[cur_list.tail_field].hh.rh:=get_node(5);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b0:=28;mem[cur_list.tail_field].hh.b1:=0;
mem[cur_list.tail_field+1].hh:=empty_field;
mem[cur_list.tail_field+3].hh:=empty_field;
mem[cur_list.tail_field+2].hh:=empty_field;
mem[cur_list.tail_field+4].hh.rh:=1;scan_fifteen_bit_int;
mem[cur_list.tail_field+4].hh.b1:=cur_val mod 256+0;
if(cur_val>=28672)and((eqtb[5307].int>=0)and(eqtb[5307].int<16))then mem
[cur_list.tail_field+4].hh.b0:=eqtb[5307].int else mem[cur_list.
tail_field+4].hh.b0:=(cur_val div 256)mod 16;
scan_math(cur_list.tail_field+1);end;
{:1165}{1172:}procedure append_choices;
begin begin mem[cur_list.tail_field].hh.rh:=new_choice;
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
save_ptr:=save_ptr+1;save_stack[save_ptr-1].int:=0;push_math(13);
scan_left_brace;end;
{:1172}{1174:}{1184:}function fin_mlist(p:halfword):halfword;
var q:halfword;
begin if cur_list.aux_field.int<>0 then{1185:}begin mem[cur_list.
aux_field.int+3].hh.rh:=3;
mem[cur_list.aux_field.int+3].hh.lh:=mem[cur_list.head_field].hh.rh;
if p=0 then q:=cur_list.aux_field.int else begin q:=mem[cur_list.
aux_field.int+2].hh.lh;if mem[q].hh.b0<>30 then confusion(876);
mem[cur_list.aux_field.int+2].hh.lh:=mem[q].hh.rh;
mem[q].hh.rh:=cur_list.aux_field.int;
mem[cur_list.aux_field.int].hh.rh:=p;end;
end{:1185}else begin mem[cur_list.tail_field].hh.rh:=p;
q:=mem[cur_list.head_field].hh.rh;end;pop_nest;fin_mlist:=q;end;
{:1184}procedure build_choices;label 10;var p:halfword;begin unsave;
p:=fin_mlist(0);
case save_stack[save_ptr-1].int of 0:mem[cur_list.tail_field+1].hh.lh:=p
;1:mem[cur_list.tail_field+1].hh.rh:=p;
2:mem[cur_list.tail_field+2].hh.lh:=p;
3:begin mem[cur_list.tail_field+2].hh.rh:=p;save_ptr:=save_ptr-1;
goto 10;end;end;
save_stack[save_ptr-1].int:=save_stack[save_ptr-1].int+1;push_math(13);
scan_left_brace;10:end;{:1174}{1176:}procedure sub_sup;
var t:small_number;p:halfword;begin t:=0;p:=0;
if cur_list.tail_field<>cur_list.head_field then if(mem[cur_list.
tail_field].hh.b0>=16)and(mem[cur_list.tail_field].hh.b0<30)then begin p
:=cur_list.tail_field+2+cur_cmd-7;t:=mem[p].hh.rh;end;
if(p=0)or(t<>0)then{1177:}begin begin mem[cur_list.tail_field].hh.rh:=
new_noad;cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
p:=cur_list.tail_field+2+cur_cmd-7;
if t<>0 then begin if cur_cmd=7 then begin begin if interaction=3 then;
print_nl(262);print(1142);end;begin help_ptr:=1;help_line[0]:=1143;end;
end else begin begin if interaction=3 then;print_nl(262);print(1144);
end;begin help_ptr:=1;help_line[0]:=1145;end;end;error;end;end{:1177};
scan_math(p);end;{:1176}{1181:}procedure math_fraction;
var c:small_number;begin c:=cur_chr;
if cur_list.aux_field.int<>0 then{1183:}begin if c>=3 then begin
scan_delimiter(29988,false);scan_delimiter(29988,false);end;
if c mod 3=0 then scan_dimen(false,false,false);
begin if interaction=3 then;print_nl(262);print(1152);end;
begin help_ptr:=3;help_line[2]:=1153;help_line[1]:=1154;
help_line[0]:=1155;end;error;
end{:1183}else begin cur_list.aux_field.int:=get_node(6);
mem[cur_list.aux_field.int].hh.b0:=25;
mem[cur_list.aux_field.int].hh.b1:=0;
mem[cur_list.aux_field.int+2].hh.rh:=3;
mem[cur_list.aux_field.int+2].hh.lh:=mem[cur_list.head_field].hh.rh;
mem[cur_list.aux_field.int+3].hh:=empty_field;
mem[cur_list.aux_field.int+4].qqqq:=null_delimiter;
mem[cur_list.aux_field.int+5].qqqq:=null_delimiter;
mem[cur_list.head_field].hh.rh:=0;
cur_list.tail_field:=cur_list.head_field;
{1182:}if c>=3 then begin scan_delimiter(cur_list.aux_field.int+4,false)
;scan_delimiter(cur_list.aux_field.int+5,false);end;
case c mod 3 of 0:begin scan_dimen(false,false,false);
mem[cur_list.aux_field.int+1].int:=cur_val;end;
1:mem[cur_list.aux_field.int+1].int:=1073741824;
2:mem[cur_list.aux_field.int+1].int:=0;end{:1182};end;end;
{:1181}{1191:}procedure math_left_right;var t:small_number;p:halfword;
begin t:=cur_chr;
if(t=31)and(cur_group<>16)then{1192:}begin if cur_group=15 then begin
scan_delimiter(29988,false);begin if interaction=3 then;print_nl(262);
print(776);end;print_esc(876);begin help_ptr:=1;help_line[0]:=1156;end;
error;end else off_save;end{:1192}else begin p:=new_noad;
mem[p].hh.b0:=t;scan_delimiter(p+1,false);
if t=30 then begin push_math(16);mem[cur_list.head_field].hh.rh:=p;
cur_list.tail_field:=p;end else begin p:=fin_mlist(p);unsave;
begin mem[cur_list.tail_field].hh.rh:=new_noad;
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b0:=23;mem[cur_list.tail_field+1].hh.rh:=3;
mem[cur_list.tail_field+1].hh.lh:=p;end;end;end;
{:1191}{1194:}procedure after_math;var l:boolean;danger:boolean;
m:integer;p:halfword;a:halfword;{1198:}b:halfword;w:scaled;z:scaled;
e:scaled;q:scaled;d:scaled;s:scaled;g1,g2:small_number;r:halfword;
t:halfword;{:1198}begin danger:=false;
{1195:}if(font_params[eqtb[3937].hh.rh]<22)or(font_params[eqtb[3953].hh.
rh]<22)or(font_params[eqtb[3969].hh.rh]<22)then begin begin if
interaction=3 then;print_nl(262);print(1157);end;begin help_ptr:=3;
help_line[2]:=1158;help_line[1]:=1159;help_line[0]:=1160;end;error;
flush_math;danger:=true;
end else if(font_params[eqtb[3938].hh.rh]<13)or(font_params[eqtb[3954].
hh.rh]<13)or(font_params[eqtb[3970].hh.rh]<13)then begin begin if
interaction=3 then;print_nl(262);print(1161);end;begin help_ptr:=3;
help_line[2]:=1162;help_line[1]:=1163;help_line[0]:=1164;end;error;
flush_math;danger:=true;end{:1195};m:=cur_list.mode_field;l:=false;
p:=fin_mlist(0);
if cur_list.mode_field=-m then begin{1197:}begin get_x_token;
if cur_cmd<>3 then begin begin if interaction=3 then;print_nl(262);
print(1165);end;begin help_ptr:=2;help_line[1]:=1166;help_line[0]:=1167;
end;back_error;end;end{:1197};cur_mlist:=p;cur_style:=2;
mlist_penalties:=false;mlist_to_hlist;a:=hpack(mem[29997].hh.rh,0,1);
unsave;save_ptr:=save_ptr-1;
if save_stack[save_ptr+0].int=1 then l:=true;danger:=false;
{1195:}if(font_params[eqtb[3937].hh.rh]<22)or(font_params[eqtb[3953].hh.
rh]<22)or(font_params[eqtb[3969].hh.rh]<22)then begin begin if
interaction=3 then;print_nl(262);print(1157);end;begin help_ptr:=3;
help_line[2]:=1158;help_line[1]:=1159;help_line[0]:=1160;end;error;
flush_math;danger:=true;
end else if(font_params[eqtb[3938].hh.rh]<13)or(font_params[eqtb[3954].
hh.rh]<13)or(font_params[eqtb[3970].hh.rh]<13)then begin begin if
interaction=3 then;print_nl(262);print(1161);end;begin help_ptr:=3;
help_line[2]:=1162;help_line[1]:=1163;help_line[0]:=1164;end;error;
flush_math;danger:=true;end{:1195};m:=cur_list.mode_field;
p:=fin_mlist(0);end else a:=0;
if m<0 then{1196:}begin begin mem[cur_list.tail_field].hh.rh:=new_math(
eqtb[5831].int,0);cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;
end;cur_mlist:=p;cur_style:=2;mlist_penalties:=(cur_list.mode_field>0);
mlist_to_hlist;mem[cur_list.tail_field].hh.rh:=mem[29997].hh.rh;
while mem[cur_list.tail_field].hh.rh<>0 do cur_list.tail_field:=mem[
cur_list.tail_field].hh.rh;
begin mem[cur_list.tail_field].hh.rh:=new_math(eqtb[5831].int,1);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
cur_list.aux_field.hh.lh:=1000;unsave;
end{:1196}else begin if a=0 then{1197:}begin get_x_token;
if cur_cmd<>3 then begin begin if interaction=3 then;print_nl(262);
print(1165);end;begin help_ptr:=2;help_line[1]:=1166;help_line[0]:=1167;
end;back_error;end;end{:1197};{1199:}cur_mlist:=p;cur_style:=0;
mlist_penalties:=false;mlist_to_hlist;p:=mem[29997].hh.rh;
adjust_tail:=29995;b:=hpack(p,0,1);p:=mem[b+5].hh.rh;t:=adjust_tail;
adjust_tail:=0;w:=mem[b+1].int;z:=eqtb[5844].int;s:=eqtb[5845].int;
if(a=0)or danger then begin e:=0;q:=0;end else begin e:=mem[a+1].int;
q:=e+font_info[6+param_base[eqtb[3937].hh.rh]].int;end;
if w+q>z then{1201:}begin if(e<>0)and((w-total_shrink[0]+q<=z)or(
total_shrink[1]<>0)or(total_shrink[2]<>0)or(total_shrink[3]<>0))then
begin free_node(b,7);b:=hpack(p,z-q,0);end else begin e:=0;
if w>z then begin free_node(b,7);b:=hpack(p,z,0);end;end;
w:=mem[b+1].int;end{:1201};{1202:}d:=half(z-w);
if(e>0)and(d<2*e)then begin d:=half(z-w-e);
if p<>0 then if not(p>=hi_mem_min)then if mem[p].hh.b0=10 then d:=0;
end{:1202};
{1203:}begin mem[cur_list.tail_field].hh.rh:=new_penalty(eqtb[5274].int)
;cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
if(d+s<=eqtb[5843].int)or l then begin g1:=3;g2:=4;end else begin g1:=5;
g2:=6;end;if l and(e=0)then begin mem[a+4].int:=s;append_to_vlist(a);
begin mem[cur_list.tail_field].hh.rh:=new_penalty(10000);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
end else begin mem[cur_list.tail_field].hh.rh:=new_param_glue(g1);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end{:1203};
{1204:}if e<>0 then begin r:=new_kern(z-w-e-d);
if l then begin mem[a].hh.rh:=r;mem[r].hh.rh:=b;b:=a;d:=0;
end else begin mem[b].hh.rh:=r;mem[r].hh.rh:=a;end;b:=hpack(b,0,1);end;
mem[b+4].int:=s+d;append_to_vlist(b){:1204};
{1205:}if(a<>0)and(e=0)and not l then begin begin mem[cur_list.
tail_field].hh.rh:=new_penalty(10000);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[a+4].int:=s+z-mem[a+1].int;append_to_vlist(a);g2:=0;end;
if t<>29995 then begin mem[cur_list.tail_field].hh.rh:=mem[29995].hh.rh;
cur_list.tail_field:=t;end;
begin mem[cur_list.tail_field].hh.rh:=new_penalty(eqtb[5275].int);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
if g2>0 then begin mem[cur_list.tail_field].hh.rh:=new_param_glue(g2);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end{:1205};
resume_after_display{:1199};end;end;
{:1194}{1200:}procedure resume_after_display;
begin if cur_group<>15 then confusion(1168);unsave;
cur_list.pg_field:=cur_list.pg_field+3;push_nest;
cur_list.mode_field:=102;cur_list.aux_field.hh.lh:=1000;
if eqtb[5313].int<=0 then cur_lang:=0 else if eqtb[5313].int>255 then
cur_lang:=0 else cur_lang:=eqtb[5313].int;
cur_list.aux_field.hh.rh:=cur_lang;
cur_list.pg_field:=(norm_min(eqtb[5314].int)*64+norm_min(eqtb[5315].int)
)*65536+cur_lang;{443:}begin get_x_token;if cur_cmd<>10 then back_input;
end{:443};if nest_ptr=1 then build_page;end;
{:1200}{1211:}{1215:}procedure get_r_token;label 20;
begin 20:repeat get_token;until cur_tok<>2592;
if(cur_cs=0)or(cur_cs>2614)then begin begin if interaction=3 then;
print_nl(262);print(1183);end;begin help_ptr:=5;help_line[4]:=1184;
help_line[3]:=1185;help_line[2]:=1186;help_line[1]:=1187;
help_line[0]:=1188;end;if cur_cs=0 then back_input;cur_tok:=6709;
ins_error;goto 20;end;end;{:1215}{1229:}procedure trap_zero_glue;
begin if(mem[cur_val+1].int=0)and(mem[cur_val+2].int=0)and(mem[cur_val+3
].int=0)then begin mem[0].hh.rh:=mem[0].hh.rh+1;
delete_glue_ref(cur_val);cur_val:=0;end;end;
{:1229}{1236:}procedure do_register_command(a:small_number);label 40,10;
var l,q,r,s:halfword;p:0..3;begin q:=cur_cmd;
{1237:}begin if q<>89 then begin get_x_token;
if(cur_cmd>=73)and(cur_cmd<=76)then begin l:=cur_chr;p:=cur_cmd-73;
goto 40;end;if cur_cmd<>89 then begin begin if interaction=3 then;
print_nl(262);print(685);end;print_cmd_chr(cur_cmd,cur_chr);print(686);
print_cmd_chr(q,0);begin help_ptr:=1;help_line[0]:=1209;end;error;
goto 10;end;end;p:=cur_chr;scan_eight_bit_int;
case p of 0:l:=cur_val+5318;1:l:=cur_val+5851;2:l:=cur_val+2900;
3:l:=cur_val+3156;end;end;40:{:1237};
if q=89 then scan_optional_equals else if scan_keyword(1205)then;
arith_error:=false;
if q<91 then{1238:}if p<2 then begin if p=0 then scan_int else
scan_dimen(false,false,false);if q=90 then cur_val:=cur_val+eqtb[l].int;
end else begin scan_glue(p);
if q=90 then{1239:}begin q:=new_spec(cur_val);r:=eqtb[l].hh.rh;
delete_glue_ref(cur_val);mem[q+1].int:=mem[q+1].int+mem[r+1].int;
if mem[q+2].int=0 then mem[q].hh.b0:=0;
if mem[q].hh.b0=mem[r].hh.b0 then mem[q+2].int:=mem[q+2].int+mem[r+2].
int else if(mem[q].hh.b0<mem[r].hh.b0)and(mem[r+2].int<>0)then begin mem
[q+2].int:=mem[r+2].int;mem[q].hh.b0:=mem[r].hh.b0;end;
if mem[q+3].int=0 then mem[q].hh.b1:=0;
if mem[q].hh.b1=mem[r].hh.b1 then mem[q+3].int:=mem[q+3].int+mem[r+3].
int else if(mem[q].hh.b1<mem[r].hh.b1)and(mem[r+3].int<>0)then begin mem
[q+3].int:=mem[r+3].int;mem[q].hh.b1:=mem[r].hh.b1;end;cur_val:=q;
end{:1239};end{:1238}else{1240:}begin scan_int;
if p<2 then if q=91 then if p=0 then cur_val:=mult_and_add(eqtb[l].int,
cur_val,0,2147483647)else cur_val:=mult_and_add(eqtb[l].int,cur_val,0,
1073741823)else cur_val:=x_over_n(eqtb[l].int,cur_val)else begin s:=eqtb
[l].hh.rh;r:=new_spec(s);
if q=91 then begin mem[r+1].int:=mult_and_add(mem[s+1].int,cur_val,0,
1073741823);
mem[r+2].int:=mult_and_add(mem[s+2].int,cur_val,0,1073741823);
mem[r+3].int:=mult_and_add(mem[s+3].int,cur_val,0,1073741823);
end else begin mem[r+1].int:=x_over_n(mem[s+1].int,cur_val);
mem[r+2].int:=x_over_n(mem[s+2].int,cur_val);
mem[r+3].int:=x_over_n(mem[s+3].int,cur_val);end;cur_val:=r;end;
end{:1240};if arith_error then begin begin if interaction=3 then;
print_nl(262);print(1206);end;begin help_ptr:=2;help_line[1]:=1207;
help_line[0]:=1208;end;if p>=2 then delete_glue_ref(cur_val);error;
goto 10;end;
if p<2 then if(a>=4)then geq_word_define(l,cur_val)else eq_word_define(l
,cur_val)else begin trap_zero_glue;
if(a>=4)then geq_define(l,117,cur_val)else eq_define(l,117,cur_val);end;
10:end;{:1236}{1243:}procedure alter_aux;var c:halfword;
begin if cur_chr<>abs(cur_list.mode_field)then report_illegal_case else
begin c:=cur_chr;scan_optional_equals;
if c=1 then begin scan_dimen(false,false,false);
cur_list.aux_field.int:=cur_val;end else begin scan_int;
if(cur_val<=0)or(cur_val>32767)then begin begin if interaction=3 then;
print_nl(262);print(1212);end;begin help_ptr:=1;help_line[0]:=1213;end;
int_error(cur_val);end else cur_list.aux_field.hh.lh:=cur_val;end;end;
end;{:1243}{1244:}procedure alter_prev_graf;var p:0..nest_size;
begin nest[nest_ptr]:=cur_list;p:=nest_ptr;
while abs(nest[p].mode_field)<>1 do p:=p-1;scan_optional_equals;
scan_int;if cur_val<0 then begin begin if interaction=3 then;
print_nl(262);print(954);end;print_esc(532);begin help_ptr:=1;
help_line[0]:=1214;end;int_error(cur_val);
end else begin nest[p].pg_field:=cur_val;cur_list:=nest[nest_ptr];end;
end;{:1244}{1245:}procedure alter_page_so_far;var c:0..7;
begin c:=cur_chr;scan_optional_equals;scan_dimen(false,false,false);
page_so_far[c]:=cur_val;end;{:1245}{1246:}procedure alter_integer;
var c:0..1;begin c:=cur_chr;scan_optional_equals;scan_int;
if c=0 then dead_cycles:=cur_val else insert_penalties:=cur_val;end;
{:1246}{1247:}procedure alter_box_dimen;var c:small_number;b:eight_bits;
begin c:=cur_chr;scan_eight_bit_int;b:=cur_val;scan_optional_equals;
scan_dimen(false,false,false);
if eqtb[3678+b].hh.rh<>0 then mem[eqtb[3678+b].hh.rh+c].int:=cur_val;
end;{:1247}{1257:}procedure new_font(a:small_number);label 50;
var u:halfword;s:scaled;f:internal_font_number;t:str_number;
old_setting:0..21;flushable_string:str_number;
begin if job_name=0 then open_log_file;get_r_token;u:=cur_cs;
if u>=514 then t:=hash[u].rh else if u>=257 then if u=513 then t:=1218
else t:=u-257 else begin old_setting:=selector;selector:=21;print(1218);
print(u-1);selector:=old_setting;
begin if pool_ptr+1>pool_size then overflow(257,pool_size-init_pool_ptr)
;end;t:=make_string;end;
if(a>=4)then geq_define(u,87,0)else eq_define(u,87,0);
scan_optional_equals;scan_file_name;{1258:}name_in_progress:=true;
if scan_keyword(1219)then{1259:}begin scan_dimen(false,false,false);
s:=cur_val;
if(s<=0)or(s>=134217728)then begin begin if interaction=3 then;
print_nl(262);print(1221);end;print_scaled(s);print(1222);
begin help_ptr:=2;help_line[1]:=1223;help_line[0]:=1224;end;error;
s:=10*65536;end;end{:1259}else if scan_keyword(1220)then begin scan_int;
s:=-cur_val;
if(cur_val<=0)or(cur_val>32768)then begin begin if interaction=3 then;
print_nl(262);print(552);end;begin help_ptr:=1;help_line[0]:=553;end;
int_error(cur_val);s:=-1000;end;end else s:=-1000;
name_in_progress:=false{:1258};{1260:}flushable_string:=str_ptr-1;
for f:=1 to font_ptr do if str_eq_str(font_name[f],cur_name)and
str_eq_str(font_area[f],cur_area)then begin if cur_name=flushable_string
then begin begin str_ptr:=str_ptr-1;pool_ptr:=str_start[str_ptr];end;
cur_name:=font_name[f];end;
if s>0 then begin if s=font_size[f]then goto 50;
end else if font_size[f]=xn_over_d(font_dsize[f],-s,1000)then goto 50;
end{:1260};f:=read_font_info(u,cur_name,cur_area,s);50:eqtb[u].hh.rh:=f;
eqtb[2624+f]:=eqtb[u];hash[2624+f].rh:=t;end;
{:1257}{1265:}procedure new_interaction;begin print_ln;
interaction:=cur_chr;
{75:}if interaction=0 then selector:=16 else selector:=17{:75};
if log_opened then selector:=selector+2;end;
{:1265}procedure prefixed_command;label 30,10;var a:small_number;
f:internal_font_number;j:halfword;k:font_index;p,q:halfword;n:integer;
e:boolean;begin a:=0;
while cur_cmd=93 do begin if not odd(a div cur_chr)then a:=a+cur_chr;
{404:}repeat get_x_token;until(cur_cmd<>10)and(cur_cmd<>0){:404};
if cur_cmd<=70 then{1212:}begin begin if interaction=3 then;
print_nl(262);print(1178);end;print_cmd_chr(cur_cmd,cur_chr);
print_char(39);begin help_ptr:=1;help_line[0]:=1179;end;back_error;
goto 10;end{:1212};end;
{1213:}if(cur_cmd<>97)and(a mod 4<>0)then begin begin if interaction=3
then;print_nl(262);print(685);end;print_esc(1170);print(1180);
print_esc(1171);print(1181);print_cmd_chr(cur_cmd,cur_chr);
print_char(39);begin help_ptr:=1;help_line[0]:=1182;end;error;
end{:1213};
{1214:}if eqtb[5306].int<>0 then if eqtb[5306].int<0 then begin if(a>=4)
then a:=a-4;end else begin if not(a>=4)then a:=a+4;end{:1214};
case cur_cmd of{1217:}87:if(a>=4)then geq_define(3934,120,cur_chr)else
eq_define(3934,120,cur_chr);
{:1217}{1218:}97:begin if odd(cur_chr)and not(a>=4)and(eqtb[5306].int>=0
)then a:=a+4;e:=(cur_chr>=2);get_r_token;p:=cur_cs;q:=scan_toks(true,e);
if(a>=4)then geq_define(p,111+(a mod 4),def_ref)else eq_define(p,111+(a
mod 4),def_ref);end;{:1218}{1221:}94:begin n:=cur_chr;get_r_token;
p:=cur_cs;if n=0 then begin repeat get_token;until cur_cmd<>10;
if cur_tok=3133 then begin get_token;if cur_cmd=10 then get_token;end;
end else begin get_token;q:=cur_tok;get_token;back_input;cur_tok:=q;
back_input;end;
if cur_cmd>=111 then mem[cur_chr].hh.lh:=mem[cur_chr].hh.lh+1;
if(a>=4)then geq_define(p,cur_cmd,cur_chr)else eq_define(p,cur_cmd,
cur_chr);end;{:1221}{1224:}95:begin n:=cur_chr;get_r_token;p:=cur_cs;
if(a>=4)then geq_define(p,0,256)else eq_define(p,0,256);
scan_optional_equals;case n of 0:begin scan_char_num;
if(a>=4)then geq_define(p,68,cur_val)else eq_define(p,68,cur_val);end;
1:begin scan_fifteen_bit_int;
if(a>=4)then geq_define(p,69,cur_val)else eq_define(p,69,cur_val);end;
others:begin scan_eight_bit_int;
case n of 2:if(a>=4)then geq_define(p,73,5318+cur_val)else eq_define(p,
73,5318+cur_val);
3:if(a>=4)then geq_define(p,74,5851+cur_val)else eq_define(p,74,5851+
cur_val);
4:if(a>=4)then geq_define(p,75,2900+cur_val)else eq_define(p,75,2900+
cur_val);
5:if(a>=4)then geq_define(p,76,3156+cur_val)else eq_define(p,76,3156+
cur_val);
6:if(a>=4)then geq_define(p,72,3422+cur_val)else eq_define(p,72,3422+
cur_val);end;end end;end;{:1224}{1225:}96:begin scan_int;n:=cur_val;
if not scan_keyword(841)then begin begin if interaction=3 then;
print_nl(262);print(1072);end;begin help_ptr:=2;help_line[1]:=1199;
help_line[0]:=1200;end;error;end;get_r_token;p:=cur_cs;read_toks(n,p);
if(a>=4)then geq_define(p,111,cur_val)else eq_define(p,111,cur_val);end;
{:1225}{1226:}71,72:begin q:=cur_cs;
if cur_cmd=71 then begin scan_eight_bit_int;p:=3422+cur_val;
end else p:=cur_chr;scan_optional_equals;{404:}repeat get_x_token;
until(cur_cmd<>10)and(cur_cmd<>0){:404};
if cur_cmd<>1 then{1227:}begin if cur_cmd=71 then begin
scan_eight_bit_int;cur_cmd:=72;cur_chr:=3422+cur_val;end;
if cur_cmd=72 then begin q:=eqtb[cur_chr].hh.rh;
if q=0 then if(a>=4)then geq_define(p,101,0)else eq_define(p,101,0)else
begin mem[q].hh.lh:=mem[q].hh.lh+1;
if(a>=4)then geq_define(p,111,q)else eq_define(p,111,q);end;goto 30;end;
end{:1227};back_input;cur_cs:=q;q:=scan_toks(false,false);
if mem[def_ref].hh.rh=0 then begin if(a>=4)then geq_define(p,101,0)else
eq_define(p,101,0);begin mem[def_ref].hh.rh:=avail;avail:=def_ref;
{dyn_used:=dyn_used-1;}end;
end else begin if p=3413 then begin mem[q].hh.rh:=get_avail;
q:=mem[q].hh.rh;mem[q].hh.lh:=637;q:=get_avail;mem[q].hh.lh:=379;
mem[q].hh.rh:=mem[def_ref].hh.rh;mem[def_ref].hh.rh:=q;end;
if(a>=4)then geq_define(p,111,def_ref)else eq_define(p,111,def_ref);end;
end;{:1226}{1228:}73:begin p:=cur_chr;scan_optional_equals;scan_int;
if(a>=4)then geq_word_define(p,cur_val)else eq_word_define(p,cur_val);
end;74:begin p:=cur_chr;scan_optional_equals;
scan_dimen(false,false,false);
if(a>=4)then geq_word_define(p,cur_val)else eq_word_define(p,cur_val);
end;75,76:begin p:=cur_chr;n:=cur_cmd;scan_optional_equals;
if n=76 then scan_glue(3)else scan_glue(2);trap_zero_glue;
if(a>=4)then geq_define(p,117,cur_val)else eq_define(p,117,cur_val);end;
{:1228}{1232:}85:begin{1233:}if cur_chr=3983 then n:=15 else if cur_chr=
5007 then n:=32768 else if cur_chr=4751 then n:=32767 else if cur_chr=
5574 then n:=16777215 else n:=255{:1233};p:=cur_chr;scan_char_num;
p:=p+cur_val;scan_optional_equals;scan_int;
if((cur_val<0)and(p<5574))or(cur_val>n)then begin begin if interaction=3
then;print_nl(262);print(1201);end;print_int(cur_val);
if p<5574 then print(1202)else print(1203);print_int(n);
begin help_ptr:=1;help_line[0]:=1204;end;error;cur_val:=0;end;
if p<5007 then if(a>=4)then geq_define(p,120,cur_val)else eq_define(p,
120,cur_val)else if p<5574 then if(a>=4)then geq_define(p,120,cur_val+0)
else eq_define(p,120,cur_val+0)else if(a>=4)then geq_word_define(p,
cur_val)else eq_word_define(p,cur_val);end;
{:1232}{1234:}86:begin p:=cur_chr;scan_four_bit_int;p:=p+cur_val;
scan_optional_equals;scan_font_ident;
if(a>=4)then geq_define(p,120,cur_val)else eq_define(p,120,cur_val);end;
{:1234}{1235:}89,90,91,92:do_register_command(a);
{:1235}{1241:}98:begin scan_eight_bit_int;
if(a>=4)then n:=256+cur_val else n:=cur_val;scan_optional_equals;
if set_box_allowed then scan_box(1073741824+n)else begin begin if
interaction=3 then;print_nl(262);print(680);end;print_esc(536);
begin help_ptr:=2;help_line[1]:=1210;help_line[0]:=1211;end;error;end;
end;{:1241}{1242:}79:alter_aux;80:alter_prev_graf;81:alter_page_so_far;
82:alter_integer;83:alter_box_dimen;
{:1242}{1248:}84:begin scan_optional_equals;scan_int;n:=cur_val;
if n<=0 then p:=0 else begin p:=get_node(2*n+1);mem[p].hh.lh:=n;
for j:=1 to n do begin scan_dimen(false,false,false);
mem[p+2*j-1].int:=cur_val;scan_dimen(false,false,false);
mem[p+2*j].int:=cur_val;end;end;
if(a>=4)then geq_define(3412,118,p)else eq_define(3412,118,p);end;
{:1248}{1252:}99:if cur_chr=1 then begin new_patterns;goto 30;
begin if interaction=3 then;print_nl(262);print(1215);end;help_ptr:=0;
error;repeat get_token;until cur_cmd=2;goto 10;
end else begin new_hyph_exceptions;goto 30;end;
{:1252}{1253:}77:begin find_font_dimen(true);k:=cur_val;
scan_optional_equals;scan_dimen(false,false,false);
font_info[k].int:=cur_val;end;78:begin n:=cur_chr;scan_font_ident;
f:=cur_val;scan_optional_equals;scan_int;
if n=0 then hyphen_char[f]:=cur_val else skew_char[f]:=cur_val;end;
{:1253}{1256:}88:new_font(a);{:1256}{1264:}100:new_interaction;
{:1264}others:confusion(1177)end;
30:{1269:}if after_token<>0 then begin cur_tok:=after_token;back_input;
after_token:=0;end{:1269};10:end;{:1211}{1270:}procedure do_assignments;
label 10;begin while true do begin{404:}repeat get_x_token;
until(cur_cmd<>10)and(cur_cmd<>0){:404};if cur_cmd<=70 then goto 10;
set_box_allowed:=false;prefixed_command;set_box_allowed:=true;end;
10:end;{:1270}{1275:}procedure open_or_close_in;var c:0..1;n:0..15;
begin c:=cur_chr;scan_four_bit_int;n:=cur_val;
if read_open[n]<>2 then begin a_close(read_file[n]);read_open[n]:=2;end;
if c<>0 then begin scan_optional_equals;scan_file_name;
if cur_ext=338 then cur_ext:=790;
pack_file_name(cur_name,cur_area,cur_ext);
if a_open_in(read_file[n])then read_open[n]:=1;end;end;
{:1275}{1279:}procedure issue_message;var old_setting:0..21;c:0..1;
s:str_number;begin c:=cur_chr;mem[29988].hh.rh:=scan_toks(false,true);
old_setting:=selector;selector:=21;token_show(def_ref);
selector:=old_setting;flush_list(def_ref);
begin if pool_ptr+1>pool_size then overflow(257,pool_size-init_pool_ptr)
;end;s:=make_string;
if c=0 then{1280:}begin if term_offset+(str_start[s+1]-str_start[s])>
max_print_line-2 then print_ln else if(term_offset>0)or(file_offset>0)
then print_char(32);slow_print(s);break(term_out);
end{:1280}else{1283:}begin begin if interaction=3 then;print_nl(262);
print(338);end;slow_print(s);
if eqtb[3421].hh.rh<>0 then use_err_help:=true else if long_help_seen
then begin help_ptr:=1;help_line[0]:=1231;
end else begin if interaction<3 then long_help_seen:=true;
begin help_ptr:=4;help_line[3]:=1232;help_line[2]:=1233;
help_line[1]:=1234;help_line[0]:=1235;end;end;error;use_err_help:=false;
end{:1283};begin str_ptr:=str_ptr-1;pool_ptr:=str_start[str_ptr];end;
end;{:1279}{1288:}procedure shift_case;var b:halfword;p:halfword;
t:halfword;c:eight_bits;begin b:=cur_chr;p:=scan_toks(false,false);
p:=mem[def_ref].hh.rh;while p<>0 do begin{1289:}t:=mem[p].hh.lh;
if t<4352 then begin c:=t mod 256;
if eqtb[b+c].hh.rh<>0 then mem[p].hh.lh:=t-c+eqtb[b+c].hh.rh;end{:1289};
p:=mem[p].hh.rh;end;begin_token_list(mem[def_ref].hh.rh,3);
begin mem[def_ref].hh.rh:=avail;avail:=def_ref;{dyn_used:=dyn_used-1;}
end;end;{:1288}{1293:}procedure show_whatever;label 50;var p:halfword;
begin case cur_chr of 3:begin begin_diagnostic;show_activities;end;
1:{1296:}begin scan_eight_bit_int;begin_diagnostic;print_nl(1253);
print_int(cur_val);print_char(61);
if eqtb[3678+cur_val].hh.rh=0 then print(410)else show_box(eqtb[3678+
cur_val].hh.rh);end{:1296};0:{1294:}begin get_token;
if interaction=3 then;print_nl(1247);
if cur_cs<>0 then begin sprint_cs(cur_cs);print_char(61);end;
print_meaning;goto 50;end{:1294};others:{1297:}begin p:=the_toks;
if interaction=3 then;print_nl(1247);token_show(29997);
flush_list(mem[29997].hh.rh);goto 50;end{:1297}end;
{1298:}end_diagnostic(true);begin if interaction=3 then;print_nl(262);
print(1254);end;
if selector=19 then if eqtb[5292].int<=0 then begin selector:=17;
print(1255);selector:=19;end{:1298};
50:if interaction<3 then begin help_ptr:=0;error_count:=error_count-1;
end else if eqtb[5292].int>0 then begin begin help_ptr:=3;
help_line[2]:=1242;help_line[1]:=1243;help_line[0]:=1244;end;
end else begin begin help_ptr:=5;help_line[4]:=1242;help_line[3]:=1243;
help_line[2]:=1244;help_line[1]:=1245;help_line[0]:=1246;end;end;error;
end;{:1293}{1302:}procedure store_fmt_file;label 41,42,31,32;
var j,k,l:integer;p,q:halfword;x:integer;w:four_quarters;
begin{1304:}if save_ptr<>0 then begin begin if interaction=3 then;
print_nl(262);print(1257);end;begin help_ptr:=1;help_line[0]:=1258;end;
begin if interaction=3 then interaction:=2;if log_opened then error;
{if interaction>0 then debug_help;}history:=3;jump_out;end;end{:1304};
{1328:}selector:=21;print(1271);print(job_name);print_char(32);
print_int(eqtb[5286].int);print_char(46);print_int(eqtb[5285].int);
print_char(46);print_int(eqtb[5284].int);print_char(41);
if interaction=0 then selector:=18 else selector:=19;
begin if pool_ptr+1>pool_size then overflow(257,pool_size-init_pool_ptr)
;end;format_ident:=make_string;pack_job_name(785);
while not w_open_out(fmt_file)do prompt_file_name(1272,785);
print_nl(1273);slow_print(w_make_name_string(fmt_file));
begin str_ptr:=str_ptr-1;pool_ptr:=str_start[str_ptr];end;print_nl(338);
slow_print(format_ident){:1328};{1307:}begin fmt_file^.int:=117275187;
put(fmt_file);end;begin fmt_file^.int:=0;put(fmt_file);end;
begin fmt_file^.int:=30000;put(fmt_file);end;begin fmt_file^.int:=6106;
put(fmt_file);end;begin fmt_file^.int:=1777;put(fmt_file);end;
begin fmt_file^.int:=307;put(fmt_file);end{:1307};
{1309:}begin fmt_file^.int:=pool_ptr;put(fmt_file);end;
begin fmt_file^.int:=str_ptr;put(fmt_file);end;
for k:=0 to str_ptr do begin fmt_file^.int:=str_start[k];put(fmt_file);
end;k:=0;while k+4<pool_ptr do begin w.b0:=str_pool[k]+0;
w.b1:=str_pool[k+1]+0;w.b2:=str_pool[k+2]+0;w.b3:=str_pool[k+3]+0;
begin fmt_file^.qqqq:=w;put(fmt_file);end;k:=k+4;end;k:=pool_ptr-4;
w.b0:=str_pool[k]+0;w.b1:=str_pool[k+1]+0;w.b2:=str_pool[k+2]+0;
w.b3:=str_pool[k+3]+0;begin fmt_file^.qqqq:=w;put(fmt_file);end;
print_ln;print_int(str_ptr);print(1259);print_int(pool_ptr){:1309};
{1311:}sort_avail;var_used:=0;begin fmt_file^.int:=lo_mem_max;
put(fmt_file);end;begin fmt_file^.int:=rover;put(fmt_file);end;p:=0;
q:=rover;x:=0;repeat for k:=p to q+1 do begin fmt_file^:=mem[k];
put(fmt_file);end;x:=x+q+2-p;var_used:=var_used+q-p;p:=q+mem[q].hh.lh;
q:=mem[q+1].hh.rh;until q=rover;var_used:=var_used+lo_mem_max-p;
dyn_used:=mem_end+1-hi_mem_min;
for k:=p to lo_mem_max do begin fmt_file^:=mem[k];put(fmt_file);end;
x:=x+lo_mem_max+1-p;begin fmt_file^.int:=hi_mem_min;put(fmt_file);end;
begin fmt_file^.int:=avail;put(fmt_file);end;
for k:=hi_mem_min to mem_end do begin fmt_file^:=mem[k];put(fmt_file);
end;x:=x+mem_end+1-hi_mem_min;p:=avail;
while p<>0 do begin dyn_used:=dyn_used-1;p:=mem[p].hh.rh;end;
begin fmt_file^.int:=var_used;put(fmt_file);end;
begin fmt_file^.int:=dyn_used;put(fmt_file);end;print_ln;print_int(x);
print(1260);print_int(var_used);print_char(38);
print_int(dyn_used){:1311};{1313:}{1315:}k:=1;repeat j:=k;
while j<5262 do begin if(eqtb[j].hh.rh=eqtb[j+1].hh.rh)and(eqtb[j].hh.b0
=eqtb[j+1].hh.b0)and(eqtb[j].hh.b1=eqtb[j+1].hh.b1)then goto 41;j:=j+1;
end;l:=5263;goto 31;41:j:=j+1;l:=j;
while j<5262 do begin if(eqtb[j].hh.rh<>eqtb[j+1].hh.rh)or(eqtb[j].hh.b0
<>eqtb[j+1].hh.b0)or(eqtb[j].hh.b1<>eqtb[j+1].hh.b1)then goto 31;j:=j+1;
end;31:begin fmt_file^.int:=l-k;put(fmt_file);end;
while k<l do begin begin fmt_file^:=eqtb[k];put(fmt_file);end;k:=k+1;
end;k:=j+1;begin fmt_file^.int:=k-l;put(fmt_file);end;
until k=5263{:1315};{1316:}repeat j:=k;
while j<6106 do begin if eqtb[j].int=eqtb[j+1].int then goto 42;j:=j+1;
end;l:=6107;goto 32;42:j:=j+1;l:=j;
while j<6106 do begin if eqtb[j].int<>eqtb[j+1].int then goto 32;j:=j+1;
end;32:begin fmt_file^.int:=l-k;put(fmt_file);end;
while k<l do begin begin fmt_file^:=eqtb[k];put(fmt_file);end;k:=k+1;
end;k:=j+1;begin fmt_file^.int:=k-l;put(fmt_file);end;
until k>6106{:1316};begin fmt_file^.int:=par_loc;put(fmt_file);end;
begin fmt_file^.int:=write_loc;put(fmt_file);end;
{1318:}begin fmt_file^.int:=hash_used;put(fmt_file);end;
cs_count:=2613-hash_used;
for p:=514 to hash_used do if hash[p].rh<>0 then begin begin fmt_file^.
int:=p;put(fmt_file);end;begin fmt_file^.hh:=hash[p];put(fmt_file);end;
cs_count:=cs_count+1;end;
for p:=hash_used+1 to 2880 do begin fmt_file^.hh:=hash[p];put(fmt_file);
end;begin fmt_file^.int:=cs_count;put(fmt_file);end;print_ln;
print_int(cs_count);print(1261){:1318}{:1313};
{1320:}begin fmt_file^.int:=fmem_ptr;put(fmt_file);end;
for k:=0 to fmem_ptr-1 do begin fmt_file^:=font_info[k];put(fmt_file);
end;begin fmt_file^.int:=font_ptr;put(fmt_file);end;
for k:=0 to font_ptr do{1322:}begin begin fmt_file^.qqqq:=font_check[k];
put(fmt_file);end;begin fmt_file^.int:=font_size[k];put(fmt_file);end;
begin fmt_file^.int:=font_dsize[k];put(fmt_file);end;
begin fmt_file^.int:=font_params[k];put(fmt_file);end;
begin fmt_file^.int:=hyphen_char[k];put(fmt_file);end;
begin fmt_file^.int:=skew_char[k];put(fmt_file);end;
begin fmt_file^.int:=font_name[k];put(fmt_file);end;
begin fmt_file^.int:=font_area[k];put(fmt_file);end;
begin fmt_file^.int:=font_bc[k];put(fmt_file);end;
begin fmt_file^.int:=font_ec[k];put(fmt_file);end;
begin fmt_file^.int:=char_base[k];put(fmt_file);end;
begin fmt_file^.int:=width_base[k];put(fmt_file);end;
begin fmt_file^.int:=height_base[k];put(fmt_file);end;
begin fmt_file^.int:=depth_base[k];put(fmt_file);end;
begin fmt_file^.int:=italic_base[k];put(fmt_file);end;
begin fmt_file^.int:=lig_kern_base[k];put(fmt_file);end;
begin fmt_file^.int:=kern_base[k];put(fmt_file);end;
begin fmt_file^.int:=exten_base[k];put(fmt_file);end;
begin fmt_file^.int:=param_base[k];put(fmt_file);end;
begin fmt_file^.int:=font_glue[k];put(fmt_file);end;
begin fmt_file^.int:=bchar_label[k];put(fmt_file);end;
begin fmt_file^.int:=font_bchar[k];put(fmt_file);end;
begin fmt_file^.int:=font_false_bchar[k];put(fmt_file);end;
print_nl(1264);print_esc(hash[2624+k].rh);print_char(61);
print_file_name(font_name[k],font_area[k],338);
if font_size[k]<>font_dsize[k]then begin print(741);
print_scaled(font_size[k]);print(397);end;end{:1322};print_ln;
print_int(fmem_ptr-7);print(1262);print_int(font_ptr-0);print(1263);
if font_ptr<>1 then print_char(115){:1320};
{1324:}begin fmt_file^.int:=hyph_count;put(fmt_file);end;
for k:=0 to 307 do if hyph_word[k]<>0 then begin begin fmt_file^.int:=k;
put(fmt_file);end;begin fmt_file^.int:=hyph_word[k];put(fmt_file);end;
begin fmt_file^.int:=hyph_list[k];put(fmt_file);end;end;print_ln;
print_int(hyph_count);print(1265);if hyph_count<>1 then print_char(115);
if trie_not_ready then init_trie;begin fmt_file^.int:=trie_max;
put(fmt_file);end;for k:=0 to trie_max do begin fmt_file^.hh:=trie[k];
put(fmt_file);end;begin fmt_file^.int:=trie_op_ptr;put(fmt_file);end;
for k:=1 to trie_op_ptr do begin begin fmt_file^.int:=hyf_distance[k];
put(fmt_file);end;begin fmt_file^.int:=hyf_num[k];put(fmt_file);end;
begin fmt_file^.int:=hyf_next[k];put(fmt_file);end;end;print_nl(1266);
print_int(trie_max);print(1267);print_int(trie_op_ptr);print(1268);
if trie_op_ptr<>1 then print_char(115);print(1269);
print_int(trie_op_size);
for k:=255 downto 0 do if trie_used[k]>0 then begin print_nl(799);
print_int(trie_used[k]-0);print(1270);print_int(k);
begin fmt_file^.int:=k;put(fmt_file);end;
begin fmt_file^.int:=trie_used[k]-0;put(fmt_file);end;end{:1324};
{1326:}begin fmt_file^.int:=interaction;put(fmt_file);end;
begin fmt_file^.int:=format_ident;put(fmt_file);end;
begin fmt_file^.int:=69069;put(fmt_file);end;eqtb[5294].int:=0{:1326};
{1329:}w_close(fmt_file){:1329};end;
{:1302}{1348:}{1349:}procedure new_whatsit(s:small_number;
w:small_number);var p:halfword;begin p:=get_node(w);mem[p].hh.b0:=8;
mem[p].hh.b1:=s;mem[cur_list.tail_field].hh.rh:=p;
cur_list.tail_field:=p;end;
{:1349}{1350:}procedure new_write_whatsit(w:small_number);
begin new_whatsit(cur_chr,w);
if w<>2 then scan_four_bit_int else begin scan_int;
if cur_val<0 then cur_val:=17 else if cur_val>15 then cur_val:=16;end;
mem[cur_list.tail_field+1].hh.lh:=cur_val;end;
{:1350}procedure do_extension;var i,j,k:integer;p,q,r:halfword;
begin case cur_chr of 0:{1351:}begin new_write_whatsit(3);
scan_optional_equals;scan_file_name;
mem[cur_list.tail_field+1].hh.rh:=cur_name;
mem[cur_list.tail_field+2].hh.lh:=cur_area;
mem[cur_list.tail_field+2].hh.rh:=cur_ext;end{:1351};
1:{1352:}begin k:=cur_cs;new_write_whatsit(2);cur_cs:=k;
p:=scan_toks(false,false);mem[cur_list.tail_field+1].hh.rh:=def_ref;
end{:1352};2:{1353:}begin new_write_whatsit(2);
mem[cur_list.tail_field+1].hh.rh:=0;end{:1353};
3:{1354:}begin new_whatsit(3,2);mem[cur_list.tail_field+1].hh.lh:=0;
p:=scan_toks(false,true);mem[cur_list.tail_field+1].hh.rh:=def_ref;
end{:1354};4:{1375:}begin get_x_token;
if(cur_cmd=59)and(cur_chr<=2)then begin p:=cur_list.tail_field;
do_extension;out_what(cur_list.tail_field);
flush_node_list(cur_list.tail_field);cur_list.tail_field:=p;
mem[p].hh.rh:=0;end else back_input;end{:1375};
5:{1377:}if abs(cur_list.mode_field)<>102 then report_illegal_case else
begin new_whatsit(4,2);scan_int;
if cur_val<=0 then cur_list.aux_field.hh.rh:=0 else if cur_val>255 then
cur_list.aux_field.hh.rh:=0 else cur_list.aux_field.hh.rh:=cur_val;
mem[cur_list.tail_field+1].hh.rh:=cur_list.aux_field.hh.rh;
mem[cur_list.tail_field+1].hh.b0:=norm_min(eqtb[5314].int);
mem[cur_list.tail_field+1].hh.b1:=norm_min(eqtb[5315].int);end{:1377};
others:confusion(1290)end;end;{:1348}{1376:}procedure fix_language;
var l:ASCII_code;
begin if eqtb[5313].int<=0 then l:=0 else if eqtb[5313].int>255 then l:=
0 else l:=eqtb[5313].int;
if l<>cur_list.aux_field.hh.rh then begin new_whatsit(4,2);
mem[cur_list.tail_field+1].hh.rh:=l;cur_list.aux_field.hh.rh:=l;
mem[cur_list.tail_field+1].hh.b0:=norm_min(eqtb[5314].int);
mem[cur_list.tail_field+1].hh.b1:=norm_min(eqtb[5315].int);end;end;
{:1376}{1068:}procedure handle_right_brace;var p,q:halfword;d:scaled;
f:integer;begin case cur_group of 1:unsave;
0:begin begin if interaction=3 then;print_nl(262);print(1043);end;
begin help_ptr:=2;help_line[1]:=1044;help_line[0]:=1045;end;error;end;
14,15,16:extra_right_brace;{1085:}2:package(0);
3:begin adjust_tail:=29995;package(0);end;4:begin end_graf;package(0);
end;5:begin end_graf;package(4);end;{:1085}{1100:}11:begin end_graf;
q:=eqtb[2892].hh.rh;mem[q].hh.rh:=mem[q].hh.rh+1;d:=eqtb[5836].int;
f:=eqtb[5305].int;unsave;save_ptr:=save_ptr-1;
p:=vpackage(mem[cur_list.head_field].hh.rh,0,1,1073741823);pop_nest;
if save_stack[save_ptr+0].int<255 then begin begin mem[cur_list.
tail_field].hh.rh:=get_node(5);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b0:=3;
mem[cur_list.tail_field].hh.b1:=save_stack[save_ptr+0].int+0;
mem[cur_list.tail_field+3].int:=mem[p+3].int+mem[p+2].int;
mem[cur_list.tail_field+4].hh.lh:=mem[p+5].hh.rh;
mem[cur_list.tail_field+4].hh.rh:=q;mem[cur_list.tail_field+2].int:=d;
mem[cur_list.tail_field+1].int:=f;
end else begin begin mem[cur_list.tail_field].hh.rh:=get_node(2);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b0:=5;mem[cur_list.tail_field].hh.b1:=0;
mem[cur_list.tail_field+1].int:=mem[p+5].hh.rh;delete_glue_ref(q);end;
free_node(p,7);if nest_ptr=0 then build_page;end;
8:{1026:}begin if(cur_input.loc_field<>0)or((cur_input.index_field<>6)
and(cur_input.index_field<>3))then{1027:}begin begin if interaction=3
then;print_nl(262);print(1009);end;begin help_ptr:=2;help_line[1]:=1010;
help_line[0]:=1011;end;error;repeat get_token;
until cur_input.loc_field=0;end{:1027};end_token_list;end_graf;unsave;
output_active:=false;insert_penalties:=0;
{1028:}if eqtb[3933].hh.rh<>0 then begin begin if interaction=3 then;
print_nl(262);print(1012);end;print_esc(409);print_int(255);
begin help_ptr:=3;help_line[2]:=1013;help_line[1]:=1014;
help_line[0]:=1015;end;box_error(255);end{:1028};
if cur_list.tail_field<>cur_list.head_field then begin mem[page_tail].hh
.rh:=mem[cur_list.head_field].hh.rh;page_tail:=cur_list.tail_field;end;
if mem[29998].hh.rh<>0 then begin if mem[29999].hh.rh=0 then nest[0].
tail_field:=page_tail;mem[page_tail].hh.rh:=mem[29999].hh.rh;
mem[29999].hh.rh:=mem[29998].hh.rh;mem[29998].hh.rh:=0;page_tail:=29998;
end;pop_nest;build_page;end{:1026};{:1100}{1118:}10:build_discretionary;
{:1118}{1132:}6:begin back_input;cur_tok:=6710;
begin if interaction=3 then;print_nl(262);print(625);end;print_esc(898);
print(626);begin help_ptr:=1;help_line[0]:=1124;end;ins_error;end;
{:1132}{1133:}7:begin end_graf;unsave;align_peek;end;
{:1133}{1168:}12:begin end_graf;unsave;save_ptr:=save_ptr-2;
p:=vpackage(mem[cur_list.head_field].hh.rh,save_stack[save_ptr+1].int,
save_stack[save_ptr+0].int,1073741823);pop_nest;
begin mem[cur_list.tail_field].hh.rh:=new_noad;
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b0:=29;mem[cur_list.tail_field+1].hh.rh:=2;
mem[cur_list.tail_field+1].hh.lh:=p;end;{:1168}{1173:}13:build_choices;
{:1173}{1186:}9:begin unsave;save_ptr:=save_ptr-1;
mem[save_stack[save_ptr+0].int].hh.rh:=3;p:=fin_mlist(0);
mem[save_stack[save_ptr+0].int].hh.lh:=p;
if p<>0 then if mem[p].hh.rh=0 then if mem[p].hh.b0=16 then begin if mem
[p+3].hh.rh=0 then if mem[p+2].hh.rh=0 then begin mem[save_stack[
save_ptr+0].int].hh:=mem[p+1].hh;free_node(p,4);end;
end else if mem[p].hh.b0=28 then if save_stack[save_ptr+0].int=cur_list.
tail_field+1 then if mem[cur_list.tail_field].hh.b0=16 then{1187:}begin
q:=cur_list.head_field;
while mem[q].hh.rh<>cur_list.tail_field do q:=mem[q].hh.rh;
mem[q].hh.rh:=p;free_node(cur_list.tail_field,4);cur_list.tail_field:=p;
end{:1187};end;{:1186}others:confusion(1046)end;end;
{:1068}procedure main_control;
label 60,21,70,80,90,91,92,95,100,101,110,111,112,120,10;var t:integer;
begin if eqtb[3419].hh.rh<>0 then begin_token_list(eqtb[3419].hh.rh,12);
60:get_x_token;
21:{1031:}if interrupt<>0 then if OK_to_interrupt then begin back_input;
begin if interrupt<>0 then pause_for_instructions;end;goto 60;end;
{if panicking then check_mem(false);}
if eqtb[5299].int>0 then show_cur_cmd_chr{:1031};
case abs(cur_list.mode_field)+cur_cmd of 113,114,170:goto 70;
118:begin scan_char_num;cur_chr:=cur_val;goto 70;end;
167:begin get_x_token;
if(cur_cmd=11)or(cur_cmd=12)or(cur_cmd=68)or(cur_cmd=16)then
cancel_boundary:=true;goto 21;end;
112:if cur_list.aux_field.hh.lh=1000 then goto 120 else app_space;
166,267:goto 120;{1045:}1,102,203,11,213,268:;
40,141,242:begin{406:}repeat get_x_token;until cur_cmd<>10{:406};
goto 21;end;15:if its_all_over then goto 10;
{1048:}23,123,224,71,172,273,{:1048}{1098:}39,{:1098}{1111:}45,{:1111}
{1144:}49,150,{:1144}7,108,209:report_illegal_case;
{1046:}8,109,9,110,18,119,70,171,51,152,16,117,50,151,53,154,67,168,54,
155,55,156,57,158,56,157,31,132,52,153,29,130,47,148,212,216,217,230,227
,236,239{:1046}:insert_dollar_sign;
{1056:}37,137,238:begin begin mem[cur_list.tail_field].hh.rh:=
scan_rule_spec;cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
if abs(cur_list.mode_field)=1 then cur_list.aux_field.int:=-65536000
else if abs(cur_list.mode_field)=102 then cur_list.aux_field.hh.lh:=1000
;end;{:1056}{1057:}28,128,229,231:append_glue;
30,131,232,233:append_kern;{:1057}{1063:}2,103:new_save_level(1);
62,163,264:new_save_level(14);
63,164,265:if cur_group=14 then unsave else off_save;
{:1063}{1067:}3,104,205:handle_right_brace;
{:1067}{1073:}22,124,225:begin t:=cur_chr;scan_dimen(false,false,false);
if t=0 then scan_box(cur_val)else scan_box(-cur_val);end;
32,133,234:scan_box(1073742237+cur_chr);21,122,223:begin_box(0);
{:1073}{1090:}44:new_graf(cur_chr>0);
12,13,17,69,4,24,36,46,48,27,34,65,66:begin back_input;new_graf(true);
end;{:1090}{1092:}145,246:indent_in_hmode;
{:1092}{1094:}14:begin normal_paragraph;
if cur_list.mode_field>0 then build_page;end;
115:begin if align_state<0 then off_save;end_graf;
if cur_list.mode_field=1 then build_page;end;
116,129,138,126,134:head_for_vmode;
{:1094}{1097:}38,139,240,140,241:begin_insert_or_adjust;
19,120,221:make_mark;{:1097}{1102:}43,144,245:append_penalty;
{:1102}{1104:}26,127,228:delete_last;{:1104}{1109:}25,125,226:unpackage;
{:1109}{1112:}146:append_italic_correction;
247:begin mem[cur_list.tail_field].hh.rh:=new_kern(0);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
{:1112}{1116:}149,250:append_discretionary;
{:1116}{1122:}147:make_accent;
{:1122}{1126:}6,107,208,5,106,207:align_error;35,136,237:no_align_error;
64,165,266:omit_error;{:1126}{1130:}33,135:init_align;
235:if privileged then if cur_group=15 then init_align else off_save;
10,111:do_endv;{:1130}{1134:}68,169,270:cs_error;
{:1134}{1137:}105:init_math;
{:1137}{1140:}251:if privileged then if cur_group=15 then start_eq_no
else off_save;
{:1140}{1150:}204:begin begin mem[cur_list.tail_field].hh.rh:=new_noad;
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;back_input;
scan_math(cur_list.tail_field+1);end;
{:1150}{1154:}214,215,271:set_math_char(eqtb[5007+cur_chr].hh.rh-0);
219:begin scan_char_num;cur_chr:=cur_val;
set_math_char(eqtb[5007+cur_chr].hh.rh-0);end;
220:begin scan_fifteen_bit_int;set_math_char(cur_val);end;
272:set_math_char(cur_chr);218:begin scan_twenty_seven_bit_int;
set_math_char(cur_val div 4096);end;
{:1154}{1158:}253:begin begin mem[cur_list.tail_field].hh.rh:=new_noad;
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b0:=cur_chr;
scan_math(cur_list.tail_field+1);end;254:math_limit_switch;
{:1158}{1162:}269:math_radical;{:1162}{1164:}248,249:math_ac;
{:1164}{1167:}259:begin scan_spec(12,false);normal_paragraph;push_nest;
cur_list.mode_field:=-1;cur_list.aux_field.int:=-65536000;
if eqtb[3418].hh.rh<>0 then begin_token_list(eqtb[3418].hh.rh,11);end;
{:1167}{1171:}256:begin mem[cur_list.tail_field].hh.rh:=new_style(
cur_chr);cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
258:begin begin mem[cur_list.tail_field].hh.rh:=new_glue(0);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
mem[cur_list.tail_field].hh.b1:=98;end;257:append_choices;
{:1171}{1175:}211,210:sub_sup;{:1175}{1180:}255:math_fraction;
{:1180}{1190:}252:math_left_right;
{:1190}{1193:}206:if cur_group=15 then after_math else off_save;
{:1193}{1210:}72,173,274,73,174,275,74,175,276,75,176,277,76,177,278,77,
178,279,78,179,280,79,180,281,80,181,282,81,182,283,82,183,284,83,184,
285,84,185,286,85,186,287,86,187,288,87,188,289,88,189,290,89,190,291,90
,191,292,91,192,293,92,193,294,93,194,295,94,195,296,95,196,297,96,197,
298,97,198,299,98,199,300,99,200,301,100,201,302,101,202,303:
prefixed_command;{:1210}{1268:}41,142,243:begin get_token;
after_token:=cur_tok;end;{:1268}{1271:}42,143,244:begin get_token;
save_for_after(cur_tok);end;{:1271}{1274:}61,162,263:open_or_close_in;
{:1274}{1276:}59,160,261:issue_message;
{:1276}{1285:}58,159,260:shift_case;
{:1285}{1290:}20,121,222:show_whatever;
{:1290}{1347:}60,161,262:do_extension;{:1347}{:1045}end;goto 60;
70:{1034:}main_s:=eqtb[4751+cur_chr].hh.rh;
if main_s=1000 then cur_list.aux_field.hh.lh:=1000 else if main_s<1000
then begin if main_s>0 then cur_list.aux_field.hh.lh:=main_s;
end else if cur_list.aux_field.hh.lh<1000 then cur_list.aux_field.hh.lh
:=1000 else cur_list.aux_field.hh.lh:=main_s;main_f:=eqtb[3934].hh.rh;
bchar:=font_bchar[main_f];false_bchar:=font_false_bchar[main_f];
if cur_list.mode_field>0 then if eqtb[5313].int<>cur_list.aux_field.hh.
rh then fix_language;begin lig_stack:=avail;
if lig_stack=0 then lig_stack:=get_avail else begin avail:=mem[lig_stack
].hh.rh;mem[lig_stack].hh.rh:=0;{dyn_used:=dyn_used+1;}end;end;
mem[lig_stack].hh.b0:=main_f;cur_l:=cur_chr+0;
mem[lig_stack].hh.b1:=cur_l;cur_q:=cur_list.tail_field;
if cancel_boundary then begin cancel_boundary:=false;main_k:=0;
end else main_k:=bchar_label[main_f];if main_k=0 then goto 92;
cur_r:=cur_l;cur_l:=256;goto 111;
80:{1035:}if cur_l<256 then begin if mem[cur_q].hh.rh>0 then if mem[
cur_list.tail_field].hh.b1=hyphen_char[main_f]+0 then ins_disc:=true;
if ligature_present then begin main_p:=new_ligature(main_f,cur_l,mem[
cur_q].hh.rh);if lft_hit then begin mem[main_p].hh.b1:=2;lft_hit:=false;
end;
if rt_hit then if lig_stack=0 then begin mem[main_p].hh.b1:=mem[main_p].
hh.b1+1;rt_hit:=false;end;mem[cur_q].hh.rh:=main_p;
cur_list.tail_field:=main_p;ligature_present:=false;end;
if ins_disc then begin ins_disc:=false;
if cur_list.mode_field>0 then begin mem[cur_list.tail_field].hh.rh:=
new_disc;cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;end;
end{:1035};90:{1036:}if lig_stack=0 then goto 21;
cur_q:=cur_list.tail_field;cur_l:=mem[lig_stack].hh.b1;
91:if not(lig_stack>=hi_mem_min)then goto 95;
92:if(cur_chr<font_bc[main_f])or(cur_chr>font_ec[main_f])then begin
char_warning(main_f,cur_chr);begin mem[lig_stack].hh.rh:=avail;
avail:=lig_stack;{dyn_used:=dyn_used-1;}end;goto 60;end;
main_i:=font_info[char_base[main_f]+cur_l].qqqq;
if not(main_i.b0>0)then begin char_warning(main_f,cur_chr);
begin mem[lig_stack].hh.rh:=avail;avail:=lig_stack;
{dyn_used:=dyn_used-1;}end;goto 60;end;
mem[cur_list.tail_field].hh.rh:=lig_stack;
cur_list.tail_field:=lig_stack{:1036};100:{1038:}get_next;
if cur_cmd=11 then goto 101;if cur_cmd=12 then goto 101;
if cur_cmd=68 then goto 101;x_token;if cur_cmd=11 then goto 101;
if cur_cmd=12 then goto 101;if cur_cmd=68 then goto 101;
if cur_cmd=16 then begin scan_char_num;cur_chr:=cur_val;goto 101;end;
if cur_cmd=65 then bchar:=256;cur_r:=bchar;lig_stack:=0;goto 110;
101:main_s:=eqtb[4751+cur_chr].hh.rh;
if main_s=1000 then cur_list.aux_field.hh.lh:=1000 else if main_s<1000
then begin if main_s>0 then cur_list.aux_field.hh.lh:=main_s;
end else if cur_list.aux_field.hh.lh<1000 then cur_list.aux_field.hh.lh
:=1000 else cur_list.aux_field.hh.lh:=main_s;begin lig_stack:=avail;
if lig_stack=0 then lig_stack:=get_avail else begin avail:=mem[lig_stack
].hh.rh;mem[lig_stack].hh.rh:=0;{dyn_used:=dyn_used+1;}end;end;
mem[lig_stack].hh.b0:=main_f;cur_r:=cur_chr+0;
mem[lig_stack].hh.b1:=cur_r;if cur_r=false_bchar then cur_r:=256{:1038};
110:{1039:}if((main_i.b2-0)mod 4)<>1 then goto 80;
if cur_r=256 then goto 80;main_k:=lig_kern_base[main_f]+main_i.b3;
main_j:=font_info[main_k].qqqq;if main_j.b0<=128 then goto 112;
main_k:=lig_kern_base[main_f]+256*main_j.b2+main_j.b3+32768-256*(128);
111:main_j:=font_info[main_k].qqqq;
112:if main_j.b1=cur_r then if main_j.b0<=128 then{1040:}begin if main_j
.b2>=128 then begin if cur_l<256 then begin if mem[cur_q].hh.rh>0 then
if mem[cur_list.tail_field].hh.b1=hyphen_char[main_f]+0 then ins_disc:=
true;
if ligature_present then begin main_p:=new_ligature(main_f,cur_l,mem[
cur_q].hh.rh);if lft_hit then begin mem[main_p].hh.b1:=2;lft_hit:=false;
end;
if rt_hit then if lig_stack=0 then begin mem[main_p].hh.b1:=mem[main_p].
hh.b1+1;rt_hit:=false;end;mem[cur_q].hh.rh:=main_p;
cur_list.tail_field:=main_p;ligature_present:=false;end;
if ins_disc then begin ins_disc:=false;
if cur_list.mode_field>0 then begin mem[cur_list.tail_field].hh.rh:=
new_disc;cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;end;
end;begin mem[cur_list.tail_field].hh.rh:=new_kern(font_info[kern_base[
main_f]+256*main_j.b2+main_j.b3].int);
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;goto 90;end;
if cur_l=256 then lft_hit:=true else if lig_stack=0 then rt_hit:=true;
begin if interrupt<>0 then pause_for_instructions;end;
case main_j.b2 of 1,5:begin cur_l:=main_j.b3;
main_i:=font_info[char_base[main_f]+cur_l].qqqq;ligature_present:=true;
end;2,6:begin cur_r:=main_j.b3;
if lig_stack=0 then begin lig_stack:=new_lig_item(cur_r);bchar:=256;
end else if(lig_stack>=hi_mem_min)then begin main_p:=lig_stack;
lig_stack:=new_lig_item(cur_r);mem[lig_stack+1].hh.rh:=main_p;
end else mem[lig_stack].hh.b1:=cur_r;end;3:begin cur_r:=main_j.b3;
main_p:=lig_stack;lig_stack:=new_lig_item(cur_r);
mem[lig_stack].hh.rh:=main_p;end;
7,11:begin if cur_l<256 then begin if mem[cur_q].hh.rh>0 then if mem[
cur_list.tail_field].hh.b1=hyphen_char[main_f]+0 then ins_disc:=true;
if ligature_present then begin main_p:=new_ligature(main_f,cur_l,mem[
cur_q].hh.rh);if lft_hit then begin mem[main_p].hh.b1:=2;lft_hit:=false;
end;
if false then if lig_stack=0 then begin mem[main_p].hh.b1:=mem[main_p].
hh.b1+1;rt_hit:=false;end;mem[cur_q].hh.rh:=main_p;
cur_list.tail_field:=main_p;ligature_present:=false;end;
if ins_disc then begin ins_disc:=false;
if cur_list.mode_field>0 then begin mem[cur_list.tail_field].hh.rh:=
new_disc;cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;end;
end;cur_q:=cur_list.tail_field;cur_l:=main_j.b3;
main_i:=font_info[char_base[main_f]+cur_l].qqqq;ligature_present:=true;
end;others:begin cur_l:=main_j.b3;ligature_present:=true;
if lig_stack=0 then goto 80 else goto 91;end end;
if main_j.b2>4 then if main_j.b2<>7 then goto 80;
if cur_l<256 then goto 110;main_k:=bchar_label[main_f];goto 111;
end{:1040};
if main_j.b0=0 then main_k:=main_k+1 else begin if main_j.b0>=128 then
goto 80;main_k:=main_k+main_j.b0+1;end;goto 111{:1039};
95:{1037:}main_p:=mem[lig_stack+1].hh.rh;
if main_p>0 then begin mem[cur_list.tail_field].hh.rh:=main_p;
cur_list.tail_field:=mem[cur_list.tail_field].hh.rh;end;
temp_ptr:=lig_stack;lig_stack:=mem[temp_ptr].hh.rh;
free_node(temp_ptr,2);main_i:=font_info[char_base[main_f]+cur_l].qqqq;
ligature_present:=true;
if lig_stack=0 then if main_p>0 then goto 100 else cur_r:=bchar else
cur_r:=mem[lig_stack].hh.b1;goto 110{:1037}{:1034};
120:{1041:}if eqtb[2894].hh.rh=0 then begin{1042:}begin main_p:=
font_glue[eqtb[3934].hh.rh];if main_p=0 then begin main_p:=new_spec(0);
main_k:=param_base[eqtb[3934].hh.rh]+2;
mem[main_p+1].int:=font_info[main_k].int;
mem[main_p+2].int:=font_info[main_k+1].int;
mem[main_p+3].int:=font_info[main_k+2].int;
font_glue[eqtb[3934].hh.rh]:=main_p;end;end{:1042};
temp_ptr:=new_glue(main_p);end else temp_ptr:=new_param_glue(12);
mem[cur_list.tail_field].hh.rh:=temp_ptr;cur_list.tail_field:=temp_ptr;
goto 60{:1041};10:end;{:1030}{1284:}procedure give_err_help;
begin token_show(eqtb[3421].hh.rh);end;
{:1284}{1303:}{524:}function open_fmt_file:boolean;label 40,10;
var j:0..buf_size;begin j:=cur_input.loc_field;
if buffer[cur_input.loc_field]=38 then begin cur_input.loc_field:=
cur_input.loc_field+1;j:=cur_input.loc_field;buffer[last]:=32;
while buffer[j]<>32 do j:=j+1;
pack_buffered_name(0,cur_input.loc_field,j-1);
if w_open_in(fmt_file)then goto 40;
pack_buffered_name(11,cur_input.loc_field,j-1);
if w_open_in(fmt_file)then goto 40;;
write_ln(term_out,'Sorry, I can''t find that format;',' will try PLAIN.'
);break(term_out);end;pack_buffered_name(16,1,0);
if not w_open_in(fmt_file)then begin;
write_ln(term_out,'I can''t find the PLAIN format file!');
open_fmt_file:=false;goto 10;end;40:cur_input.loc_field:=j;
open_fmt_file:=true;10:end;{:524}function load_fmt_file:boolean;
label 6666,10;var j,k:integer;p,q:halfword;x:integer;w:four_quarters;
begin{1308:}x:=fmt_file^.int;if x<>117275187 then goto 6666;
begin get(fmt_file);x:=fmt_file^.int;end;if x<>0 then goto 6666;
begin get(fmt_file);x:=fmt_file^.int;end;if x<>30000 then goto 6666;
begin get(fmt_file);x:=fmt_file^.int;end;if x<>6106 then goto 6666;
begin get(fmt_file);x:=fmt_file^.int;end;if x<>1777 then goto 6666;
begin get(fmt_file);x:=fmt_file^.int;end;
if x<>307 then goto 6666{:1308};{1310:}begin begin get(fmt_file);
x:=fmt_file^.int;end;if x<0 then goto 6666;if x>pool_size then begin;
write_ln(term_out,'---! Must increase the ','string pool size');
goto 6666;end else pool_ptr:=x;end;begin begin get(fmt_file);
x:=fmt_file^.int;end;if x<0 then goto 6666;if x>max_strings then begin;
write_ln(term_out,'---! Must increase the ','max strings');goto 6666;
end else str_ptr:=x;end;
for k:=0 to str_ptr do begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>pool_ptr)then goto 6666 else str_start[k]:=x;end;k:=0;
while k+4<pool_ptr do begin begin get(fmt_file);w:=fmt_file^.qqqq;end;
str_pool[k]:=w.b0-0;str_pool[k+1]:=w.b1-0;str_pool[k+2]:=w.b2-0;
str_pool[k+3]:=w.b3-0;k:=k+4;end;k:=pool_ptr-4;begin get(fmt_file);
w:=fmt_file^.qqqq;end;str_pool[k]:=w.b0-0;str_pool[k+1]:=w.b1-0;
str_pool[k+2]:=w.b2-0;str_pool[k+3]:=w.b3-0;init_str_ptr:=str_ptr;
init_pool_ptr:=pool_ptr{:1310};{1312:}begin begin get(fmt_file);
x:=fmt_file^.int;end;
if(x<1019)or(x>29986)then goto 6666 else lo_mem_max:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<20)or(x>lo_mem_max)then goto 6666 else rover:=x;end;p:=0;q:=rover;
repeat for k:=p to q+1 do begin get(fmt_file);mem[k]:=fmt_file^;end;
p:=q+mem[q].hh.lh;
if(p>lo_mem_max)or((q>=mem[q+1].hh.rh)and(mem[q+1].hh.rh<>rover))then
goto 6666;q:=mem[q+1].hh.rh;until q=rover;
for k:=p to lo_mem_max do begin get(fmt_file);mem[k]:=fmt_file^;end;
if mem_min<-2 then begin p:=mem[rover+1].hh.lh;q:=mem_min+1;
mem[mem_min].hh.rh:=0;mem[mem_min].hh.lh:=0;mem[p+1].hh.rh:=q;
mem[rover+1].hh.lh:=q;mem[q+1].hh.rh:=rover;mem[q+1].hh.lh:=p;
mem[q].hh.rh:=65535;mem[q].hh.lh:=-0-q;end;begin begin get(fmt_file);
x:=fmt_file^.int;end;
if(x<lo_mem_max+1)or(x>29987)then goto 6666 else hi_mem_min:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>30000)then goto 6666 else avail:=x;end;mem_end:=30000;
for k:=hi_mem_min to mem_end do begin get(fmt_file);mem[k]:=fmt_file^;
end;begin get(fmt_file);var_used:=fmt_file^.int;end;begin get(fmt_file);
dyn_used:=fmt_file^.int;end{:1312};{1314:}{1317:}k:=1;
repeat begin get(fmt_file);x:=fmt_file^.int;end;
if(x<1)or(k+x>6107)then goto 6666;
for j:=k to k+x-1 do begin get(fmt_file);eqtb[j]:=fmt_file^;end;k:=k+x;
begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(k+x>6107)then goto 6666;
for j:=k to k+x-1 do eqtb[j]:=eqtb[k-1];k:=k+x;until k>6106{:1317};
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<514)or(x>2614)then goto 6666 else par_loc:=x;end;
par_token:=4095+par_loc;begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<514)or(x>2614)then goto 6666 else write_loc:=x;end;
{1319:}begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<514)or(x>2614)then goto 6666 else hash_used:=x;end;p:=513;
repeat begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<p+1)or(x>hash_used)then goto 6666 else p:=x;end;
begin get(fmt_file);hash[p]:=fmt_file^.hh;end;until p=hash_used;
for p:=hash_used+1 to 2880 do begin get(fmt_file);hash[p]:=fmt_file^.hh;
end;begin get(fmt_file);cs_count:=fmt_file^.int;end{:1319}{:1314};
{1321:}begin begin get(fmt_file);x:=fmt_file^.int;end;
if x<7 then goto 6666;if x>font_mem_size then begin;
write_ln(term_out,'---! Must increase the ','font mem size');goto 6666;
end else fmem_ptr:=x;end;for k:=0 to fmem_ptr-1 do begin get(fmt_file);
font_info[k]:=fmt_file^;end;begin begin get(fmt_file);x:=fmt_file^.int;
end;if x<0 then goto 6666;if x>font_max then begin;
write_ln(term_out,'---! Must increase the ','font max');goto 6666;
end else font_ptr:=x;end;
for k:=0 to font_ptr do{1323:}begin begin get(fmt_file);
font_check[k]:=fmt_file^.qqqq;end;begin get(fmt_file);
font_size[k]:=fmt_file^.int;end;begin get(fmt_file);
font_dsize[k]:=fmt_file^.int;end;begin begin get(fmt_file);
x:=fmt_file^.int;end;
if(x<0)or(x>65535)then goto 6666 else font_params[k]:=x;end;
begin get(fmt_file);hyphen_char[k]:=fmt_file^.int;end;
begin get(fmt_file);skew_char[k]:=fmt_file^.int;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>str_ptr)then goto 6666 else font_name[k]:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>str_ptr)then goto 6666 else font_area[k]:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>255)then goto 6666 else font_bc[k]:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>255)then goto 6666 else font_ec[k]:=x;end;
begin get(fmt_file);char_base[k]:=fmt_file^.int;end;begin get(fmt_file);
width_base[k]:=fmt_file^.int;end;begin get(fmt_file);
height_base[k]:=fmt_file^.int;end;begin get(fmt_file);
depth_base[k]:=fmt_file^.int;end;begin get(fmt_file);
italic_base[k]:=fmt_file^.int;end;begin get(fmt_file);
lig_kern_base[k]:=fmt_file^.int;end;begin get(fmt_file);
kern_base[k]:=fmt_file^.int;end;begin get(fmt_file);
exten_base[k]:=fmt_file^.int;end;begin get(fmt_file);
param_base[k]:=fmt_file^.int;end;begin begin get(fmt_file);
x:=fmt_file^.int;end;
if(x<0)or(x>lo_mem_max)then goto 6666 else font_glue[k]:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>fmem_ptr-1)then goto 6666 else bchar_label[k]:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>256)then goto 6666 else font_bchar[k]:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>256)then goto 6666 else font_false_bchar[k]:=x;end;
end{:1323}{:1321};{1325:}begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>307)then goto 6666 else hyph_count:=x;end;
for k:=1 to hyph_count do begin begin begin get(fmt_file);
x:=fmt_file^.int;end;if(x<0)or(x>307)then goto 6666 else j:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>str_ptr)then goto 6666 else hyph_word[j]:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>65535)then goto 6666 else hyph_list[j]:=x;end;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;if x<0 then goto 6666;
if x>trie_size then begin;
write_ln(term_out,'---! Must increase the ','trie size');goto 6666;
end else j:=x;end;trie_max:=j;for k:=0 to j do begin get(fmt_file);
trie[k]:=fmt_file^.hh;end;begin begin get(fmt_file);x:=fmt_file^.int;
end;if x<0 then goto 6666;if x>trie_op_size then begin;
write_ln(term_out,'---! Must increase the ','trie op size');goto 6666;
end else j:=x;end;trie_op_ptr:=j;
for k:=1 to j do begin begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>63)then goto 6666 else hyf_distance[k]:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>63)then goto 6666 else hyf_num[k]:=x;end;
begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>255)then goto 6666 else hyf_next[k]:=x;end;end;
for k:=0 to 255 do trie_used[k]:=0;k:=256;
while j>0 do begin begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>k-1)then goto 6666 else k:=x;end;begin begin get(fmt_file);
x:=fmt_file^.int;end;if(x<1)or(x>j)then goto 6666 else x:=x;end;
trie_used[k]:=x+0;j:=j-x;op_start[k]:=j-0;end;
trie_not_ready:=false{:1325};{1327:}begin begin get(fmt_file);
x:=fmt_file^.int;end;if(x<0)or(x>3)then goto 6666 else interaction:=x;
end;begin begin get(fmt_file);x:=fmt_file^.int;end;
if(x<0)or(x>str_ptr)then goto 6666 else format_ident:=x;end;
begin get(fmt_file);x:=fmt_file^.int;end;
if(x<>69069)or eof(fmt_file)then goto 6666{:1327};load_fmt_file:=true;
goto 10;6666:;
write_ln(term_out,'(Fatal format file error; I''m stymied)');
load_fmt_file:=false;10:end;
{:1303}{1330:}{1333:}procedure close_files_and_terminate;var k:integer;
begin{1378:}for k:=0 to 15 do if write_open[k]then a_close(write_file[k]
){:1378};
{if eqtb[5294].int>0 then[1334:]if log_opened then begin write_ln(
log_file,' ');
write_ln(log_file,'Here is how much of TeX''s memory',' you used:');
write(log_file,' ',str_ptr-init_str_ptr:1,' string');
if str_ptr<>init_str_ptr+1 then write(log_file,'s');
write_ln(log_file,' out of ',max_strings-init_str_ptr:1);
write_ln(log_file,' ',pool_ptr-init_pool_ptr:1,
' string characters out of ',pool_size-init_pool_ptr:1);
write_ln(log_file,' ',lo_mem_max-mem_min+mem_end-hi_mem_min+2:1,
' words of memory out of ',mem_end+1-mem_min:1);
write_ln(log_file,' ',cs_count:1,
' multiletter control sequences out of ',2100:1);
write(log_file,' ',fmem_ptr:1,' words of font info for ',font_ptr-0:1,
' font');if font_ptr<>1 then write(log_file,'s');
write_ln(log_file,', out of ',font_mem_size:1,' for ',font_max-0:1);
write(log_file,' ',hyph_count:1,' hyphenation exception');
if hyph_count<>1 then write(log_file,'s');
write_ln(log_file,' out of ',307:1);
write_ln(log_file,' ',max_in_stack:1,'i,',max_nest_stack:1,'n,',
max_param_stack:1,'p,',max_buf_stack+1:1,'b,',max_save_stack+6:1,
's stack positions out of ',stack_size:1,'i,',nest_size:1,'n,',
param_size:1,'p,',buf_size:1,'b,',save_size:1,'s');end[:1334];};
{642:}while cur_s>-1 do begin if cur_s>0 then begin dvi_buf[dvi_ptr]:=
142;dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;
end else begin begin dvi_buf[dvi_ptr]:=140;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;total_pages:=total_pages+1;end;
cur_s:=cur_s-1;end;
if total_pages=0 then print_nl(836)else begin begin dvi_buf[dvi_ptr]:=
248;dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
dvi_four(last_bop);last_bop:=dvi_offset+dvi_ptr-5;dvi_four(25400000);
dvi_four(473628672);prepare_mag;dvi_four(eqtb[5280].int);
dvi_four(max_v);dvi_four(max_h);
begin dvi_buf[dvi_ptr]:=max_push div 256;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=max_push mod 256;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=(total_pages div 256)mod 256;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
begin dvi_buf[dvi_ptr]:=total_pages mod 256;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
{643:}while font_ptr>0 do begin if font_used[font_ptr]then dvi_font_def(
font_ptr);font_ptr:=font_ptr-1;end{:643};begin dvi_buf[dvi_ptr]:=249;
dvi_ptr:=dvi_ptr+1;if dvi_ptr=dvi_limit then dvi_swap;end;
dvi_four(last_bop);begin dvi_buf[dvi_ptr]:=2;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;
k:=4+((dvi_buf_size-dvi_ptr)mod 4);
while k>0 do begin begin dvi_buf[dvi_ptr]:=223;dvi_ptr:=dvi_ptr+1;
if dvi_ptr=dvi_limit then dvi_swap;end;k:=k-1;end;
{599:}if dvi_limit=half_buf then write_dvi(half_buf,dvi_buf_size-1);
if dvi_ptr>0 then write_dvi(0,dvi_ptr-1){:599};print_nl(837);
slow_print(output_file_name);print(286);print_int(total_pages);
print(838);if total_pages<>1 then print_char(115);print(839);
print_int(dvi_offset+dvi_ptr);print(840);b_close(dvi_file);end{:642};
if log_opened then begin write_ln(log_file);a_close(log_file);
selector:=selector-2;if selector=17 then begin print_nl(1274);
slow_print(log_name);print_char(46);end;end;end;
{:1333}{1335:}procedure final_cleanup;label 10;var c:small_number;
begin c:=cur_chr;if job_name=0 then open_log_file;
while input_ptr>0 do if cur_input.state_field=0 then end_token_list else
end_file_reading;while open_parens>0 do begin print(1275);
open_parens:=open_parens-1;end;if cur_level>1 then begin print_nl(40);
print_esc(1276);print(1277);print_int(cur_level-1);print_char(41);end;
while cond_ptr<>0 do begin print_nl(40);print_esc(1276);print(1278);
print_cmd_chr(105,cur_if);if if_line<>0 then begin print(1279);
print_int(if_line);end;print(1280);if_line:=mem[cond_ptr+1].int;
cur_if:=mem[cond_ptr].hh.b1;temp_ptr:=cond_ptr;
cond_ptr:=mem[cond_ptr].hh.rh;free_node(temp_ptr,2);end;
if history<>0 then if((history=1)or(interaction<3))then if selector=19
then begin selector:=17;print_nl(1281);selector:=19;end;
if c=1 then begin for c:=0 to 4 do if cur_mark[c]<>0 then
delete_token_ref(cur_mark[c]);
if last_glue<>65535 then delete_glue_ref(last_glue);store_fmt_file;
goto 10;print_nl(1282);goto 10;end;10:end;
{:1335}{1336:}procedure init_prim;begin no_new_control_sequence:=false;
{226:}primitive(376,75,2882);primitive(377,75,2883);
primitive(378,75,2884);primitive(379,75,2885);primitive(380,75,2886);
primitive(381,75,2887);primitive(382,75,2888);primitive(383,75,2889);
primitive(384,75,2890);primitive(385,75,2891);primitive(386,75,2892);
primitive(387,75,2893);primitive(388,75,2894);primitive(389,75,2895);
primitive(390,75,2896);primitive(391,76,2897);primitive(392,76,2898);
primitive(393,76,2899);{:226}{230:}primitive(398,72,3413);
primitive(399,72,3414);primitive(400,72,3415);primitive(401,72,3416);
primitive(402,72,3417);primitive(403,72,3418);primitive(404,72,3419);
primitive(405,72,3420);primitive(406,72,3421);
{:230}{238:}primitive(420,73,5263);primitive(421,73,5264);
primitive(422,73,5265);primitive(423,73,5266);primitive(424,73,5267);
primitive(425,73,5268);primitive(426,73,5269);primitive(427,73,5270);
primitive(428,73,5271);primitive(429,73,5272);primitive(430,73,5273);
primitive(431,73,5274);primitive(432,73,5275);primitive(433,73,5276);
primitive(434,73,5277);primitive(435,73,5278);primitive(436,73,5279);
primitive(437,73,5280);primitive(438,73,5281);primitive(439,73,5282);
primitive(440,73,5283);primitive(441,73,5284);primitive(442,73,5285);
primitive(443,73,5286);primitive(444,73,5287);primitive(445,73,5288);
primitive(446,73,5289);primitive(447,73,5290);primitive(448,73,5291);
primitive(449,73,5292);primitive(450,73,5293);primitive(451,73,5294);
primitive(452,73,5295);primitive(453,73,5296);primitive(454,73,5297);
primitive(455,73,5298);primitive(456,73,5299);primitive(457,73,5300);
primitive(458,73,5301);primitive(459,73,5302);primitive(460,73,5303);
primitive(461,73,5304);primitive(462,73,5305);primitive(463,73,5306);
primitive(464,73,5307);primitive(465,73,5308);primitive(466,73,5309);
primitive(467,73,5310);primitive(468,73,5311);primitive(469,73,5312);
primitive(470,73,5313);primitive(471,73,5314);primitive(472,73,5315);
primitive(473,73,5316);primitive(474,73,5317);
{:238}{248:}primitive(478,74,5830);primitive(479,74,5831);
primitive(480,74,5832);primitive(481,74,5833);primitive(482,74,5834);
primitive(483,74,5835);primitive(484,74,5836);primitive(485,74,5837);
primitive(486,74,5838);primitive(487,74,5839);primitive(488,74,5840);
primitive(489,74,5841);primitive(490,74,5842);primitive(491,74,5843);
primitive(492,74,5844);primitive(493,74,5845);primitive(494,74,5846);
primitive(495,74,5847);primitive(496,74,5848);primitive(497,74,5849);
primitive(498,74,5850);{:248}{265:}primitive(32,64,0);
primitive(47,44,0);primitive(508,45,0);primitive(509,90,0);
primitive(510,40,0);primitive(511,41,0);primitive(512,61,0);
primitive(513,16,0);primitive(504,107,0);primitive(514,15,0);
primitive(515,92,0);primitive(505,67,0);primitive(516,62,0);
hash[2616].rh:=516;eqtb[2616]:=eqtb[cur_val];primitive(517,102,0);
primitive(518,88,0);primitive(519,77,0);primitive(520,32,0);
primitive(521,36,0);primitive(522,39,0);primitive(330,37,0);
primitive(351,18,0);primitive(523,46,0);primitive(524,17,0);
primitive(525,54,0);primitive(526,91,0);primitive(527,34,0);
primitive(528,65,0);primitive(529,103,0);primitive(335,55,0);
primitive(530,63,0);primitive(408,84,0);primitive(531,42,0);
primitive(532,80,0);primitive(533,66,0);primitive(534,96,0);
primitive(535,0,256);hash[2621].rh:=535;eqtb[2621]:=eqtb[cur_val];
primitive(536,98,0);primitive(537,109,0);primitive(407,71,0);
primitive(352,38,0);primitive(538,33,0);primitive(539,56,0);
primitive(540,35,0);{:265}{334:}primitive(597,13,256);par_loc:=cur_val;
par_token:=4095+par_loc;{:334}{376:}primitive(629,104,0);
primitive(630,104,1);{:376}{384:}primitive(631,110,0);
primitive(632,110,1);primitive(633,110,2);primitive(634,110,3);
primitive(635,110,4);{:384}{411:}primitive(476,89,0);
primitive(500,89,1);primitive(395,89,2);primitive(396,89,3);
{:411}{416:}primitive(668,79,102);primitive(669,79,1);
primitive(670,82,0);primitive(671,82,1);primitive(672,83,1);
primitive(673,83,3);primitive(674,83,2);primitive(675,70,0);
primitive(676,70,1);primitive(677,70,2);primitive(678,70,3);
primitive(679,70,4);{:416}{468:}primitive(735,108,0);
primitive(736,108,1);primitive(737,108,2);primitive(738,108,3);
primitive(739,108,4);primitive(740,108,5);
{:468}{487:}primitive(756,105,0);primitive(757,105,1);
primitive(758,105,2);primitive(759,105,3);primitive(760,105,4);
primitive(761,105,5);primitive(762,105,6);primitive(763,105,7);
primitive(764,105,8);primitive(765,105,9);primitive(766,105,10);
primitive(767,105,11);primitive(768,105,12);primitive(769,105,13);
primitive(770,105,14);primitive(771,105,15);primitive(772,105,16);
{:487}{491:}primitive(773,106,2);hash[2618].rh:=773;
eqtb[2618]:=eqtb[cur_val];primitive(774,106,4);primitive(775,106,3);
{:491}{553:}primitive(800,87,0);hash[2624].rh:=800;
eqtb[2624]:=eqtb[cur_val];{:553}{780:}primitive(897,4,256);
primitive(898,5,257);hash[2615].rh:=898;eqtb[2615]:=eqtb[cur_val];
primitive(899,5,258);hash[2619].rh:=900;hash[2620].rh:=900;
eqtb[2620].hh.b0:=9;eqtb[2620].hh.rh:=29989;eqtb[2620].hh.b1:=1;
eqtb[2619]:=eqtb[2620];eqtb[2619].hh.b0:=115;
{:780}{983:}primitive(969,81,0);primitive(970,81,1);primitive(971,81,2);
primitive(972,81,3);primitive(973,81,4);primitive(974,81,5);
primitive(975,81,6);primitive(976,81,7);
{:983}{1052:}primitive(1024,14,0);primitive(1025,14,1);
{:1052}{1058:}primitive(1026,26,4);primitive(1027,26,0);
primitive(1028,26,1);primitive(1029,26,2);primitive(1030,26,3);
primitive(1031,27,4);primitive(1032,27,0);primitive(1033,27,1);
primitive(1034,27,2);primitive(1035,27,3);primitive(336,28,5);
primitive(340,29,1);primitive(342,30,99);
{:1058}{1071:}primitive(1053,21,1);primitive(1054,21,0);
primitive(1055,22,1);primitive(1056,22,0);primitive(409,20,0);
primitive(1057,20,1);primitive(1058,20,2);primitive(964,20,3);
primitive(1059,20,4);primitive(966,20,5);primitive(1060,20,106);
primitive(1061,31,99);primitive(1062,31,100);primitive(1063,31,101);
primitive(1064,31,102);{:1071}{1088:}primitive(1079,43,1);
primitive(1080,43,0);{:1088}{1107:}primitive(1089,25,12);
primitive(1090,25,11);primitive(1091,25,10);primitive(1092,23,0);
primitive(1093,23,1);primitive(1094,24,0);primitive(1095,24,1);
{:1107}{1114:}primitive(45,47,1);primitive(349,47,0);
{:1114}{1141:}primitive(1126,48,0);primitive(1127,48,1);
{:1141}{1156:}primitive(865,50,16);primitive(866,50,17);
primitive(867,50,18);primitive(868,50,19);primitive(869,50,20);
primitive(870,50,21);primitive(871,50,22);primitive(872,50,23);
primitive(874,50,26);primitive(873,50,27);primitive(1128,51,0);
primitive(877,51,1);primitive(878,51,2);
{:1156}{1169:}primitive(860,53,0);primitive(861,53,2);
primitive(862,53,4);primitive(863,53,6);
{:1169}{1178:}primitive(1146,52,0);primitive(1147,52,1);
primitive(1148,52,2);primitive(1149,52,3);primitive(1150,52,4);
primitive(1151,52,5);{:1178}{1188:}primitive(875,49,30);
primitive(876,49,31);hash[2617].rh:=876;eqtb[2617]:=eqtb[cur_val];
{:1188}{1208:}primitive(1170,93,1);primitive(1171,93,2);
primitive(1172,93,4);primitive(1173,97,0);primitive(1174,97,1);
primitive(1175,97,2);primitive(1176,97,3);
{:1208}{1219:}primitive(1190,94,0);primitive(1191,94,1);
{:1219}{1222:}primitive(1192,95,0);primitive(1193,95,1);
primitive(1194,95,2);primitive(1195,95,3);primitive(1196,95,4);
primitive(1197,95,5);primitive(1198,95,6);
{:1222}{1230:}primitive(415,85,3983);primitive(419,85,5007);
primitive(416,85,4239);primitive(417,85,4495);primitive(418,85,4751);
primitive(477,85,5574);primitive(412,86,3935);primitive(413,86,3951);
primitive(414,86,3967);{:1230}{1250:}primitive(940,99,0);
primitive(952,99,1);{:1250}{1254:}primitive(1216,78,0);
primitive(1217,78,1);{:1254}{1262:}primitive(274,100,0);
primitive(275,100,1);primitive(276,100,2);primitive(1226,100,3);
{:1262}{1272:}primitive(1227,60,1);primitive(1228,60,0);
{:1272}{1277:}primitive(1229,58,0);primitive(1230,58,1);
{:1277}{1286:}primitive(1236,57,4239);primitive(1237,57,4495);
{:1286}{1291:}primitive(1238,19,0);primitive(1239,19,1);
primitive(1240,19,2);primitive(1241,19,3);
{:1291}{1344:}primitive(1284,59,0);primitive(594,59,1);
write_loc:=cur_val;primitive(1285,59,2);primitive(1286,59,3);
primitive(1287,59,4);primitive(1288,59,5);{:1344};
no_new_control_sequence:=true;end;{:1336}{1338:}{procedure debug_help;
label 888,10;var k,l,m,n:integer;begin while true do begin;
print_nl(1283);break(term_out);read(term_in,m);
if m<0 then goto 10 else if m=0 then begin goto 888;
888:m:=0;
['BREAKPOINT']
end else begin read(term_in,n);case m of[1339:]1:print_word(mem[n]);
2:print_int(mem[n].hh.lh);3:print_int(mem[n].hh.rh);
4:print_word(eqtb[n]);5:print_word(font_info[n]);
6:print_word(save_stack[n]);7:show_box(n);8:begin breadth_max:=10000;
depth_threshold:=pool_size-pool_ptr-10;show_node_list(n);end;
9:show_token_list(n,0,1000);10:slow_print(n);11:check_mem(n>0);
12:search_mem(n);13:begin read(term_in,l);print_cmd_chr(n,l);end;
14:for k:=0 to n do print(buffer[k]);15:begin font_in_short_display:=0;
short_display(n);end;16:panicking:=not panicking;
[:1339]others:print(63)end;end;end;10:end;}
{:1338}{:1330}{1332:}begin history:=3;rewrite(term_out,'TTY:','/O');
if ready_already=314159 then goto 1;{14:}bad:=0;
if(half_error_line<30)or(half_error_line>error_line-15)then bad:=1;
if max_print_line<60 then bad:=2;if dvi_buf_size mod 8<>0 then bad:=3;
if 1100>30000 then bad:=4;if 1777>2100 then bad:=5;
if max_in_open>=128 then bad:=6;if 30000<267 then bad:=7;
{:14}{111:}if(mem_min<>0)or(mem_max<>30000)then bad:=10;
if(mem_min>0)or(mem_max<30000)then bad:=10;
if(0>0)or(255<127)then bad:=11;if(0>0)or(65535<32767)then bad:=12;
if(0<0)or(255>65535)then bad:=13;
if(mem_min<0)or(mem_max>=65535)or(-0-mem_min>65536)then bad:=14;
if(0<0)or(font_max>255)then bad:=15;if font_max>256 then bad:=16;
if(save_size>65535)or(max_strings>65535)then bad:=17;
if buf_size>65535 then bad:=18;if 255<255 then bad:=19;
{:111}{290:}if 6976>65535 then bad:=21;
{:290}{522:}if 20>file_name_size then bad:=31;
{:522}{1249:}if 2*65535<30000-mem_min then bad:=41;
{:1249}if bad>0 then begin write_ln(term_out,
'Ouch---my internal constants have been clobbered!','---case ',bad:1);
goto 9999;end;initialize;if not get_strings_started then goto 9999;
init_prim;init_str_ptr:=str_ptr;init_pool_ptr:=pool_ptr;
fix_date_and_time;ready_already:=314159;1:{55:}selector:=17;tally:=0;
term_offset:=0;file_offset:=0;
{:55}{61:}write(term_out,'This is TeX, Version 3.1415926');
if format_ident=0 then write_ln(term_out,' (no format preloaded)')else
begin slow_print(format_ident);print_ln;end;break(term_out);
{:61}{528:}job_name:=0;name_in_progress:=false;log_opened:=false;
{:528}{533:}output_file_name:=0;{:533};
{1337:}begin{331:}begin input_ptr:=0;max_in_stack:=0;in_open:=0;
open_parens:=0;max_buf_stack:=0;param_ptr:=0;max_param_stack:=0;
first:=buf_size;repeat buffer[first]:=0;first:=first-1;until first=0;
scanner_status:=0;warning_index:=0;first:=1;cur_input.state_field:=33;
cur_input.start_field:=1;cur_input.index_field:=0;line:=0;
cur_input.name_field:=0;force_eof:=false;align_state:=1000000;
if not init_terminal then goto 9999;cur_input.limit_field:=last;
first:=last+1;end{:331};
if(format_ident=0)or(buffer[cur_input.loc_field]=38)then begin if
format_ident<>0 then initialize;if not open_fmt_file then goto 9999;
if not load_fmt_file then begin w_close(fmt_file);goto 9999;end;
w_close(fmt_file);
while(cur_input.loc_field<cur_input.limit_field)and(buffer[cur_input.
loc_field]=32)do cur_input.loc_field:=cur_input.loc_field+1;end;
if(eqtb[5311].int<0)or(eqtb[5311].int>255)then cur_input.limit_field:=
cur_input.limit_field-1 else buffer[cur_input.limit_field]:=eqtb[5311].
int;fix_date_and_time;{765:}magic_offset:=str_start[891]-9*16{:765};
{75:}if interaction=0 then selector:=16 else selector:=17{:75};
if(cur_input.loc_field<cur_input.limit_field)and(eqtb[3983+buffer[
cur_input.loc_field]].hh.rh<>0)then start_input;end{:1337};history:=0;
main_control;final_cleanup;9998:close_files_and_terminate;
9999:ready_already:=0;end.{:1332}
