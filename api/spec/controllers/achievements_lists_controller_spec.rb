
require 'rails_helper'
require_relative '../../app/controllers/achievements_lists_controller'
require_relative '../spec_helper/random_utils'
require_relative '../spec_helper/achievements_list_mother'

RSpec.describe AchievementsListsController, type: :controller do
  describe 'POST #create' do
    it 'should return 400 when input is invalid' do
        # Given
        wrong_params = {
          achievements_list_input: {
            title: "E",
            targetted_period: "Wrong Date"
          }
        }

        # When
        post :create, params: wrong_params

        # Then
        expect(response).to have_http_status :bad_request
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to have_key('errors')
        expect(parsed_response["errors"].size).to eql(2)
    end

    it 'should return 409 conflict when input is a conflict type error' do
      # Given
      wrong_params = {
        achievements_list_input: {
          title: "My title",
          targetted_period: "2023-11-05T16:40:49+00:00"
        }
      }
      create_achievements_list_usecase_double = instance_double(
        CreateAchievementsListUsecase, 
        perform: Result.initialize_with_errors(["error"], Result::INPUT_LED_TO_CONFLICT)
      )
      allow(CreateAchievementsListUsecase).to receive(:new).and_return(create_achievements_list_usecase_double)

      # When
      post :create, params: wrong_params

      # Then
      expect(response).to have_http_status :conflict
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to have_key('errors')
    end

    it 'should return 201 when input is valid' do
      # Given
      params = {
        achievements_list_input: {
          title: "My title",
          targetted_period: "2023-11-05T16:40:49+00:00"
        }
      }
      create_achievements_list_usecase_double = instance_double(
        CreateAchievementsListUsecase, 
        perform: Result.with_members(:achievements_list).success(achievements_list: AchievementsListMother.an_achievements_list)
      )
      allow(CreateAchievementsListUsecase).to receive(:new).and_return(create_achievements_list_usecase_double)

      # When
      post :create, params: params

      # Then
      expect(response).to have_http_status :created
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to have_key('content')
    end
  end
end
