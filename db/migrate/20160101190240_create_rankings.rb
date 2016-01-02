class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :keyword, index: true, foreign_key: true
      t.string :url
      t.string :position

      t.timestamps null: false
    end
  end
end
