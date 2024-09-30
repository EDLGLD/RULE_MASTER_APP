class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :team_name, optional: true  # チームなしでもユーザーを作成可能
  
  enum role: { general: 0, admin: 1, leader: 2 }
  validates :username, length: { maximum: 20 }, presence: true, uniqueness: true
end
