require 'httparty'

module Mastermind
  class Client
    include HTTParty
    base_uri 'https://mastermind.praetorian.com'
    headers 'Content-Type' => 'application/json'
    debug_output $stderr
    default_options.update(verify: false)
    format :json

    def initialize(email, host = nil)
      self.class.base_uri host if host
      @email = email
      self.get_auth_token
    end

    def get_auth_token
      auth = self.class.post('/api-auth-token/', body: {email: @email}.to_json)
      self.class.headers 'Auth-Token' => auth['Auth-Token']
    end

    def start_level(level)
      self.class.get("/level/#{level}/")
    end

    def solve_level(level, guess)
      self.class.post("/level/#{level}/", body: {guess: guess}.to_json)
    end

    def hash
      self.class.get('/hash/')
    end

    def reset
      self.class.post('/reset/')
    end

  end
end
