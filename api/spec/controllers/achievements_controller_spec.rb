
require 'rails_helper'
require_relative '../../app/controllers/achievements_controller'
require_relative '../spec_helper/random_utils'
require_relative '../spec_helper/achievement_mother'

RSpec.describe AchievementsController, type: :controller do
  describe 'POST #create' do
    it 'should return 400 when input is invalid' do
        # Given
        wrong_params = {
          achievement_input: 
            {
              content: "",
              achievements_list_id: "1"
            }
        }

        # When
        post :create, params: wrong_params

        # Then
        expect(response).to have_http_status :bad_request
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to have_key('errors')
        expect(parsed_response["errors"].size).to eql(1)
    end

    it 'should return 400 when input is invalid and leads to errors in usecase' do
        # Given
        wrong_params = {
          achievement_input: 
            {
              content: "My beautiful content",
              achievements_list_id: "1"
            }
        }
        create_achievement_usecase_double = instance_double(
          CreateAchievementUsecase, 
          perform: Result.initialize_with_errors(["error"], Result::BAD_USER_INPUT)
        )
        allow(CreateAchievementUsecase).to receive(:new).and_return(create_achievement_usecase_double)

        # When
        post :create, params: wrong_params

        # Then
        expect(response).to have_http_status :bad_request
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to have_key('errors')
        expect(parsed_response["errors"].size).to eql(1)
    end

    it 'should return 201 when input is valid' do
      # Given
      params = {
        achievement_input: 
          {
            content: "My beautiful content",
            achievements_list_id: "1"
          }
      }
      create_achievement_usecase_double = instance_double(
        CreateAchievementUsecase, 
        perform: Result.with_members(:achievements_list).success(achievements_list: AchievementMother.an_achievement)
      )
      allow(CreateAchievementUsecase).to receive(:new).and_return(create_achievement_usecase_double)

      # When
      post :create, params: params

      # Then
      expect(response).to have_http_status :created
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to have_key('content')
    end

  end
end
