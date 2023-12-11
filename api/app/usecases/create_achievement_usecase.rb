class CreateAchievementUsecase < Usecase 
    result :achievement

    def perform(achievement_input)

        begin
            achievement = AchievementRepository.new.create(achievement_input)
            return result.success(achievement: achievement)
        rescue ActiveRecord::InvalidForeignKey => e
            return result.failure(["No achievements list has been found with this id #{achievement_input.achievements_list_id}"], Result::BAD_USER_INPUT)
        end
    end
    
end
