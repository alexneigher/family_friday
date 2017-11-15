require 'rails_helper'

RSpec.describe LunchGrouper do
  
  context 'when there are 0 employees' do
    let(:grouper){ LunchGrouper.new(seed: 1) }

    describe '#group_employees' do
      it 'returns an empty array' do
        expect(grouper.group_employees).to eq []
      end
    end
  end

  context 'when there are fewer than 3 employees' do
    let!(:employee_1){ create(:employee) }
    let!(:employee_2){ create(:employee) }
    let(:grouper){ LunchGrouper.new(seed: 1) }

    describe '#group_employees' do
      it 'returns an empty array "because conversaion would die"' do
        #reference this use case in spec: https://gist.github.com/sarahwiemero/0aa5ff2d24196c65880936bbe80f6c52#lunchtime
        expect(grouper.group_employees).to eq []
      end
    end
  end

  context 'when there are 5 employees' do
    let!(:employee_1){ create(:employee) }
    let!(:employee_2){ create(:employee) }
    let!(:employee_3){ create(:employee) }
    let!(:employee_4){ create(:employee) }
    let!(:employee_5){ create(:employee) }

    let(:grouper){ LunchGrouper.new(seed: 1) }

    let!(:groups){ grouper.group_employees }

    describe '#group_employees' do
      it 'groups the employees"' do
        expect(groups).to be_an(Array)
      end

      it 'ensures that there are no groups of 2 people' do
        expect(groups.all?{|g| g.length >=3 && g.length < 6}).to be true
      end

      it 'creates a single group of 5' do
        expect(groups.length).to eq 1
        expect(groups[0].length).to eq 5
      end
    end
  end

  describe 'seeding' do
    let!(:employee_1){ create(:employee) }
    let!(:employee_2){ create(:employee) }
    let!(:employee_3){ create(:employee) }
    let!(:employee_4){ create(:employee) }
    let!(:employee_5){ create(:employee) }
    let!(:employee_6){ create(:employee) }

    context 'when different seeds are used' do
      let(:group_1){ LunchGrouper.new(seed: 3).group_employees }
      let(:group_2){ LunchGrouper.new(seed: 4).group_employees }

      it 'returns the same random shuffle' do
        expect(group_1).to_not eq group_2
      end
    end

    context 'when the same seed is used two times' do
      let(:group_1){ LunchGrouper.new(seed: 3).group_employees }
      let(:group_2){ LunchGrouper.new(seed: 3).group_employees }

      it 'returns the same random shuffle' do
        expect(group_1).to eq group_2
      end
    end
  end
end
