class CreateSeoGradePoints < ActiveRecord::Migration
  def change
    create_table :seo_grade_points do |t|
      t.references :seo_grade, index: true, foreign_key: true
      t.references :grade_point, index: true, foreign_key: true
      t.integer :score

      t.timestamps null: false
    end
  end
end
