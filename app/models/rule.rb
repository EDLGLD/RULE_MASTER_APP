class Rule < ApplicationRecord
  belongs_to :team_name
  has_many :rule_requests, dependent: :destroy
end
