{ stdenv, fetchFromGitHub, gcc, gmp, libsigsegv, openssl, automake, autoconf,
  ragel, cmake, re2c, libtool, ncurses, perl, zlib, python2, curl }:

stdenv.mkDerivation rec {
  name = "urbit-${version}";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "urbit";
    repo = "urbit";
    url = "https://github.com/urbit/urbit.git";
    rev = "fa981e788b8a8573b82b1cb9233a60b598e55817";
    sha256 = "0warsknpas79zshjxipklq5c3j3sns35cg1gcysm9f7r4zqs2zrk";
  };

  buildInputs = with stdenv.lib; [
    gcc gmp libsigsegv openssl automake autoconf ragel cmake re2c libtool
    ncurses perl zlib python2 curl
  ];

  # uses 'readdir_r' deprecated by glibc 2.24
  NIX_CFLAGS_COMPILE = "-Wno-error=deprecated-declarations";

  configurePhase = ''
    :
  '';

  buildPhase = ''
    sed -i 's/-lcurses/-lncurses/' Makefile
    mkdir -p $out
    cp -r . $out/
    cd $out
    make
  '';

  installPhase = ''
    :
  '';

  meta = with stdenv.lib; {
    description = "An operating function";
    homepage = http://urbit.org;
    license = licenses.mit;
    maintainers = with maintainers; [ mudri ];
    platforms = with platforms; linux;
  };
}
