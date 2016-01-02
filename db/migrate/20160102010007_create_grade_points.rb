class CreateGradePoints < ActiveRecord::Migration
  def change
    create_table :grade_points do |t|
      t.references :importance, index: true, foreign_key: true
      t.string :label

      t.timestamps null: false
    end
  end
end
