set :stage, :staging

server 'ec2-54-204-72-90.compute-1.amazonaws.com', user: 'ubuntu', roles: %w{web app db}, my_property: :my_value,
        ssh_options: {
            user: 'ubuntu', # overrides user setting above
            keys: %w(/Users/mattowens/.ssh/mowens),
            forward_agent: true,
            auth_methods: %w(publickey)
          }

