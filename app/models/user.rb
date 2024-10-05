class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :team_names, optional: true

  enum role: { general: 0, admin: 1, leader: 2 }
  validates :username, length: { maximum: 20 }, presence: true, uniqueness: true

  has_many :rule_requests, dependent: :destroy
  scope :admins, -> { where(role: :admin) }
end
