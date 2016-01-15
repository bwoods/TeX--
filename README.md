# TeX--

Based upon version 3.1415926 of [tex.web](web/tex.web). The main goal was getting TeX’s massive number of symbols out of the global scope; making it easy to embed.

## Features

Only `plain.tex`, `hyphen.tex`, the `.tfm` files, and TeX itself are included. So **everything else** is left out. This is an embedded TeX engine, not a TeX installation. The macro packages to be shipped with an application should be decided on a per-application basis; not by this project.

## A simple example

Add the `tex` and `tfm` folders to your application. Copy the `tex.pool` file into your application’s `tex` folder. Include the `tex.hpp` header file, then it’s as simple as

```c++ 
	tex::plain typesetter;
	typesetter.typeset(filepath);
```

This example assumes that all the needed files and folders are in your application’s current working directory.

## API

### tex::tex

The `tex` base class encapsulates the actual TeX engine. It isn’t intended to be used directly. All of its file opening methods are virtual to allow subclasses explicit control over where files are found. Additionally, subclasses can use the `getopt` method to customize their behavior based upon arguments passed into `typeset`.

### tex::plain

The `plain` class exists both as an easy way to typeset [plainTeX](http://www.ntg.nl/doc/wilkins/pllong.pdf) documents and as an example of how to subclass the `tex` class. 

There are four overloaded `typeset` methods.

```c++
void typeset(string filename, ostream& result, string search_dir, string working_dir, ostream& output);
void typeset(string filename, string search_dir, string working_dir, ostream& output);
void typeset(istream& input, ostream& result, string search_dir, string working_dir, ostream& output);
void typeset(istream& input, string search_dir, string working_dir, ostream& output);
```

The `filename` or `input` parameter points to the `.tex` file that is to be typeset. It is obviously required. `output` is a `std::ostream` that TeX writes its console log output to; it defaults to `std::clog`. Applications wishing to ignore this output can pass in an `std::iostream` initialized with `nullptr`. All writes to such a stream are ignored.

`search_dir` is the path where the `tex` and `tfm` folders are stored. `working_dir` tells TeX where to write its auxiliary files: `.log`, `.toc`, etc. Both paths default to the application’s current working directory if they are not explicitly given.

Any additional macro files needed by the application should be stored in the `.tex` folder. Although, if they are in the `search_dir` directly, they will be found.

## A better example

```objc
// An iOS example showing the .tex file coming from a bundle…
const char * filename = [[NSBundle bundleForClass:self.class] pathForResource:@"story" ofType:@"tex"].fileSystemRepresentation;

// …and the .tex and .tfm folders in the application
const char * search_dir = [NSBundle mainBundle].bundlePath.fileSystemRepresentation;
const char * working_dir = NSTemporaryDirectory().fileSystemRepresentation;

// Obviously, this must be in an Objective-C++ file
std::ifstream tex_file(filename, std::ios::in);
std::iostream ignore_output(nullptr); // not a good idea, but here is how to do it…
std::ostringstream dvi_file;

tex::plain typesetter;
typesetter.typeset(tex_file, dvi_file, search_dir, working_dir, ignore_output);
```

## Development

Creation of the header file is done through the [`tex.sh`](web/tex.sh) shell script, so that it can be regenerated at any time. No manual clean-up or restructuring of the code has been done. Some *automated* transformations of the code are done in the shell script. Primarily to replace certain C constructs with C++ equivalents.

If you plan on forking/cloning this project, note that only the `master` branch will keep a nice, linear history. Any other branches will be rebased at will. *Caveat Furcator*.

## License [![License](http://img.shields.io/badge/license-MIT-blue.svg)](http://opensource.org/licenses/MIT)

Copyright (c) 2013 Bryan Woods

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

