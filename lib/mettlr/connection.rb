module Mettlr
  class Connection
    def self.connection
      @connection = Faraday.new('http://api.mettl.com/v1') do |c|
        # c.options.params_encoder = Faraday::FlatParamsEncoder
        c.request :url_encoded
        c.request :json
        c.response :mashify
        c.response :json, content_type: /\bjson$/
        c.response :logger
        c.use :instrumentation
        c.adapter :net_http
      end
    end
    def self.get(path)
      connection.get do |req|
        req.path = path
        req.params['ak'] = Mettlr::METTL_PUBLIC_KEY
        req.params['ts'] = Time.now.to_i.to_s
        req.params = Hash[req.params.sort_by {|k,v| k.downcase}]
        req.params['asgn'] = Mettlr::Signature.new(req).signature
      end
    end
    def self.post(path, options)
      connection.post do |req|
        req.path = path
        req.params['ak'] = Mettlr::METTL_PUBLIC_KEY
        req.params['ts'] = Time.now.to_i.to_s
        req.params.merge!(options)
        req.params = Hash[req.params.sort_by {|k,v| k.downcase}]
        req.params['asgn'] = Mettlr::Signature.new(req).signature
      end
    end
  end
end
