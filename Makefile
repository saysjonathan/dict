# dict - simple command line dictionary

include config.mk

SRC = dict.c
OBJ = ${SRC:.c=.o}

all: options dict
	@echo built dict

options:
	@echo dict build options:
	@echo "LIBS	= ${LIBS}"
	@echo "INCLUDES	= ${INCLUDES}"
	@echo "CFLAGS	= ${CFLAGS}"
	@echo "LDFLAGS	= ${LDFLAGS}"
	@echo "CC	= ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

dict: ${OBJ}
	@echo LD $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

install: all
	@mkdir -p ${DESTDIR}${DOCDIR}
	@mkdir -p ${DESTDIR}${BINDIR}
	@mkdir -p ${DESTDIR}${MAN1DIR}

	@install -d ${DESTDIR}${BINDIR} ${DESTDIR}${MAN1DIR}
	@install -m 755 dict ${DESTDIR}${BINDIR}
	@install -m 444 dict.1 ${DESTDIR}${MAN1DIR}
	@echo "installed dict"

uninstall: all
	@rm -f ${DESTDIR}${MANDIR}/dict.1
	@rm -rf ${DESTDIR}${DOCDIR}
	@rm -f ${DESTDIR}${BINDIR}/dict
	@echo "uninstalled dict"

clean:
	rm -f dict *~ *.o *core *.tar.gz
