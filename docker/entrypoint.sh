#!/bin/bash

set -eoux pipefail

bundle install
rails db:migrate
exec "$@"