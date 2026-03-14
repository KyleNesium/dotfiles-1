# https://superuser.com/a/183980/124112
# .profile for envvars
# .bashrc for aliases/functions etc.

# Platform detection
IS_MACOS=false
IS_LINUX=false
if [[ "$(uname -s)" == "Darwin" ]]; then
  IS_MACOS=true
elif [[ "$(uname -s)" == "Linux" ]]; then
  IS_LINUX=true
fi

export CXX="clang -std=c++11 -stdlib=libc++"

# https://coderwall.com/p/-k_93g/mac-os-x-valueerror-unknown-locale-utf-8-in-python
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## Android
export ANDROID_HOME=/opt/android-sdk
if $IS_MACOS && command -v /usr/libexec/java_home &>/dev/null; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
fi

## Local
PATH="/usr/local/sbin:${PATH}"

## Haskell
PATH="${HOME}/Library/Haskell/bin:${PATH}"

## Cargo
PATH="${HOME}/.cargo/bin:${PATH}"

## Go
export GOPATH="${HOME}/Projects/go"
PATH="${GOPATH}/bin:${PATH}"

## Composer
PATH="${HOME}/.composer/vendor/bin:${PATH}"

## Python
if command -v python &>/dev/null; then
  PATH="$(python -m site --user-base)/bin:${PATH}"
elif command -v python3 &>/dev/null; then
  PATH="$(python3 -m site --user-base)/bin:${PATH}"
fi

## Maven
PATH="/opt/apache-maven-3.5.2/bin:${PATH}"

## Android-SDK
PATH="/opt/android-sdk/tools/bin:${PATH}"

# Setting PATH for Python 3.7 (macOS only)
if $IS_MACOS; then
  PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
fi

# brew coreutils
#PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"

# Final PATH export
export PATH="${PATH}"

# Rust
if [[ -f ~/.cargo/env ]]; then
  source ~/.cargo/env
fi

# PHP
## Composer
export COMPOSER_PROCESS_TIMEOUT=900
