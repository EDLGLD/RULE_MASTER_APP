class AddUniqueIndexToTeamNamesName < ActiveRecord::Migration[6.1]
  def change
    add_index :team_names, :name, unique: true
  end
end
