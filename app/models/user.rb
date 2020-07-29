class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.validations.user.email_regex

  validates :name, presence: true, length: {maximum: Settings.user.max_name_length}
  validates :email, presence: true, length: {maximum: Settings.user.max_email_length}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.user.min_password_length}

  before_save :downcase_email

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
