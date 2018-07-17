class Zoo < ApplicationRecord
  has_many :animals, dependent: :destroy, inverse_of: :zoo

  use_discretion

  private

  def can_see?(_viewer)
    true # as long as user is logged-in it's all good
  end
end
