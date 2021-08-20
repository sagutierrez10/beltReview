class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :users_joined, through: :joins, source: :user

  validates :name, :city, :state, presence: true

  def self.with_user event_id
    self.joins(:user).where("event_id = ?", event_id).select(:id, :first_name, :last_name, :email, :user_id, :created_at).first
  end
end
