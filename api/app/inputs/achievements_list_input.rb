class AchievementsListInput
    include ActiveModel::Model

    attr_accessor :title, :targetted_period

    # Put validations rules here
    validates :title, length: { minimum: 3 }, allow_nil: true
    validates :targetted_period, presence: true
    validate :validate_targetted_period

    def parse_targetted_period
        DateTime.strptime(self.targetted_period, "%FT%T%:z")
    end

    private

    # Format should be : 2007-11-19T08:37:48-06:00
    def can_parse_targetted_period
        begin
            parse_targetted_period
            true
        rescue 
            false
        end
    end

    def validate_targetted_period
        errors.add("Targetted period date", "is invalid.") unless can_parse_targetted_period
    end

end 