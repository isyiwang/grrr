class WhitelistedEmail < ApplicationRecord
  def self.email_whitelisted?(email)
    WhitelistedEmail.find_by(email: email).present?
  end
end
