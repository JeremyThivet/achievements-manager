class CreateAchievementsList < ActiveRecord::Migration[7.1]
  def change
    create_table :achievements_list do |t|
      t.string :title, :null => true
      t.datetime :targetted_period, :null => false

      t.timestamps
    end
  end
end
