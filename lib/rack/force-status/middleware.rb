module Rack
  class ForceStatus
    def initialize(app, options={})
      @app = app
      @param = options[:param] || 'force_status'
      @header = options[:header] || 'X-Original-Status-Code'
    end
    
    def call(env)
      request = Rack::Request.new(env)
      force_status = request.params.delete(@param).to_i
      
      status, headers, body = @app.call(env)
      
      if force_status > 0 && status != force_status
        headers[@header] = status.to_s
        status = force_status
      end
      
      [status, headers, body]
    end
  end
end
