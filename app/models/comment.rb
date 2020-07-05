class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: "User"
  belongs_to :state, optional: true

  scope :persisted, -> { where.not(id: nil) }
  scope :ordered, -> { order(created_at: :asc) }

  validates :text, presence: true

  after_create :set_ticket_state

  private

  def set_ticket_state
    ticket.state = state
    ticket.save!
  end
end
