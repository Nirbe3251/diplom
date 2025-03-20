#!/bin/bash

set -eoux pipefail
npm install
bundle install
rails db:migrate
exec "$@"