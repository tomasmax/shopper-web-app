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
        expect(Applicant.last.cell_phone).to eq(applicant_attributes[:cell_phone])
        expect(Applicant.last.workflow_state).to eq(applicant_attributes[:workflow_state])
        expect(Applicant.last.phone_type).to eq(applicant_attributes[:phone_type])
        expect(Applicant.last.region).to eq(applicant_attributes[:region])
      end

      it "applicant's state is background_check" do
        expect(assigns(:applicant).state).to eq('background_check')
      end

      it "applicant's state is confirmation" do
        expect(assigns(:applicant).state).to eq('confirmation')
      end

    end
  end
end