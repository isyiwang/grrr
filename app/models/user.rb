class User < ApplicationRecord
  include Clearance::User

  has_many :authentications, dependent: :destroy, inverse_of: :user

  validates :phone_number, telephone_number: { country: proc { |_| :us } }, allow_nil: true

  before_save do |user|
    if changes.key?(:phone_number)
      user.phone_number = TelephoneNumber.parse(user.phone_number, :us).e164_number
    end
  end
end
