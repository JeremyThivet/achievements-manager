class AchievementsList 
    attr_reader :id, :title, :targetted_period, :created_at, :updated_at

    def initialize(id:, title:, targetted_period:, created_at:, updated_at:)
        @id = id
        @title = title
        @targetted_period = targetted_period
        @created_at = created_at
        @updated_at = updated_at
    end
end