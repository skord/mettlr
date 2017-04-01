module Mettlr
  class Signature
    def initialize(request)
      @request = request
    end

    def concat_string
      @request.method.to_s.upcase +
        "http://api.mettl.com" + 
        @request.path + 
        param_values
    end
    def param_values
      "\n" + @request.params.values.join("\n")
    end
    def signature
      hmac = OpenSSL::HMAC.digest('sha1', Mettlr::METTL_PRIVATE_KEY, concat_string)
      Faraday::Utils.escape(Base64.encode64(hmac).chomp)
    end
  end
end
