class CreateAchievementUsecase < Usecase 
    result :achievement

    def perform(achievement_input)

        begin
            achievement = AchievementRepository.new.create(achievement_input)
            return result.success(achievement: achievement)
        rescue AchievementRepository::NoAchievementsListToAssociateWithError => e
            return result.failure([e.message], Result::BAD_USER_INPUT)
        end
    end
    
end
