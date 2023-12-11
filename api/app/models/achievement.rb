class Achievement
    attr_reader :id, :achievements_list_id, :content, :created_at, :updated_at
   
    def initialize(id:, achievements_list_id:, content:, created_at:, updated_at:)
      @id = id
      @achievements_list_id = achievements_list_id
      @content = content
      @created_at = created_at
      @updated_at = updated_at
    end
   end