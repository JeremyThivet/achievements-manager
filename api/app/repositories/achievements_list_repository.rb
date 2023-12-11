class AchievementsListRepository

    # Find an achievement list whose targetted_period correspond to the week and the year in parameters
    # Params:
    # +week_number+:: week number (Week number of ISO 8601)
    # +year+:: year (four number format like 2023)
    def find_by_week_number_and_year(week_number, year)
        result = AchievementsListRecord.where("TO_CHAR(targetted_period,'IWYYYY') = ? ", "#{week_number}#{year}")
        if result.any?
            to_domain_model(result.first.attributes)
        else
            nil
        end
    end

    # Persist a new Achievements List
    # Params:
    # +achievements_list+:: an object corresponding to AchievementsList Input
    def create(achievements_list_input)

        record = AchievementsListRecord.create!(title: achievements_list_input.title, targetted_period: achievements_list_input.targetted_period)
        to_domain_model(record.attributes)
    end

    private

    def to_domain_model(attributes)
        AchievementsList.new(**attributes.symbolize_keys)
    end
end