class CreateGame < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :difficulty, default: 0
      t.integer :state, default: 0
      t.timestamp :started_at
      t.timestamp :finished_at
      t.integer :rows
      t.integer :cols
      t.integer :mines
      t.json :board, array:true, default: []

      t.timestamps
    end
  end
end
