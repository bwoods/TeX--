#!/bin/bash
# converts the output from 2pc, tex.c, into a C++ class, tex.hpp

../p2c/p2c -c p2c.options tex.p

# make these methods virtual
sed -i.bak -E '{
	s/(void open_log_file)/virtual \1/

	# …and have these take the pointer by reference
	s/(bool a_open_in\(FILE \*)/virtual \1\& /
	s/(bool b_open_in\(FILE \*)/virtual \1\& /
	s/(bool w_open_in\(FILE \*)/virtual \1\& /
	s/(bool a_open_out\(FILE \*)/virtual \1\& /
	s/(bool b_open_out\(FILE \*)/virtual \1\& /
	s/(bool w_open_out\(FILE \*)/virtual \1\& /
	s/(void a_close\(FILE \*)/virtual \1\& /
	s/(void b_close\(FILE \*)/virtual \1\& /
	s/(void w_close\(FILE \*)/virtual \1\& /
}' tex.c

# use C++ iostreams, rather than FILE *’s
sed -i.bak -E '{
	s/FILE /std::iostream /
	s/WRITE\(([][a-zA-Z0-9_]+), ([][a-zA-Z0-9_[:punct:]\ ]+)\)/\*\1 << \2/
	s/write_ln\(([][a-zA-Z0-9_]+)\)/\*\1 << std::endl/
	s/write_ln\(([][a-zA-Z0-9_]+), ("[^"]+")\)/\*\1 << \2 << std::endl/
	s/write_ln\(([][a-zA-Z0-9_]+), ("[^"]+"), ("[^"]+")\)/\*\1 << \2 << \3 << std::endl/
	s/write_ln\(([][a-zA-Z0-9_]+), ("[^"]+"), ("[^"]+"), ([][a-zA-Z0-9_]+)\)/\*\1 << \2 << \3 << \4 << std::endl/
	s/fwrite\(([][\&a-zA-Z0-9_+-\ ]+), ([a-zA-Z0-9()_]+), ([a-zA-Z0-9_]+), ([][a-zA-Z0-9_]+)\)/\4->write(reinterpret_cast<const char *>(\1), \2)/
	s/read_ln\(([][a-zA-Z0-9_]+)\);/\1->ignore(); \/\/ skip the newline/
	s/fread\(([][\&a-zA-Z0-9_+-\ ]+), ([a-zA-Z0-9()_]+), ([a-zA-Z0-9_]+), ([][a-zA-Z0-9_]+)\)/\4->read(reinterpret_cast<char *>(\1), \2)/
	s/fflush\(([a-zA-Z0-9_]+)\);/\1->flush();/
	s/fpeek\(([a-zA-Z0-9_]+)\)/\1->peek()/
	s/fgetc\(([a-zA-Z0-9_]+)\)/\1->get()/
	s/feof\(([a-zA-Z0-9_]+)\)/\1->eof()/
}' tex.c

# don’t overwrite the supplied iostream
sed -i.bak -E '{
	s/(!b_open_out\(dvi_file\))/!dvi_file and \1/
}' tex.c

# redirect input and output to the appropriate iostreams
sed -i.bak -E '
{
	s/fopen\("TTY:", "rb"\)/input_stream/
	s/fopen\("TTY:", "wb"\)/output_stream/
}' tex.c

# split the declaration
sed -i.bak -E '{
	s/(pool_pointer) (str_start\[max_strings \+ 1\]), (pool_ptr);/\1 \2;\
\1 \3;/
}' tex.c

# move the buffers into std::vectors
sed -i.bak -E '{
	s/ASCII_code buffer\[buf_size \+ 1\];/std::vector<ASCII_code> buffer;/
	s/hyph_pointer z;/hyph_pointer z;\
	buffer.resize(buf_size + 1);/
	
	s/pool_pointer str_start\[max_strings \+ 1\];/std::vector<pool_pointer> str_start;/
	s/hyph_pointer z;/hyph_pointer z;\
	str_start.resize(max_strings + 1);/
	
	s/eight_bits dvi_buf\[dvi_buf_size \+ 1\];/std::vector<eight_bits> dvi_buf;/
	s/hyph_pointer z;/hyph_pointer z;\
	dvi_buf.resize(dvi_buf_size + 1);/
	
	s/packed_ASCII_code str_pool\[pool_size \+ 1\];/std::vector<packed_ASCII_code> str_pool;/
	s/hyph_pointer z;/hyph_pointer z;\
	str_pool.resize(pool_size + 1);/
	
	s/memory_word font_info\[font_mem_size \+ 1\];/std::vector<memory_word> font_info;/
	s/hyph_pointer z;/hyph_pointer z;\
	font_info.resize(font_mem_size + 1);/
	
	s/memory_word mem\[mem_max - mem_min \+ 1\];/std::vector<memory_word> mem;/
	s/hyph_pointer z;/hyph_pointer z;\
	\
	mem.resize(mem_max - mem_min + 1);/
}' tex.c

# use std::bitset<> rather than a byte array and manual bit operations
sed -i.bak -E 's/uint8_t trie_taken\[\(trie_size \+ 7\) \/ 8\]/std::bitset<trie_size> trie_taken/' tex.c

# replace #defines with constexpr statics
sed -i.bak -E 's/^#define ([a-z_]+) (.+)$/constexpr static auto \1 = \2;/' tex.c
sed -i.bak -E '/bad = 0;/,/}/d' tex.c

# change the character-set arrays to allow all eight-bits
sed -i.bak -E '/xchr\[32\] = /,/for \(i = 0; i <= 126; \+\+i\)/D;s/	xord\[xchr\[i\]\] = i;/std::iota\(xchr, xchr+255, 0\);\
	std::iota\(xord, xord+255, 0\);\
/
	s/i, k;/k;/' tex.c # since ‘i’ is now unused…

# streams pointers are initialized to nullptr in the constructor instead
sed -i.bak -E '{
	/fmt_file = nullptr;/,/term_in = nullptr;/d
}' tex.c

# clean up the typedefs by removing the extra line between them
sed -i.bak -E '{
	s/integer__________________________________________/integer/g
	s/												  /	/g
}' tex.c
sed -i.bak -E '/^typedef [^{]+$/N; s/\n//' tex.c
sed -i.bak -E '/^typedef [^{]+$/N; s/(typedef struct)/\
\1/' tex.c

# better default filename strings
sed -i.bak -E '{
	s/"TeXformats:/"tex\//
	s/TEX.POOL/tex.pool/
}' tex.c
sed -i.bak -E '{
	s/10TeXinputs:/04tex\//
	s/09TeXfonts:/04tfm\//
}' tex.pool
rm tex.pool.bak

# replace Knuth’s ‘case: others:’ with C’s ‘default:’
sed -i.bak -E 's/case others:/default:/' tex.c

# entry and exit points
sed -i.bak -E '{
	s/int main\(int argc, char \*argv\[\]\)/virtual void typeset\(const std::initializer_list<const char \*>\& args\)/
	s/getopt\(argc, argv\);/getopt\(args\);/
	s/exit\(EXIT_SUCCESS\)/\
	return/
}' tex.c

# p2c bug work-around: when StructFiles=0, p2c forgets to RESETBUF
sed -i.bak -E 's/file_opened = true;/file_opened = true; tfm_file_mode = 1;/' tex.c

# inline the I/O macros
cpp -C -P -ansi tex.c tex.d
sed -i.bak -E '{ # remove the blank lines and #’s left by cpp
	/./,/^$/!d
	s/##//g
}' tex.d

tex_source_code=$(<tex.d)

cat > tex.hpp <<EOH
//
// Copyright (c) 2013 Bryan Woods
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include <math.h>
#include <limits.h>
#include <assert.h>

#include <errno.h>
#include <setjmp.h>

#include <string>
#include <vector>
#include <bitset>
#include <memory>
#include <numeric>
#include <stdexcept>

#include <iostream>
#include <sstream>
#include <fstream>


namespace tex {

class tex {

protected:

template<typename T>
void get(std::iostream * ios, int& mode, T * value)
{
	if (mode == 1)
		ios->read(reinterpret_cast<char *>(value), sizeof(T));
	else
		mode = 1;
}

template<typename T>
T& getfbuf(std::iostream * ios, int& mode, T * value)
{
	if (mode == 1) {
		mode = 2;
		ios->read(reinterpret_cast<char *>(value), sizeof(T));
	}

	return *value;
}

template<typename T>
void put(std::iostream * ios, int& mode, T * value)
{
	ios->write(reinterpret_cast<const char *>(value), sizeof(T));
	mode = 0;
}

static int erstat(std::iostream * ios)
{
	return ios == nullptr or ios->bad() or ios->fail();
}

static void break_in(std::iostream * ios, bool)
{

}

static bool eoln(std::iostream * ios)
{
	int character = ios->peek();
	return (character == EOF or character == '\n');
}

static const char * trim_name(char * filename, size_t length) // never called on a string literal; note the lack of a const
{
	for (char * p = filename + length - 1; *p == ' '; --p)
		*p = '\0';

	return filename;
}

static void io_error(int error, const char * name)
{

}

${tex_source_code}


static std::iostream * fopen(const char * name, const char * mode)
{
	// auto file = std::make_unique<std::fstream>(name, (mode[0] == 'r' ? std::ios::in|std::ios::binary : std::ios::out|std::ios::binary|std::ios::trunc));
	std::unique_ptr<std::fstream> file(new std::fstream(name, (mode[0] == 'r' ? std::ios::in|std::ios::binary : std::ios::out|std::ios::binary|std::ios::trunc)));
	if (erstat(file.get()))
		return nullptr;

	return file.release();
}

static void fclose(std::iostream *& ios)
{
	delete ios;
	ios = nullptr;
}


std::iostream * output_stream; // displays the logging messages
std::iostream * input_stream; // stores the command line args

virtual void getopt(const std::initializer_list<const char *>& args)
{
	for (auto arg : args)
		*input_stream << ' ' << arg; // ' ' must come first, the first character is always skipped…
}

// inexplicably, p2c forgets these
int tfm_file_mode;
uint8_t tfm_file_value;
int fmt_file_mode;
memory_word fmt_file_value;

tex() : fmt_file_value({ 0 }), tfm_file_mode(0), tfm_file_value(0), fmt_file_mode(0), // clear members added above
		fmt_file(nullptr), tfm_file(nullptr), dvi_file(nullptr), log_file(nullptr), pool_file(nullptr), term_out(nullptr), term_in(nullptr)  // clear file pointers
{
	
}

virtual ~tex() = default;

};

class plain : public tex {

std::streambuf * inputfile_streambuf; // optional stream-based replacement for filename
std::string output_path; // directory to store output files in
std::string input_path; // directory to search input files for

bool a_open_in(std::iostream *& ios) override
{
	bool found = tex::a_open_in(ios);

	if (found == false && strncmp("null.tex", name_of_file, 8) == 0) {
		ios = new std::iostream(inputfile_streambuf); // handle the input file passed in as a stream (rather than a filename)

		found = true;
	}

	if (found == false) {
		const std::string& absolute_path = input_path + name_of_file; // look relative to the the input directory; user macro definitions will be found there
		strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

		found = tex::a_open_in(ios);
	}

	if (found == false) {
		const std::string& absolute_path = output_path + name_of_file; // look in the output directory; intermediate files will be found there
		strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

		found = tex::a_open_in(ios);
	}

	return found;
}

bool b_open_in(std::iostream *& ios) override
{
	bool found = tex::a_open_in(ios);

	if (found == false) {
		const std::string& absolute_path = input_path + name_of_file;
		strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

		found = tex::a_open_in(ios);
	}

	return found;
}

bool a_open_out(std::iostream *& ios) override
{
	std::string absolute_path = output_path + name_of_file;
	strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

	return tex::a_open_out(ios);
}

bool b_open_out(std::iostream *& ios) override
{
	std::string absolute_path = output_path + name_of_file;
	strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

	return tex::b_open_out(ios);
}

bool w_open_out(std::iostream *& ios) override
{
	std::string absolute_path = output_path + name_of_file;
	strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

	return tex::w_open_out(ios);
}

void open_log_file() override
{
	log_file = new std::iostream(nullptr); // we already capture the term_out as a stream; a file based copy is unnecessary
}

virtual void typeset(const std::string& filename, std::streambuf * resultbuf, const std::string& search_dir, const std::string& working_dir, std::ostream& output)
{
	input_path = search_dir;
	if (input_path.empty() == false and input_path.back() != '/')
		input_path.push_back('/');

	output_path = working_dir;
	if (output_path.empty() == false and output_path.back() != '/')
		output_path.push_back('/');

	input_stream = new std::stringstream; // will be closed as term_in
	output_stream = new std::iostream(output.rdbuf()); // will be closed as term_out

	if (resultbuf) {
		dvi_file = new std::stringstream;
		dvi_file->rdbuf(resultbuf);
	}

	tex::typeset({
		R"(\nonstopmode)", // omits all stops (\batchmode also omits terminal output)
		R"(\input plain)",
		R"(\input)", filename.c_str(),
		R"(\end)",
	});
}


public:

virtual void typeset(const std::string& filename, std::ostream& result, const std::string& search_dir = "", const std::string& working_dir = "", std::ostream& output = std::clog)
{
	typeset(filename, result.rdbuf(), search_dir, working_dir, output);
}

virtual void typeset(const std::string& filename, const std::string& search_dir = "", const std::string& working_dir = "", std::ostream& output = std::clog)
{
	typeset(filename, nullptr, search_dir, working_dir, output);
}

virtual void typeset(std::istream& input, std::ostream& result, const std::string& search_dir = "", const std::string& working_dir = "", std::ostream& output = std::clog)
{
	inputfile_streambuf = input.rdbuf();
	typeset("null", result.rdbuf(), search_dir, working_dir, output);
}

virtual void typeset(std::istream& input, const std::string& search_dir = "", const std::string& working_dir = "", std::ostream& output = std::clog)
{
	inputfile_streambuf = input.rdbuf();
	typeset("null", nullptr, search_dir, working_dir, output);
}

};

} // end namespace ‘tex’


EOH

rm tex.c.bak tex.c
rm tex.d.bak tex.d
