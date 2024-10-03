class RemoveTeamNameIdFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :team_name_id, :integer
  end
end
