# encoding: utf-8
# frozen_string_literal: true

# This is the ActiveRecord model of an user
#
# This model is used also for containing credential information
# A user contain the following information:
# * +:name+ - The name of the user, required
# * +:surname+ - The surname of the user, required
# * +:email+ - The email of the user. Used for authentication
# * +:crypted_password+
# * +:password_salt+
# * +:persistence_token+
# * +:perishable_token+
# * +:login_count+
# * +:failed_login_count+
# * +:last_request_at+
# * +:current_login_at+
# * +:last_login_at+
# * +:current_login_ip+
# * +:last_login_ip+
# * +:active+ - Flag that indicates if the account is active
class User < ActiveRecord::Base
  EMAIL_FORMAT = Authlogic::Regex.email
  acts_as_authentic do |config|
    config.session_class = UserSession
  end
  has_paper_trail ignore: %w[last_request_at perishable_token]

  # Relations

  # Attributes

  # Validations
  validates :name, presence: true
  validates :surname, presence: true
  validates :email, presence: true, format: {
    with: EMAIL_FORMAT
  }, uniqueness: true

  # Callbacks
  before_validation :default_values

  protected

  def default_values
    # El self es necesario
    self.locale ||= 'es' # Spanish language by default
    self.timezone ||= 'Madrid' # Madrid timezone by default
  end
end
