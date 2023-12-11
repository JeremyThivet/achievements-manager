require_relative '../../app/models/achievement'

module AchievementMother

    def self.an_achievement(
        id: RandomUtils.random_integer(2), 
        content: RandomUtils.random_string(50),
        achievements_list_id: RandomUtils.random_integer(2), 
        created_at: RandomUtils.random_datetime,
        updated_at: RandomUtils.random_datetime
    )
        Achievement.new(id: id, content: content, achievements_list_id: achievements_list_id, created_at: created_at, updated_at: updated_at)
    end

end