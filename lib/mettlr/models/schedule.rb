module Mettlr
  class Schedule < Base
    def self.find_all
      Mettlr::Connection.get("/v1/schedules").body.schedules.map {|x| new(x)}
    end
    def self.register_candidate(candidate)
      options = {"rd" => candidate.to_params}
      Mettlr::Connection.post("/v1/schedules/#{Mettlr::METTL_PUBLIC_KEY}/candidates", options)
    end
  end
end
