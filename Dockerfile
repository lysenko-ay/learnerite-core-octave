FROM docker.io/gnuoctave/octave:6.4.0

WORKDIR /usr/src/app

RUN octave-cli --eval 'pkg install "https://github.com/gnu-octave/pkg-json/archive/v1.5.0.tar.gz"'

COPY .octaverc .octaverc

COPY hooks hooks
COPY overrides overrides
