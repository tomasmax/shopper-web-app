require 'rails_helper'

feature 'Applicant' do
  scenario '2 step applicant sign up' do
    visit root_path
    within(:css, "div.info") do
      click_link('Apply Now')
    end
    
    elem = find(:css, '#applicant_name')
    fill_in elem[:name], with: Faker::Name.name

    elem = find(:css, '#applicant_last_name')
    fill_in elem[:name], with: Faker::Name.name

    elem = find(:css, '#applicant_email')
    fill_in elem[:name], with: Faker::Internet.email

    elem = find(:css, '#applicant_phone')
    fill_in elem[:name], with: Faker::PhoneNumber.cell_phone

    select('San Francisco Bay Area', from: 'applicant[region]')
    select('Blackberry', from: 'applicant[phone_type]')

    click_button('Submit')

    expect(page).to have_text("I give my authorization Instacart to investigate my background")
    click_button('Submit')

    expect(page).to have_text("Application Finished")
  end
end