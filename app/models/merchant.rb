class Merchant < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :checkins
  has_many :people, through: :checkins
end
