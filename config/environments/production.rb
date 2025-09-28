require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory usage.
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Turn on fragment caching in view templates.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.enabled = true
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Store uploaded files on AWS S3 (see config/storage.yml for options).
  config.active_storage.service = :local

  # Disable SSL forcing since load balancer handles SSL termination
  # The load balancer forwards HTTP requests to the app after SSL termination
  config.force_ssl = false
  
  # Disable assume_ssl since users access via HTTP through load balancer
  config.assume_ssl = false
  
  # Configure trusted proxies for load balancer to properly handle forwarded headers
  config.action_dispatch.trusted_proxies = ActionDispatch::RemoteIp::TRUSTED_PROXIES + [
    IPAddr.new("10.0.0.0/8"),     # Private networks
    IPAddr.new("172.16.0.0/12"),  # Private networks  
    IPAddr.new("192.168.0.0/16")  # Private networks
  ]

  # Log to STDOUT with the current request id as a default log tag.
  config.log_tags = [:request_id]
  config.log_level = :info
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

  # Change to "debug" to log everything (including potentially personally-identifiable information!)
  config.log_level = :info

  # Prevent health checks from clogging up the logs.
  config.silence_healthcheck_path = "/up"

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Replace the default in-process and non-durable queuing backend for Active Job.
  # config.active_job.queue_adapter = :resque
  config.active_job.queue_adapter = :inline

  # Disable caching for Action Mailer templates even if Action Controller
  # caching is enabled.
  config.action_mailer.perform_caching = false

  # Configure Action Mailer for production
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { 
    host: ENV['DOMAIN_NAME'] || 'localhost',
    protocol: 'https'
  }
  
  # Configure SMTP for production
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    user_name: ENV['GMAIL_USERNAME'],
    password: ENV['GMAIL_PASSWORD'],
    authentication: 'plain',
    enable_starttls_auto: true
  }

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Only use :id for inspections in production.
  config.active_record.attributes_for_inspect = [ :id ]

  # Enable DNS rebinding protection and other `Host` header attacks.
  # config.hosts = [
  #   "example.com",     # Allow requests from example.com
  #   /.*\.example\.com/ # Allow requests from subdomains like `www.example.com`
  # ]
  # Skip DNS rebinding protection for the default health check endpoint.
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
