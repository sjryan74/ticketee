require 'rails_helper'

RSpec.feature "Admins can manage states" do
  # The following line is only required if there is not already a state called 'New'
  # in the development database.
  let!(:state) { FactoryBot.create :state, name: "A State" }

  before do
    login_as(FactoryBot.create(:user, :admin))
    visit admin_states_path
  end

  scenario "and mark a state as default" do
    within list_item("A State") do
      click_link "Make Default"
    end

    expect(page).to have_content "'A State' is now the default state"  
  end
end