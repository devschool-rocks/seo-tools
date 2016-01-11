class ChangeColumnTypeForRanking < ActiveRecord::Migration
  def change
    change_column :rankings, :position,
                  'integer USING CAST(position AS integer)'
  end
end
