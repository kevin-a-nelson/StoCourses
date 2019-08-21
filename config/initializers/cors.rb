Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:8080', 'localhost:17610', 'localhost:35247', 'localhost:17685',
    'localhost:16923', 'localhost:28915', 'localhost:15895', 'localhost:24718', 'localhost:30911', 'localhost:22447'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
