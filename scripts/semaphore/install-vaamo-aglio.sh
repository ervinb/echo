#!/bin/bash

readonly PROGNAME=$(basename $0)

install() {
  local target_dir="$1"
  mkdir $target_dir
  git clone https://github.com/Vaamo/aglio.git $target_dir 
  pushd $target_dir
  npm install grunt-cli
  npm install
  ln -s aglio.js ./bin/aglio
  popd
}

update() {
  local target_dir="$1"
  pushd $target_dir
  git pull
  npm install
  popd

}

is_not_empty() {
  local var=$1

  [[ ! -z $var ]]
}

is_dir() {
    local dir=$1

    [[ -d $dir ]]
}

main() {
  local custom_install_dir=$1
  local install_dir=${custom_install_dir:-./vaamo-aglio}
  if is_dir $install_dir; then
    echo "Updating aglio $install_dir"
    update $install_dir
  else 
    echo "Installing aglio to $install_dir"
    install $install_dir
    echo "Run aglio bin: $target_dir/bin/aglio"
  fi
}

main $@

