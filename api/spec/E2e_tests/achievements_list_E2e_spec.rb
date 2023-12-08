
require 'rails_helper'
require 'json_expressions/rspec'
require_relative '../../app/controllers/achievements_lists_controller'
require_relative '../spec_helper/random_utils'
require_relative '../spec_helper/achievements_list_mother'

RSpec.describe AchievementsListsController, type: :request do
  describe 'POST #create' do
    it 'should return 201 created with valid json response when receiving a POST request' do
        # Given
        AchievementsListRecord.delete_all
        json_valid_params = {
          achievements_list_input: {
            title: "My list E2e",
            targetted_period: "2023-12-08T16:40:49+00:00"
          }
        }.to_json

        expected_json_pattern = {
          "content": {
              "achievements_list": {
                  "id": :achievements_list,
                  "title": "My list E2e",
                  "targetted_period": "2023-12-08T16:40:49.000Z",
                  "created_at": wildcard_matcher,
                  "updated_at": wildcard_matcher
              },
              "errors": [],
              "error_type": nil
          }
        }

        # When
        post '/achievements_lists', params: json_valid_params, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        # Then
        total_entries_created = AchievementsListRecord.all.count
        expect(response).to have_http_status(:created)
        expect(total_entries_created).to eq(1)
    end

    it 'should crete only one record for the same targetted period' do
      # Given
      AchievementsListRecord.delete_all
      json_valid_params = {
        achievements_list_input: {
          title: "My list E2e",
          targetted_period: "2023-12-08T16:40:49+00:00"
        }
      }.to_json

      # When
      10.times { post '/achievements_lists', params: json_valid_params, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' } }

      # Then
      total_entries_created = AchievementsListRecord.all.count
      expect(total_entries_created).to eq(1)
  end
  end
end
