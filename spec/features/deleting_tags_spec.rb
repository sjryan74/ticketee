require 'rails_helper'

RSpec.feature "Users can delete unwanted tags from a ticket" do
  let (:user) { FactoryBot.create(:user) }
  let (:project) { FactoryBot.create(:project) }
  let (:ticket) do
    FactoryBot.create(:ticket,
      project: project,
      author: user,
      tags: [FactoryBot.create(:tag, name: "This tag must die")]
    )
  end

  before do
    login_as(user)
    visit project_ticket_path(project, ticket)
  end

  scenario "successfully", js: true do
    within tag("This tag must die") do
      click_link "Remove tag"
    end
    expect(page).to_not have_content "This tag must die"  
  end
end