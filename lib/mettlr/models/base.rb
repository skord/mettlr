module Mettlr
  class Base
    attr_accessor :id, :body
    def initialize(options)
      @id = options.id
      @body = options
    end
  end
end
