if defined? BetterErrors
  trusted_ip = ENV['SSH_CLIENT'].split(' ').first
  puts "=> better_errors is open for #{trusted_ip}"
  BetterErrors::Middleware.allow_ip! trusted_ip
end
