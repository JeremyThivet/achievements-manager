class AchievementRepository

    # Persist a new Achievement
    # Params:
    # +achievements+: an object corresponding to an Achievement Input
    def create(achievement_input)
      begin
        record = AchievementRecord.create!(
          achievements_list_id: achievement_input.achievements_list_id, content: achievement_input.content
        )
        to_model(record.attributes)
      rescue ActiveRecord::InvalidForeignKey => e
        raise NoAchievementsListToAssociateWithError.new(achievement_input.achievements_list_id)
      end
    end
   
    private
   
    def to_model(attributes)
      Achievement.new(**attributes.symbolize_keys)
    end



    class NoAchievementsListToAssociateWithError < StandardError
      def initialize(achievements_list_id)
        super("No achievements list has been found with this id #{achievements_list_id}")
      end
    end


   end