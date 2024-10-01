class CreateJoinTableUsersTeamNames < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :team_names do |t|
      t.index [:user_id, :team_name_id], unique: true  # ユーザーが同じチームに複数回追加されないようにする
      t.index [:team_name_id, :user_id]
    end
  end
end