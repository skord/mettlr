module Mettlr
  class Account
    def self.account
      Mettlr::Connection.get("/v1/account").body.accountInfo
    end
  end
end
