require_relative '../../app/models/achievements_list'

module AchievementsListMother

    def self.an_achievements_list(
        id: RandomUtils.random_integer(2), 
        title: RandomUtils.random_string(10),
        targetted_period: RandomUtils.random_datetime,
        created_at: RandomUtils.random_datetime,
        updated_at: RandomUtils.random_datetime
    )
        AchievementsList.new(id: id, title: title, targetted_period: targetted_period, created_at: created_at, updated_at: updated_at)
    end

end