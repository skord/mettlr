module Mettlr
  class Schedule < Base
    extend Dry::Initializer
    option :assessment_id, types: Dry::Types['strict.int']
    option :name, type: Dry::Types['coercible.string']
    option :image_proctoring, type: Dry::Types['bool']
    option :is_candidate_auth_proctored, type: Dry::Types['bool']
    option :access, type: Dry::Types['hash']
    option :web_proctoring, type: Dry::Types['hash']
    option :schedule_type, type: Dry::Types['string']
    option :ip_access_restriction, type: Dry::Types['hash']
    option :test_grade_notification, type: Dry::Types['hash']
    option :allow_copy_paste, type: Dry::Types['bool']
    option :source_app, Dry::Types['coercible.string']
    option :test_start_notification_url, type: Dry::Types['strict.string']
    option :test_finish_notification_url, type: Dry::Types['strict.string']
    option :test_graded_notification_url, type: Dry::Types['strict.string']
    option :test_resume_enabled_for_expired_test_url, optional: true
    option :exit_redirection_url, optional: true
    option :schedule_window
    def self.find_all
      Mettlr::Connection.get("/v1/schedules").body.schedules.map {|x| new(x)}
    end
    def self.find_by_access_key(access_key)
      Mettlr::Connection.get("/v1/schedules/#{access_key}")
    end
    def self.register_candidate(candidate, access_key)
      options = {"rd" => {"registrationDetails" => [candidate.to_params]}}
      Mettlr::Connection.post("/v1/schedules/#{access_key}/candidates", options)
    end
    def self.delete_report_for(candidate_email, access_key)
      Mettlr::Connection.delete("/v1/schedules/#{access_key}/candidates/#{candidate_email}")
    end
    def create!
      Mettlr::Connection.post("/v1/assessments/#{@assessment_id}/schedules", to_param)
    end
    def to_param
      {"sc" => { "assessmentId" => @assessment_id,
                 "name" => @name,
                 "imageProctoring" => @image_proctoring,
                 "isCandidateAuthProctored": @is_candidate_auth_proctored,
                 "webProctoring" => @web_proctoring,
                 "scheduleWindow" => @schedule_window,
                 "scheduleType" => @schedule_type,
                 "access" => @access,
                 "sourceApp" => @source_app,
                 "ipAccessRestriction" => @ip_access_restriction,
                 "testGradeNotification" => @test_grade_notification,
                 "allowCopyPaste" => @allow_copy_paste,
                 "exitRedirectionUrl" => @exit_redirection_url,
                 "testStartNotificationUrl" => @test_start_notification_url,
                 "testFinishNotificationUrl" => @test_finish_notification_url,
                 "testGradedNotificationUrl" => @test_graded_notification_url,
                 "testResumeEnabledForExpiredTestURL" => @test_resume_enabled_for_expired_test_url}
      }
    end
  end
end
