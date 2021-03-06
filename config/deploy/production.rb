set :branch, "master"

set :server_name, "sufia-dev.osfashland.org"
server 'sufia-dev.osfashland.org', user: 'unicorn', roles: %{web app}, primary: true

set :deploy_to, '/var/www/unicorn'
set :rails_env, :production

server 'sufia-dev.osfashland.org',
  user: 'unicorn',
  roles: %w{web app},
  ssh_options: {
    user: 'unicorn',
    keys: %w(~/.ssh/id_sufia-dev.osfashland.org),
    auth_methods: %w(publickey)
  }
