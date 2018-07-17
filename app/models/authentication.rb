require 'attr_encrypted_kms'

class Authentication < ApplicationRecord
  use_attr_encrypted_kms

  attribute :token
  attr_encrypted :token, key: :kms_dek

  attribute :refresh_token
  attr_encrypted :refresh_token, key: :kms_dek

  belongs_to :user, inverse_of: :authentications
end
