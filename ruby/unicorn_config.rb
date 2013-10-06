#worker_processes 10
#preload_app true
@dir = "/home/isucon/webapp/ruby/"
working_directory @dir

listen "#{@dir}tmp/sockets/unicorn.sock", backlog: 1024
pid "#{@dir}tmp/pids/unicorn.pid"
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"

worker_processes 8 # CPUの数 * 2 ぐらい？
timeout 60 # default: 60

preload_app true # allow copy-on-write-friendly GC to save memory
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

after_fork do |server, worker|
  GC.disable
end

# Below is for ActiveRecord
=begin
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
=end
#
