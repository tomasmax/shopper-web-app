class AddStateAndBackgroundCheckAcceptanceToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :state, :string
    add_column :applicants, :background_check_acceptance, :boolean
  end
end
