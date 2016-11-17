# paths
app_name = 'mrennai'
app_path = "/var/www/#{app_name}"
working_directory "#{app_path}/current"

# listen
listen "/tmp/unicorn-#{app_name}.sock", backlog: 64

# pid(Process ID) fileの位置を指定
pid "#{app_path}/current/tmp/pids/unicorn.pid"

# ワーカーの数を指定する
worker_processes 2

# リクエストのタイムアウトの秒数を指定する
timeout 15

# ダウンタイムをなくすため、アプリを事前に読み込む
preload_app true

# Unicornのログの出力先を指定する
stdout_path "log/unicorn_stdout.log"
stderr_path "log/unicorn_stderr.log"

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = "#{ server.config[:pid] }.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  if defined?(ActiveSupport::Cache::DalliStore) && Rails.cache.is_a?(ActiveSupport::Cache::DalliStore)
    Rails.cache.reset
  end
end
