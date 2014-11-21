class Person < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validate :is_a_valid_email?

  private

  def is_a_valid_email?
    if !(email =~ VALID_EMAIL_REGEX)
      errors.add(:email, "invalid email address")
    end
  end
end
