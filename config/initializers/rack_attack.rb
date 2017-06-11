class Rack::Attack

  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  throttle('req/ip', limit: 1000, period: 3600) do |req|
    req.ip
  end

  self.throttled_response = ->(env) {
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [
      429,
      {'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s},
      [{ "errors": [{ "source": { "pointer": '/data/throttle/limit' },
                      "detail": 'Throttle limit reached. Try again later.' }] }.to_json]
    ]
  }

end
