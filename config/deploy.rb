require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/puma'

set :application_name, 'Todo List'

set :domain, '52.59.66.253'
set :deploy_to, '/home/ubuntu/projects/todo_api'
set :branch, 'dev'
set :user, 'ubuntu'
set :rails_env, 'production'
set :repository, 'git@github.com:edlvj/todo_api.git'
#set :forward_agent, true
#set :term_mode, nil

#set :rvm_path, '/home/deploy/.rvm'

set :shared_paths, [
  'config/database.yml',
  'config/secrets.yml',
  'public/uploads',
  'tmp/pids',
  'tmp/sockets',
  'storage',
  'log'
]

task :environment do
  invoke :'rvm:use[ruby-2.4.2@todo_api]'
end

task :setup => :environment do
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/sockets")
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids")

  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
  queue! %[touch "#{deploy_to}/shared/config/puma.rb"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'

    to :launch do
      invoke :'puma:phased_restart'
    end
  end
end
