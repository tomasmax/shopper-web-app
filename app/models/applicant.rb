class Applicant < ActiveRecord::Base
  
  PHONE_TYPES = ['iPhone 6/6 Plus', 'iPhone 6s/6s Plus', 'iPhone 5/5S', 'iPhone 4/4S', 'iPhone 3G/3GS', 'Android 4.0+ (less than 2 years old)', 'Android 2.2/2.3 (over 2 years old)', 'Windows Phone', 'Blackberry', 'Other']
  REGIONS = ['San Francisco Bay Area', 'Chicago', 'Boston', 'NYC', 'Toronto', 'Berlin', 'Delhi']
  WORKFLOW_STATES = ['applied', 'quiz_started', 'quiz_completed', 'onboarding_requested', 'onboarding_completed', 'hired', 'rejected']

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  validates :phone_type, presence: true
  validates :workflow_state, presence: true
  validates :region, presence: true

  before_validation :set_default_workflow_state, on: :create

  state_machine :state, initial: :basic_info do
    event :next_step do
      transition base: :background_check
      transition background_check: :confirmation
    end

    state :basic_info
    state :background_check
    state :confirmation
  end


  private

    def set_first_workflow_state
        self.workflow_state ||= WORKFLOW_STATES.first
    end
end
