
require 'rails_helper'
require_relative '../spec_helper/random_utils'
require_relative '../spec_helper/achievements_list_mother'

RSpec.describe CreateAchievementsListUsecase do
  describe '#perform' do
    it 'should return an error when achivements_list input already exists' do
        # Given
        param = {
          title: "My title",
          targetted_period: "2023-11-05T16:40:49+00:00"
        }
        input = AchievementsListInput.new(param)
        achivements_list_repository_double = instance_double(
          AchievementsListRepository, 
          find_by_week_number_and_year: AchievementsListMother.an_achievements_list
        )
      
        allow(AchievementsListRepository).to receive(:new).and_return(achivements_list_repository_double)

        # When
        result = CreateAchievementsListUsecase.new.perform(input)

        # Then
        expect(result.error_type).to eq(Result::INPUT_LED_TO_CONFLICT)
    end

    it 'should return a successful result when achivements_list input does not exist' do
      # Given
      param = {
        title: "My title",
        targetted_period: "2023-11-05T16:40:49+00:00"
      }
      input = AchievementsListInput.new(param)
      an_achievements_list = AchievementsListMother.an_achievements_list

      achivements_list_repository_double = instance_double(
        AchievementsListRepository, 
        find_by_week_number_and_year: nil,
        create: an_achievements_list
      )
    
      allow(AchievementsListRepository).to receive(:new).and_return(achivements_list_repository_double)

      # When
      result = CreateAchievementsListUsecase.new.perform(input)

      # Then
      expect(result.achievements_list).to be_an_instance_of(AchievementsList)
      expect(result.achievements_list.title).to eq(an_achievements_list.title)
    end
  end
end
