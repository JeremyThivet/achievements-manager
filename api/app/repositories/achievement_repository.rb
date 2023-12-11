class AchievementRepository

    # Persist a new Achievement
    # Params:
    # +achievements+: an object corresponding to an Achievement Input
    def create(achievement_input)
      record = AchievementRecord.create!(
        achievements_list_id: achievement_input.achievements_list_id, content: achievement_input.content
      )
      to_model(record.attributes)
    end
   
    private
   
    def to_model(attributes)
      Achievement.new(**attributes.symbolize_keys)
    end
   end