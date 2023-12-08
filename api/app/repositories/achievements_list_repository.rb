class AchievementsListRepository

    # Persist a new Achievements List
    # Params:
    # +achievements_list+:: an domain object corresponding to AchievementsList
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
    # +achievements_list+:: an domain object corresponding to AchievementsList
    def create(achievements_list)

        record = AchievementsListRecord.create!(title: achievements_list.title, targetted_period: achievements_list.targetted_period)
        to_domain_model(record.attributes)
    end

    private

    def to_domain_model(attributes)
        AchievementsList.new(**attributes.symbolize_keys)
    end
end