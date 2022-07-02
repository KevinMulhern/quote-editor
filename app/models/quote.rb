class Quote < ApplicationRecord
  validates :name, presence: true

  broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend

  scope :ordered, -> { order(id: :desc) }
end
