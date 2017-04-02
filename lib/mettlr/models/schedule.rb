module Mettlr
  class Schedule < Base
    def self.find_all
      Mettlr::Connection.get("/v1/schedules").body.schedules.map {|x| new(x)}
    end
    def self.register_candidate(candidate, access_key)
      options = {"rd" => {"registrationDetails" => [candidate.to_params]}}
      Mettlr::Connection.post("/v1/schedules/#{access_key}/candidates", options)
    end
  end
end
