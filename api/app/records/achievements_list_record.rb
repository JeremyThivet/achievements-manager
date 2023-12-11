class AchievementsListRecord < ApplicationRecord
    self.table_name = "achievements_lists"
    has_many :achievement_records, foreign_key: :achievements_list_id, dependent: :destroy
end