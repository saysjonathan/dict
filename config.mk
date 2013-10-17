# Customize to fit you system

# paths
PREFIX = /usr/local
BINDIR = ${PREFIX}/bin
MANDIR = ${PREFIX}/share/man
MAN1DIR = ${MANDIR}/man1
DOCDIR = ${PREFIX}/share/doc/dict

INCDIR = ${PREFIX}/include
LIBDIR = ${PREFIX}/lib
VERSION = 0.1.0

# includes and libs
INCLUDES = -I. -I${INCDIR} -I/usr/include
LIBS = -L${LIBDIR} -L/usr/lib -lc

# compiler
CC = cc
CFLAGS = -g -O0 -W -Wall ${INCLUDES} -DVERSION=\"${VERSION}\"
LDFLAGS = ${LIBS} -framework CoreServices
