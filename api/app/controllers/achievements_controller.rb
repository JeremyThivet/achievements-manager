class AchievementsController < ApplicationController

    def create
        @input = AchievementInput.new(achievement_params)

        if @input.valid?
            result = CreateAchievementUsecase.new.perform(@input)

            if result.errors?
                return_error_response result
            else
                return_created result
            end
        else
            return_error_response Result.initialize_with_errors(@input.errors, Result::BAD_USER_INPUT)
        end
    end


    def achievement_params
        params.require(:achievement_input).permit(:content, :achievements_list_id)
    end

end