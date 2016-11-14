# This file is used by Rack-based servers to start the application.

# Unicorn self-process killer
require 'unicorn/worker_killer'

# Max requests per worker
use Unicorn::WorkerKiller::MaxRequests, 100, 120, true

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
