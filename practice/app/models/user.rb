class User < ActiveRecord::Base
  has_secure_password
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :events_joined, through: :joins, source: :event

  validates :first_name, :last_name, :city, :state, presence: true
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  before_validation :downcase_fields
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  private
  def downcase_fields
    self.email.downcase!
  end
end
