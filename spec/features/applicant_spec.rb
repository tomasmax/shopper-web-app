require 'rails_helper'

feature 'Applicant' do
  scenario '2 step applicant form' do
    visit root_path
    within(:css, "div.info") do
      click_link('Apply Now')
    end
    
    elem = find(:css, '#applicant_first_name')
    fill_in elem[:name], with: Faker::Name.name

    elem = find(:css, '#applicant_last_name')
    fill_in elem[:name], with: Faker::Name.name

    elem = find(:css, '#applicant_email')
    fill_in elem[:name], with: Faker::Internet.email

    elem = find(:css, '#applicant_phone')
    fill_in elem[:name], with: Faker::PhoneNumber.subscriber_number(10)

    select('San Francisco Bay Area', from: 'applicant[region]')
    select('Blackberry', from: 'applicant[phone_type]')

    click_button('Submit')

    expect(page).to have_text("I hereby authorize and Instacart designated agents and representatives")
    click_button('Submit')

    expect(page).to have_text("Application finished")
  end
end