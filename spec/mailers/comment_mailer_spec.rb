require "rails_helper"

RSpec.describe CommentMailer, type: :mailer do
  describe "new_comment" do
    let(:project) { FactoryBot.create(:project) }
    let(:ticket_owner) { FactoryBot.create(:user) }
    let(:ticket) do
      FactoryBot.create(:ticket,
        project: project, author: ticket_owner)
    end

    let(:commenter) { FactoryBot.create(:user) }
    let(:comment) do
      Comment.new(ticket: ticket, author: commenter,
        text: "Test Comment")
    end

    let(:email) do
      CommentMailer
        .with(comment: comment, user: ticket_owner)
        .new_comment
    end

    it "sends out an email notification about a new comment" do
      expect(email.to).to include ticket_owner.email
      title = "#{ticket.name} for #{project.name} has been updated"
      expect(email.message.to_s).to include title
      expect(email.message.to_s).to include "#{commenter.email} wrote:"
      expect(email.message.to_s).to include comment.text
    end
  end
end