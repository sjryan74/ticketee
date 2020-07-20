require 'rails_helper'

RSpec.feature "Users can receive notifications about ticket updates" do
  let(:alice) { FactoryBot.create(:user, email: "alice@example.com") }
  let(:bob) { FactoryBot.create(:user, email: "bob@example.com") }
  let(:project) { FactoryBot.create(:project) }
  let(:ticket) do
    FactoryBot.create(:ticket, project: project, author: alice)
  end

  before do
    ticket.watchers << alice

    login_as(bob)
    visit project_ticket_path(project, ticket)
  end

  scenario "ticket authors automatically receive notifications" do
    fill_in "Text",	with: "Is it out yet?"
    click_button "Create Comment"

    expect(page).to have_content "Comment has been created"  
    
    email = find_email!(alice.email)
    expected_subject = "[Tickets] #{project.name} - #{ticket.name}"
    expect(email.subject).to eq expected_subject
    
    # click_first_link_in_email(email)
    last_link_in_email = links_in_email(email).last
    visit request_uri(last_link_in_email) 
    expect(current_path).to eq project_ticket_path(project, ticket)  
  end

  scenario "comment authors do not receive emails" do
    fill_in "Text",	with: "Is it out yet?"
    click_button "Create Comment"
    
    email = find_email(bob.email)
    expect(email).to be_nil
  end
end