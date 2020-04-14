# config valid for current version and patch releases of Capistrano
lock "~> 3.13.0"

set :application, "chat_app"
set :repo_url, "git@github.com:jackradian/rails-6-chat-api.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/chat_app"
set :migration_role, :app

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", ".env"

# Default value for linked_dirs is []
append :linked_dirs, ".bundle", "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# rbenv
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.7.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails sidekiq sidekiqctl puma pumactl}
set :rbenv_roles, :all # default value

# nginx
set :nginx_sudo_paths, [:nginx_log_path, :nginx_sites_enabled_dir, :nginx_sites_available_dir]
set :nginx_sudo_tasks, ['nginx:start', 'nginx:stop', 'nginx:restart', 'nginx:reload', 'nginx:configtest', 'nginx:site:add', 'nginx:site:disable', 'nginx:site:enable', 'nginx:site:remove' ]
set :app_server_socket, "#{shared_path}/tmp/sockets/puma.sock"
set :app_server_host, "127.0.0.1"
set :app_server_port, 80

# sidekiq
set :sidekiq_processes, 4
set :init_system, :systemd

set :bundle_flags,   '--quiet' # this unsets --deployment, see details in config_bundler task details
set :bundle_path,    nil
set :bundle_without, nil

namespace :deploy do
  desc 'Config bundler'
  task :config_bundler do
    on roles(/.*/) do
      execute :bundle, :config, '--local deployment true'
      execute :bundle, :config, '--local without "development test"'
      execute :bundle, :config, '--local path vendor'
    end
  end
end

before 'bundler:install', 'deploy:config_bundler'
