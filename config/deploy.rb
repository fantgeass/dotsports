# require './config/boot'
require 'bundler/capistrano'
require 'airbrake/capistrano'
require 'rvm/capistrano'

set :rvm_ruby_string, 'ree-1.8.7'
set :rvm_type, :user
set :application, 'dotsports.ru'
set :scm, :git
set :repository, 'git://github.com/okiok/dotsports.git'
set :deploy_to, '/home/deployer/apps/dotsports'
set :user, 'deployer'
set :use_sudo, false
set :unicorn_rails, 'bundle exec unicorn'
set :unicorn_conf, "#{shared_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

role :web, '62.76.187.19'
role :app, '62.76.187.19'
role :db, '62.76.187.19', :primary => true

namespace(:customs) do
  task :config, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :symlink, :roles => :app do
    run "ln -s #{shared_path}/assets #{release_path}/public/assets"
    run "ln -s #{shared_path}/spree #{release_path}/public/spree"
  end
end

namespace :deploy do
  desc 'Start application'
  task :start, :roles => :app do
    run "cd #{current_path} && MAGICK_THREAD_LIMIT=1 #{unicorn_rails} -Dc #{unicorn_conf} -E production"
  end

  desc 'Stop application'
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc 'Restart Application'
  task :restart, :roles => :app do
    stop
    start
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run %Q{cd #{latest_release} && #{rake} RAILS_ENV=production assets:clean && #{rake} RAILS_ENV=production assets:precompile}
    end
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :app do
    run "cd #{current_path} && bundle exec whenever --update-crontab dotsports"
  end

end


after 'deploy:update_code', 'deploy:assets:precompile'
after 'deploy:finalize_update', 'customs:config'
after 'deploy:create_symlink', 'deploy:update_crontab'
after 'deploy:create_symlink', 'customs:symlink'
after 'deploy', 'deploy:cleanup'
after 'deploy', 'deploy:migrate'

