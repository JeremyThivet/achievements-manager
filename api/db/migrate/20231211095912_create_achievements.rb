class CreateAchievements < ActiveRecord::Migration[7.1]
  def change
    create_table :achievements do |t|
      t.text :content, :null => false
      t.references :achievements_list, foreign_key: true, :null => false

      t.timestamps
    end
  end
end
