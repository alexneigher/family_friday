require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "validations" do
    context 'with missing attributes' do
      describe "email" do
        let(:employee){ build(:employee, name: 'Alex', email: nil)}

        it 'validates presence of email' do
          expect(employee).to_not be_valid
        end
      end

      describe "name" do
        let(:employee){ build(:employee, name: nil, email: 'alex@email.com')}

        it 'validates presence of name' do
          expect(employee).to_not be_valid
        end
      end
    end

    context 'with all attributes present' do
      let(:employee){ build(:employee)}
      it 'is valid' do
        expect(employee).to be_valid
      end
    end
  end
end
