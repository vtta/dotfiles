
usegcc() {
  HOMEBREW_GCC_VERSION=8;
  export CXX="/usr/local/bin/g++-${HOMEBREW_GCC_VERSION}"
  export CPP="/usr/local/bin/cpp-${HOMEBREW_GCC_VERSION}"
  export CC="/usr/local/bin/gcc-${HOMEBREW_GCC_VERSION}"
  export LD="/usr/local/bin/gcc-${HOMEBREW_GCC_VERSION}"
  alias g++="\${CXX}"
  alias c++="\${CXX}"
  alias cpp="\${CPP}"
  alias gcc="\${CC}"
  alias cc="\${CC}"
  alias ld="\${LD}"
}

useclang() {
  export CXX="/usr/bin/g++"
  export CPP="/usr/bin/cpp"
  export CC="/usr/bin/gcc"
  export LD="/usr/bin/ld"
  alias g++="\${CXX}"
  alias c++="/usr/bin/c++"
  alias cpp="\${CPP}"
  alias gcc="\${CC}"
  alias cc="\${CC}"
  alias ld="\${LD}"
}

