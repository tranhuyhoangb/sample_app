class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.validations.user.email_regex
  USERS_PARAMS = %i(name email password password_confirmation).freeze

  validates :name, presence: true, length: {maximum: Settings.validations.user.max_name_length}
  validates :email, presence: true, length: {maximum: Settings.validations.user.max_email_length}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.validations.user.min_password_length}

  before_save :downcase_email

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
