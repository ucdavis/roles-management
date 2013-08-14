root = "/home/deployer/apps/dss-rm/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.dssrm.sock"
worker_processes 15
timeout 20
