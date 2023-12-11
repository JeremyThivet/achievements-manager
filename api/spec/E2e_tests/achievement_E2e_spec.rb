
require 'rails_helper'
require 'json_expressions/rspec'
require_relative '../../app/controllers/achievements_lists_controller'
require_relative '../spec_helper/random_utils'
require_relative '../spec_helper/achievements_list_mother'

RSpec.describe AchievementsController, type: :request do
  describe 'POST #create' do
    it 'should return 201 created with valid json response when receiving a POST request' do
        # Given
        AchievementRecord.delete_all
        achievements_list_record = AchievementsListRecord.create!(
          title: "My list E2e",
          targetted_period: "2023-12-08T16:40:49+00:00"
        )
        json_valid_params = { 
          achievement_input: 
            {
              content: "This is a big content",
              achievements_list_id: achievements_list_record.id
            }
        }.to_json

        expected_json_pattern = {
          "content": {
              "achievement": {
                  "id": :achievement,
                  "achievements_list_id": :achievements_list_id,
                  "content": "This is a big content",
                  "created_at": wildcard_matcher,
                  "updated_at": wildcard_matcher
              },
              "errors": [],
              "error_type": nil
          }
        }

        # When
        post '/achievements', params: json_valid_params, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        # Then
        total_entries_created = AchievementRecord.all.count
        expect(response).to have_http_status(:created)
        expect(total_entries_created).to eq(1)
    end
  end
end
