
require 'rails_helper'

RSpec.describe AchievementsListRepository do
  describe '#find_by_week_number_and_year' do
    it 'should return achievements list when there is an existing entry for that specific week and year' do
        # Given a record for week 49
        AchievementsListRecord.create!(title: "test", targetted_period: "2023-12-08T16:40:49+00:00")
    
        # When
        result = AchievementsListRepository.new.find_by_week_number_and_year("49", "2023")

        # Then
        expect(result.title).to eq("test")
        expect(result.targetted_period).to eq("2023-12-08T16:40:49+00:00")
    end

    it 'should return nil when there is not an existing entry for that specific week and year' do
        # Given a record for week 50
        AchievementsListRecord.create!(title: "test", targetted_period: "2023-12-13T16:40:49+00:00")
    
        # When
        result = AchievementsListRepository.new.find_by_week_number_and_year("49", "2023")

        # Then
        expect(result).to eq(nil)
    end
  end

  describe '#create' do
    it 'should return achievements list domain object when creating a new record' do
        # Given a record for week 49
        title = "myTest"
        targetted_period = "2023-12-08T16:40:49+00:00"
    
        # When
        result = AchievementsListRecord.create!(title: title, targetted_period: targetted_period)

        # Then
        expect(result.title).to eq("myTest")
        expect(result.targetted_period).to eq(targetted_period)
    end
  end
end
