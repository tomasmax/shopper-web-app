require 'rails_helper'

describe Applicant do
  describe '.funnel_time_analytics' do
    let(:currently) { DateTime.new(2016, 1, 1) }
    let(:start_of_week) { DateTime.new(2016, 1, 1).beginning_of_week.utc }
    let(:end_of_week) { DateTime.new(2016, 1, 1).end_of_week.utc }
    let(:one_week_later) { currently + 1.week }
    let(:key) { "#{start_of_week.strftime("%Y-%m-%d")}-#{end_of_week.strftime("%Y-%m-%d")}" }
    let(:result_hash)  { Hash.new }

    context 'no applicants' do
      it 'returns an empty hash' do
        expect(Applicant.funnel_time_analytics(start_date: start_of_week, end_date: end_of_week)).to eq(result_hash)
      end
    end

    context 'one applicant per workflow_sate for current week' do
      before do
        Applicant::WORKFLOW_STATES.each do |state|
          FactoryGirl.create(:applicant, workflow_state: state, created_at: currently)
        end

        result_hash[key] = {}

        Applicant::WORKFLOW_STATES.each do |state|
          result_hash[key][state] = 1
        end
      end

      it "return a hash counting weekly applicants per state" do
        expect(Applicant.funnel_time_analytics(start_date: start_of_week, end_date: end_of_week)).to eq(result_hash)
      end

    end

    context "applicants created in different weeks intervals" do
      before do
        Applicant::WORKFLOW_STATES.each do |state|
          FactoryGirl.create(:applicant, workflow_state: state, created_at: currently)
          FactoryGirl.create(:applicant, workflow_state: state, created_at: one_week_later)
        end

        week_2_start = one_week_later.beginning_of_week.strftime("%Y-%m-%d")
        week_2_end = one_week_later.end_of_week.strftime("%Y-%m-%d")
        key_2 = "#{week_2_start}-#{week_2_end}"

        result_hash[key] = {}
        result_hash[key_2] = {}

        Applicant::WORKFLOW_STATES.each do |state|
          result_hash[key][state] = 1
          result_hash[key_2][state] = 1
        end
      end

      it "return a hash with applicants counted per state in week intervals" do
        expect(Applicant.funnel_time_analytics(start_date: start_of_week, end_date: one_week_later.end_of_week)).to eq(result_hash)
      end
    end

    context "applicants created on the beginning and the end of the week" do
      before do
        Applicant::WORKFLOW_STATES.each do |state|
          FactoryGirl.create(:applicant, workflow_state: state, created_at: start_of_week.beginning_of_day)
          FactoryGirl.create(:applicant, workflow_state: state, created_at: end_of_week)
        end

        result_hash[key] = {}

        Applicant::WORKFLOW_STATES.each do |state|
          result_hash[key][state] = 2
        end
      end

      it "return a hash counting applicants weekly with their states, including with applicants in Monday and Sunday too" do
        expect(Applicant.funnel_time_analytics(start_date: start_of_week, end_date: end_of_week)).to eq(result_hash)
      end

    end
    
  end

end