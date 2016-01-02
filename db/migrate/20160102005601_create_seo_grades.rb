class CreateSeoGrades < ActiveRecord::Migration
  def change
    create_table :seo_grades do |t|
      t.references :keyword, index: true, foreign_key: true
      t.string :url
      t.string :grade

      t.timestamps null: false
    end
  end
end
