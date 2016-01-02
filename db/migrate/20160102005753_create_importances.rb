class CreateImportances < ActiveRecord::Migration
  def change
    create_table :importances do |t|
      t.string :value

      t.timestamps null: false
    end
  end
end
