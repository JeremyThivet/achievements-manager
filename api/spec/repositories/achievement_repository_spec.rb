
require 'rails_helper'
require_relative '../spec_helper/achievements_list_mother'

RSpec.describe AchievementRepository do
  describe '#create' do
    it 'should return achievement domain object when creating a new record' do
        # Given
        achievements_list = AchievementsListRepository.new.create(AchievementsListMother.an_achievements_list)
        achievement_input = AchievementInput.new(content: "myContent", achievements_list_id: achievements_list.id)
    
        # When
        result = AchievementRepository.new.create(achievement_input)

        # Then
        expect(result.content).to eq(achievement_input.content)
        expect(result.achievements_list_id).to eq(achievement_input.achievements_list_id)
    end

    it 'should throw exception when no achievements list is found for specific id' do
      # Given
      achievement_input = AchievementInput.new(content: "myContent", achievements_list_id: "0")
  
      # When + Then
      expect { AchievementRepository.new.create(achievement_input) }.to raise_error(AchievementRepository::NoAchievementsListToAssociateWithError)
  end
  end
end
