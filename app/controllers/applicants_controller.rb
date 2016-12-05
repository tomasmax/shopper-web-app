class ApplicantsController < ApplicationController
  before_action :authenticate, only: [:edit, :update, :apply]
  before_action :logged_in?, only: [:new]


  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.next_step
      log_in(@applicant)
      redirect_to apply_applicants_path
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if current_applicant.update(applicant_params)
      redirect_to apply_applicants_path
    else
      render :edit
    end
  end

  # Managing multistep creation form, each step is rendered by apply and processed by next_step
  # It would work adding many steps as we need in the future
  def apply
  end

  def next_step
    current_applicant.assign_attributes applicant_params
    current_applicant.next_step
    redirect_to apply_applicants_path
  end

  private

  def applicant_params
    params.require(:applicant).permit(:first_name, 
                                      :last_name, 
                                      :email,
                                      :phone, 
                                      :phone_type,
                                      :region, 
                                      :background_check_acceptance)
  end

end
