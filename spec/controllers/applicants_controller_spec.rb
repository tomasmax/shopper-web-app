require 'rails_helper'

describe ApplicantsController do

  describe 'POST create' do
    let(:applicant_attributes) { FactoryGirl.attributes_for(:applicant) }

    context 'when valid' do
      before do
        post :create, applicant: applicant_attributes
      end

      it 'creation of a new applicant' do
        expect(Applicant.last.first_name).to eq(applicant_attributes[:first_name])
        expect(Applicant.last.last_name).to eq(applicant_attributes[:last_name])
        expect(Applicant.last.email).to eq(applicant_attributes[:email])
        expect(Applicant.last.phone).to eq(applicant_attributes[:phone])
        expect(Applicant.last.phone_type).to eq(applicant_attributes[:phone_type])
        expect(Applicant.last.region).to eq(applicant_attributes[:region])
      end

      it "applicant's state is background_check" do
        expect(assigns(:applicant).state).to eq('background_check')
      end

    end
  end
end