.PHONY: all clean fmt docs install
.SUFFIXES:
.SUFFIXES: .1 .pod .in .cxx .o

## Configuration ##
OPTIM_FLAG     ?= -Og -g
CURL_LIBS      ?= -lcurl
CURL_INCPATH   ?= 
INSTALL_PREFIX ?= /usr/local

## Internal Variables ##
EXTRA_INC  := ${CURL_INCPATH}
CFLAGS     := -Wall -Wextra -Wpedantic -std=c++17 ${OPTIM_FLAG} ${EXTRA_INC}
LIBS       := ${CURL_LIBS}

TARGET  := ii
VERSION := 0.1.0

SRC  != perl -MFile::Find=find -MCwd=cwd -e 'find sub { print $$File::Find::name if /.+\.cxx$$/ }, cwd'
CONF != perl -MFile::Find=find -MCwd=cwd -e 'find sub { print $$File::Find::name if /.+\.in$$/ }, cwd'
OBJ  := ${SRC:.cxx=.o} ${CONF:.in=.o}

POD != perl -MFile::Find=find -MCwd=cwd -e 'find sub { print $$File::Find::name if /.+\.pod$$/ }, cwd'
MAN := ${POD:.pod=.1}

## named rules ##
all: ${TARGET} docs

fmt:
	clang-format -i ${SRC} ${CONF} -style="{BasedOnStyle: GNU, ColumnLimit: 0}"

clean:
	perl -e 'for (@ARGV) { unlink if -e }' ${OBJ} ${CONF:.in=.cxx} ${TARGET} ${TARGET}.exe ${MAN}

docs: ${MAN}

install: all
	cp ${TARGET}* ${INSTALL_PREFIX}/bin
	cp ${MAN} ${INSTALL_PREFIX}/share/man/man1

## expanded rules ##
${TARGET}: ${OBJ}
	${CXX} -o $@ ${OBJ} ${LIBS}

## suffix rules ##
.pod.1:
	pod2man $< $@

.cxx.o:
	${CXX} -c -o $@ ${CFLAGS} $<

.in.cxx:
	perl -MFile::Copy=copy -e 'copy "$<", "$@"'
	perl -i -pe 's/\@VERSION\@/${VERSION}/' $@
