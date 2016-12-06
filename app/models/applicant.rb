class Applicant < ActiveRecord::Base
  
  PHONE_TYPES = ['iPhone 6/6 Plus', 'iPhone 6s/6s Plus', 'iPhone 5/5S', 'iPhone 4/4S', 'iPhone 3G/3GS', 'Android 4.0+ (less than 2 years old)', 'Android 2.2/2.3 (over 2 years old)', 'Windows Phone', 'Blackberry', 'Other']
  REGIONS = ['San Francisco Bay Area', 'Chicago', 'Boston', 'NYC', 'Toronto', 'Berlin', 'Delhi']
  WORKFLOW_STATES = ['applied', 'quiz_started', 'quiz_completed', 'onboarding_requested', 'onboarding_completed', 'hired', 'rejected']

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true, numericality: {only_integer: true}
  validates :phone_type, presence: true
  validates :workflow_state, presence: true
  validates :region, presence: true

  before_validation :set_first_workflow_state, on: :create

  state_machine :state, initial: :basic_info do
    event :next_step do
      transition basic_info: :background_check
      transition background_check: :confirmation
    end

    state :basic_info
    state :background_check
    state :confirmation
  end


  class << self

    def funnel_time_analytics(start_date:, end_date:)
      #set the beginning of the day to the start date
      start_date = start_date.beginning_of_day
      #set the end of the day to the end date
      end_date   = end_date.end_of_day

      #Postgresql trunc to obtain weekly intervals in the result
      week_interval = "DATE_TRUNC('week', created_at)::date"
      result = Applicant.where(created_at: (start_date..end_date))
                        .group(week_interval, :workflow_state)
                        .order(week_interval)
                        .count

      funnel_result_json_formatter(result)
    end

    private

    def funnel_result_json_formatter(result)
      
      formated_hash = Hash.new { |hash, key| hash[key] = {} }
      result.each do |object, count|
        start_of_week = object[0]
        end_of_week = start_of_week.end_of_week
        key = "#{start_of_week.strftime("%Y-%m-%d")}-#{end_of_week.strftime("%Y-%m-%d")}"
        formated_hash[key][object[1]] = count
      end
      formated_hash
    end
  end

  private

    def set_first_workflow_state
        self.workflow_state ||= WORKFLOW_STATES.first
    end
end
