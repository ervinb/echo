#!/bin/bash
set -euo pipefail

setup_env_variables() {
  export COURSIER_CACHE="$SEMAPHORE_CACHE_DIR/coursier-cache"
  export DB_USER=$DATABASE_POSTGRESQL_USERNAME
  export DB_PASS=$DATABASE_POSTGRESQL_PASSWORD
}

setup_node_env() {
  nvm install
  npm install -g npm@5.2.0
  npm install
}

install_aglio() {
  local aglio_install_dir=$SEMAPHORE_CACHE_DIR/vaamo-aglio

  if [[ -x $aglio_install_dir ]]; then
    echo "Aglio is installed. No extra steps necessary."
  else
    ./scripts/semaphore/install-vaamo-aglio.sh "$aglio_install_dir"
  fi
}

main() {
  setup_env_variables
  change-java-version 1.8
  setup_node_env
  install_aglio
}

main
