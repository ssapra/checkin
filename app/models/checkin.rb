class Checkin < ActiveRecord::Base
  validates :merchant_id, presence: true
  validates :person_id, presence: true

  belongs_to :merchant
  belongs_to :person
end
