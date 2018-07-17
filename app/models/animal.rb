class Animal < ApplicationRecord
  belongs_to :zoo

  use_discretion

  private

  def can_see?(viewer)
    Discretion.can_see_record?(viewer, zoo)
  end
end
