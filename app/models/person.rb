require 'valid_email'
class Person < ActiveRecord::Base
  has_many :checkins
  has_many :merchants, through: :checkins
  validates :email, :presence => true, :email => true
end
