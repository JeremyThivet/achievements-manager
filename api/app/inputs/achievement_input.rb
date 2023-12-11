class AchievementInput
    include ActiveModel::Model

    attr_accessor :achievements_list_id, :content

    # Put validations rules here
    validates :achievements_list_id, presence: true
    validates :content, presence: true, allow_blank: false

end 