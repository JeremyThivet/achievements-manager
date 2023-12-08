class AchievementsListsController < ApplicationController

    def create
        @input = AchievementsListInput.new(achievements_list_params)

        if @input.valid?
            result = CreateAchievementsListUsecase.new.perform(@input)

            if result.errors?
                return_error_response result
            else
                return_created result
            end
        else
            return_error_response Result.initialize_with_errors(@input.errors, Result::BAD_USER_INPUT)
        end
    end


    def achievements_list_params
        params.require(:achievements_list_input).permit(:title, :targetted_period)
    end

end
