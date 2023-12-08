class CreateAchievementsListUsecase < Usecase 
    result :achievements_list

    def perform(achievements_list_input)

        targetted_period = achievements_list_input.parse_targetted_period
        existing_achievements_list = AchievementsListRepository.new
        .find_by_week_number_and_year(
            extract_week_number_from_date(targetted_period), 
            extract_year_from_date(targetted_period)
        )

        if existing_achievements_list.nil?
            achievements_list = AchievementsListRepository.new.create(achievements_list_input)
            return result.success(achievements_list: achievements_list)
        end

        return result.failure(["An achievements list already exists for that week."], Result::INPUT_LED_TO_CONFLICT)
    end

    private 

    def extract_week_number_from_date(date)
        date.strftime("%W")
    end

    def extract_year_from_date(date)
        date.strftime("%Y")
    end

    
end
