
require 'rails_helper'
require_relative '../spec_helper/random_utils'
require_relative '../spec_helper/achievement_mother'

RSpec.describe CreateAchievementUsecase do
  describe '#perform' do
    it 'should return an error when achivements_list id in input does not exist' do
        # Given
        param = {
          content: "My wonderful content",
          achievements_list_id: "1"
        }
        input = AchievementInput.new(param)
        achievement_repository_double = instance_double(
          AchievementRepository, 
          create: AchievementsListMother.an_achievements_list
        )
        allow(achievement_repository_double).to receive(:create).and_raise(AchievementRepository::NoAchievementsListToAssociateWithError, 'My error message')
        allow(AchievementsListRepository).to receive(:new).and_return(achievement_repository_double)

        # When
        result = CreateAchievementUsecase.new.perform(input)

        # Then
        expect(result.error_type).to eq(Result::BAD_USER_INPUT)
    end

    it 'should return a successful result when achievement input is valid' do
      # Given
      param = {
        content: "My wonderful content",
        achievements_list_id: "1"
      }
      input = AchievementInput.new(param)
      an_achievement = AchievementMother.an_achievement

      achievement_repository_double = instance_double(
        AchievementRepository, 
        create: an_achievement
      )
      allow(AchievementRepository).to receive(:new).and_return(achievement_repository_double)

      # When
      result = CreateAchievementUsecase.new.perform(input)

      # Then
      expect(result.achievement).to be_an_instance_of(Achievement)
      expect(result.achievement.content).to eq(an_achievement.content)
    end
  end
end
