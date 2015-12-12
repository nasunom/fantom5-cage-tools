FROM python:2.7
MAINTAINER nasuno@ascade.co.jp

RUN apt-get update && apt-get -y install libcurl4-nss-dev

ADD http://fantom.gsc.riken.jp/5/suppl/rRNAdust/rRNAdust1.02.tgz rRNAdust1.02.tgz
RUN tar zxf rRNAdust1.02.tgz
RUN cd rRNAfilter && sed -i 's/\$(CC) \$(CFLAGS) \$(LD) \$(OBJECTS) -o \$(PROGS)/\$(CC) -o \$(PROGS) \$(OBJECTS) \$(CFLAGS) \$(LD)/' Makefile
RUN cd rRNAfilter; make && mv rRNAdust /usr/local/bin/
RUN rm -rf rRNAdust1.02.tgz rRNAfilter

ADD http://fantom.gsc.riken.jp/5/suppl/delve/delve.tgz delve.tgz
RUN tar zxf delve.tgz
RUN cd delve/src && sed -i 's/\$(CC) \$(CFLAGS) \$(LD) \$(OBJECTS) -o \$(PROGS)/\$(CC) -o \$(PROGS) \$(OBJECTS) \$(CFLAGS) \$(LD)/' Makefile
RUN cd delve/src; make && mv delve /usr/local/bin/
RUN rm -rf delve*

# RUN apt-get -y install make gcc zlib1g-dev libncurses5-dev

ADD https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2 samtools-1.2.tar.bz2
RUN tar jxf samtools-1.2.tar.bz2
RUN cd samtools-1.2 && make && mv samtools /usr/local/bin/
RUN rm -rf samtools-1.2*

ADD https://github.com/arq5x/bedtools2/releases/download/v2.23.0/bedtools-2.23.0.tar.gz
RUN tar zxf bedtools-2.23.0.tar.gz
RUN cd bedtools2 && make && make install
RUN rm -rf bedtools*

ADD http://fantom.gsc.riken.jp/5/suppl/aln_filter/src/Makefile
ADD http://fantom.gsc.riken.jp/5/suppl/aln_filter/src/main.c
ADD http://fantom.gsc.riken.jp/5/suppl/aln_filter/src/aln_filter.h
ADD http://fantom.gsc.riken.jp/5/suppl/aln_filter/src/interface.h
ADD http://fantom.gsc.riken.jp/5/suppl/aln_filter/src/interface.c
RUN make && mv aln_filter /usr/local/bin/
RUN rm -f Makefile main.c aln_filter.h interface.[ch]
