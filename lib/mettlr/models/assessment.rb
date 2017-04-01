module Mettlr
  class Assessment < Base
    def self.find_all
      Mettlr::Connection.get("/v1/assessments").body.assessments.map {|x| new(x)}
    end
    def self.find(id)
      new(Mettlr::Connection.get("/v1/assessments/#{id}").body.assessment)
    end
    def schedules
      Mettlr::Connection.get("/v1/assessments/#{@id}/schedules").body.schedules
    end
  end
end
