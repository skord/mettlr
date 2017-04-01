module Mettlr
  class Candidate
    attr_accessor :email_address, :first_name, :last_name,
                  :date_of_birth, :contact_no, :gender, :country
    def initialize(options = {})
      @email_address = options[:email_address]
      @first_name= options[:first_name]
      @last_name = options[:last_name]
      @date_of_birth = options[:date_of_birth]
      @contact_no = options[:contact_no]
      @gender = options[:gender]
      @country = options[:country]
    end
    def to_hash
      {email_address: @email_address, first_name: @first_name,
       last_name: @last_name, date_of_birth: @date_of_birth,
       contact_no: @contact_no, gender: @gender, country: @country
      }
    end
    def to_params
      {"Email Address" => @email_address,
       "First Name" => @first_name,
       "Last Name" => @last_name,
       "Date of birth" => @date_of_birth,
       "Contact no" => @contact_no,
       "Gender" => @gender,
       "Country" => @country
      }.reject {|k,v| v.nil?}
    end
  end
end
