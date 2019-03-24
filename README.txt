llvm-cov gcov -f -b *.gcda

lcov --directory . --base-directory . --gcov-tool ./llvm-gcov.sh --capture -o cov.info

genhtml cov.info -o output



http://logan.tw/posts/2015/04/28/check-code-coverage-with-clang-and-lcov/

Code coverage is a metric to show the code being untested. It can be considered as a hint to add more test cases. When we are writing C/C++, the most notable code coverage testing tool is gcov, which is a GCC built-in coverage testing tool. Besides, we can collect the results and generate beautiful HTML output with lcov, which is an extension to gcov. lcov was originally developed for Linux Test Project and then further extended for user space programs.

Although LLVM/Clang can generate some gcov-like files to track the code coverage, it requires some extra work to generate HTMLs with lcov. That's the reason why I am writing this post.

Build and Install Clang
To support code coverage instrumentation, we have to build LLVM and clang with compiler-rt [1]. Here are the instructions to build a nightly build:

# Checkout llvm
$ git clone http://llvm.org/git/llvm.git

# Checkout compiler-rt
$ cd llvm/projects
$ git clone http://llvm.org/git/compiler-rt.git

# Checkout clang
$ cd ../tools
$ git clone http://llvm.org/git/clang.git

# Build and install llvm and clang
$ cd ../..
$ mkdir llvm-build
$ cd llvm-build
$ ../llvm/configure --prefix="$(cd ..; pwd)/llvm-install" \
                    --enable-optimized
$ make -j8
$ make install
Create a Wrapper Script for LCOV
LLVM has a fast development speed, thus the llvm-cov command line options have been changed, and lcov can no longer recognize it. Thus, we have to create a script llvm-gcov.sh to workaround the problem:

#!/bin/bash
exec llvm-cov gcov "$@"
$ chmod +x llvm-gcov.sh
Build Your Application
To track the code coverage, clang has to instrument your application. You have to compile your application with two extra options:

-fprofile-arcs -ftest-coverage
For example, given the test.c:

#include <stdio.h>
int main(int argc, char **argv) {
  if (argc > 1) {
    printf("GOT: %s\n", argv[1]);
  }
  return 0;
}
We should compile the file with:

$ clang -fprofile-arcs -ftest-coverage test.c
You will notice that there is an extra file test.gcno being generated. It is some data structure for run-time supporting library.

Notice that if you are compiling the source code in two steps, i.e. compiling the source code with -c option, then you have to add --coverage to the LDFLAGS so that the program can linked with the run-time library properly [2]. For example,

# Compile the object file test.c
$ clang -fprofile-arcs -ftest-coverage -c test.c

# Link the program
$ clang --coverage test.o -o a.out
Run Your Application
Now, we can run the application (or the test cases.) If everything goes well, then several *.gcda will be generated.

# Run the program or the test cases.
$ ./a.out

# List the *.gcda files
$ ls *.gcda
test.gcda

# Read the *.gcda with llvm-cov
$ llvm-cov gcov -f -b test.gcda
Function 'main'
Lines executed:50.00% of 4
Branches executed:100.00% of 2
Taken at least once:50.00% of 2
No calls

File 'test.c'
Lines executed:50.00% of 4
Branches executed:100.00% of 2
Taken at least once:50.00% of 2
No calls
test.c:creating 'test.c.gcov'
Collect the Results
Finally, we can collect the results and generate HTML files. However, please notice that LLVM is generating GCOV files with old version (approximately equal to gcc 4.2), thus it is likely to be incompatible with the gcov command. As a result, we have to specify --gcov-tool while running lcov:

# Collect the code coverage results
$ lcov --directory . \
       --base-directory . \
       --gcov-tool llvm-gcov.sh \
       --capture -o cov.info

# Generate HTML files.
$ genhtml cov.info -o output
p.s. Notice that we should specify our wrapper script llvm-gcov.sh created earlier instead of llvm-cov.

Now, we can see the code coverage report at output/index.html.

Conclusion
In this post, I have introduced how to generate code coverage report with lcov while building the application with clang. Hope you enjoy this article. Feel free to let me know if you have any questions.

Troubleshooting
Can't Find libclang_rt.profile-x86_64.a
If you see following link error message, it means that you haven't built clang with compiler-rt:

/usr/bin/ld: cannot find libclang_rt.profile-x86_64.a: No such file or directory
clang-3.7: error: linker command failed with exit code 1
Link Error While Building Application
Without the --coverage option, you might see:

test.o: In function `__llvm_gcov_writeout':
test.c:(.text+0xf2): undefined reference to `llvm_gcda_start_file'
test.c:(.text+0x118): undefined reference to `llvm_gcda_emit_function'
test.c:(.text+0x12c): undefined reference to `llvm_gcda_emit_arcs'
test.c:(.text+0x131): undefined reference to `llvm_gcda_summary_info'
test.c:(.text+0x136): undefined reference to `llvm_gcda_end_file'
test.o: In function `__llvm_gcov_init':
test.c:(.text+0x1a9): undefined reference to `llvm_gcov_init'
clang-3.7: error: linker command failed with exit code 1