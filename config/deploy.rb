# config valid only for current version of Capistrano
lock '3.8.0'

set :application, 'kijochannel'
set :repo_url, 'git@github.com:ryosuke-endo/kijochannel.git'
set :user, 'mikami'

set :user_sudo, false
set :branch, 'master'
set :deloy_via, :remote_cache
set :deploy_to, "/var/www/#{fetch(:application)}"
set :scm, :git
# log levelの設定
set :log_level, :debug
set :format, :pretty
# ssh -tを実行する
set :pty, true

set :linked_files, %w(config/database.yml config/secrets.yml)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

# Default value for default_env is {}
set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

# rbenv
set :rbenv_type, :system
set :rbenv_ruby, '2.3.1'
set :rbenv_path, '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# nvm
set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v7.7.4'
set :nvm_map_bins, %w{node npm yarn}

# whenever cron update
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

# ssh
set :ssh_options, {
  user: fetch(:user),
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true
}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Upload'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
      upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end

  # before :starting, 'deploy:upload'
  after :publishing, 'deploy:restart'
end
