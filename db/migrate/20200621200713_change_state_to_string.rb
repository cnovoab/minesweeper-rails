class ChangeStateToString < ActiveRecord::Migration[6.0]
  def up 
    change_column :games, :state, :string, default: :unstarted
  end

  def down
    change_column :games, :state, 'integer USING CAST(state AS integer)'
  end
end
