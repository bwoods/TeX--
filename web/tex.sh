#!/bin/bash

# converts the output from 2pc, tex.c, into a C++ class, tex.hpp

../p2c/p2c -c p2c.options tex.p

tex_source_code=$(<tex.c)

cat > tex.hpp <<EOF
// Τεχ82 encapsulated in a C++ class
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

#include <array>
#include <string>
#include <stdexcept>


namespace tex {

class tex {

protected:

template<class File>
static void read_ln(File& file)
{
	int character = fgetc(file.f);
	assert(character == '\n');
}

template<class File>
static void write_ln(File& file)
{
	fputc('\n', file.f);
}

template<class File>
static void write_ln(File& file, const char * s)
{
	fputs(s, file.f);
	fputc('\n', file.f);
}

template<class File>
static void write_ln(File& file, const char * s, const char * t)
{
	fprintf(file.f, "%s %s\n", s, t);
}

template<class File>
static void write_ln(File& file, const char * s, const char * t, int n)
{
	fprintf(file.f, "%s %s %i\n", s, t, n);
}

template<class File>
static int erstat(File& file)
{
	return file.f == nullptr or ferror(file.f);
}

template<class File>
static void break_in(File& file, bool)
{
	fpurge(file.f);
}

static bool eoln(FILE * f)
{
	int character = fgetc(f);
	if (character == EOF)
		return true;

	ungetc(character, f);
	return (character == '\n');
}

static int peek(FILE * f)
{
	int character = fgetc(f);
	if (character == EOF)
		return EOF;

	ungetc(character, f);
	return (character == '\n') ? ' ' : character;
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

FILE * input_stream; // stores the command line args

virtual void getopt(int argc, const char * const * argv)
{
	input_stream = tmpfile(); // will be closed as term_in.f

	for (int i = 0; i < argc; ++i)
		fputs(" ", input_stream), // must come first, the first character is always skipped…
		fputs(argv[i], input_stream);

	fflush(input_stream);
	fseek(input_stream, 0, SEEK_SET);
}

public:

virtual void typeset(const std::initializer_list<const char *>& args)
{
	typeset(args.size(), args.begin());
}

virtual ~tex() = default;

};


class plain : public tex {
	
std::string output_path; // directory to store output files in

bool a_open_in(alpha_file *f) override
{
	bool found = tex::a_open_in(f);

	if (found == false) {
		std::string absolute_path = output_path + name_of_file; // look in the output directory; intermediate files will be found there
		strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

		found = tex::a_open_in(f);
	}
	
	return found;
}

bool a_open_out(alpha_file *f) override
{
	std::string absolute_path = output_path + name_of_file;
	strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

	return tex::a_open_out(f);
}

bool b_open_out(byte_file *f) override
{
	std::string absolute_path = output_path + name_of_file;
	strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

	return tex::b_open_out(f);
}

bool w_open_out(word_file *f) override
{
	std::string absolute_path = output_path + name_of_file;
	strncpy(name_of_file, absolute_path.c_str(), file_name_size - 1);

	return tex::w_open_out(f);
}


public:

virtual void typeset(const std::string& filename, std::string output_path = "")
{
	auto args = {
#ifdef DEBUG
		R"(\\nonstopmode)", // omits all stops
#else
		R"(\\batchmode)", // omits all stops and omits terminal output
#endif
		R"(\\input plain)",
		R"(\\input)", filename.c_str(),
		R"(\\end)",
	};

	if (output_path.empty() == false and output_path.back() != '/')
		output_path.push_back('/');
	this->output_path = output_path;
	
	tex::typeset(args);
}
	
};

} // end namespace ‘tex’


EOF


# make these methods virtual
sed -i.bak -E 's/bool a_open_in\(/virtual bool a_open_in\(/' tex.hpp
sed -i.bak -E 's/bool b_open_in\(/virtual bool b_open_in\(/' tex.hpp
sed -i.bak -E 's/bool w_open_in\(/virtual bool w_open_in\(/' tex.hpp
sed -i.bak -E 's/bool a_open_out\(/virtual bool a_open_out\(/' tex.hpp
sed -i.bak -E 's/bool b_open_out\(/virtual bool b_open_out\(/' tex.hpp
sed -i.bak -E 's/bool w_open_out\(/virtual bool w_open_out\(/' tex.hpp

# replace #defines with constexpr statics
sed -i.bak -E 's/^#define ([a-z_]+) "([^"]+)"$/constexpr static const char * \1 = "\2";/' tex.hpp
sed -i.bak -E 's/^#define ([a-z_]+) ([0-9]+)$/constexpr static int \1 = \2;/' tex.hpp

# fix-up terminal streams
sed -i.bak -E 's/fopen\(term_in.name, "rb"\)/input_stream/' tex.hpp
sed -i.bak -E 's/fopen\(term_out.name, "wb"\)/stdout/' tex.hpp
sed -i.bak -E 's/fclose\(term_out.f\)/fflush\(term_out.f\)/' tex.hpp 

# un-pad the string constants
sed -i.bak -E 's/[ ]{2,}"/"/' tex.hpp

# better default filename strings
sed -i.bak -E 's/"TeXformats:/"tex\//' tex.hpp
sed -i.bak -E 's/TEX.POOL/tex.pool/' tex.hpp

# need enough room for absolute paths
sed -i.bak -E 's/file_name_size = [0-9]+/file_name_size = PATH_MAX/' tex.hpp

# replace Knuth’s ‘case: others:’ with C’s ‘default:’
sed -i.bak -E 's/case others:/default:/' tex.hpp

# entry and exit points
sed -i.bak -E 's/int main\(int argc, char \*argv\[\]\)/virtual void typeset\(int argc, const char \* const \* argv\)/' tex.hpp
sed -i.bak -E 's/exit\(EXIT_SUCCESS\)/\
	return/' tex.hpp

rm tex.hpp.bak
rm tex.c

