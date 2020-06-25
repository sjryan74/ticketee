class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: "User"

  scope :persisted, -> { where.not(id: nil) }
  scope :ordered, -> { order(created_at: :asc) }

  validates :text, presence: true
end
