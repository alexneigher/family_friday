require 'rails_helper'

RSpec.describe LunchGroupCreateService do
  describe "perform" do
    context 'when no groups are passed in' do
      let(:service){ LunchGroupCreateService.new(seed: 1, groups:[])}

      it 'returns false' do
        expect(service.perform!).to be false
      end
    end

    context 'when there are groups' do
      let!(:employee_1){ create(:employee) }
      let!(:employee_2){ create(:employee) }
      let!(:employee_3){ create(:employee) }
      let!(:employee_4){ create(:employee) }
      let!(:employee_5){ create(:employee) }
      let!(:employee_6){ create(:employee) }

      let(:groups){ [[employee_1, employee_2, employee_3],[employee_4, employee_5, employee_6]] }

      let(:service){ LunchGroupCreateService.new(seed: 1, groups: groups)}

      it 'persists the groups' do
        lunch_group = service.perform!
        expect(lunch_group.groupings.count).to eq 2
      end

      it 'persists the group employees' do
        lunch_group = service.perform!
        expect(lunch_group.groupings.first.employees.count).to eq 3
      end
    end
  end
end
