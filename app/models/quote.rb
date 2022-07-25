class Quote < ApplicationRecord

  belongs_to :company
  has_many :line_item_dates, dependent: :destroy

  validates :name, presence: true

  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

  scope :ordered, -> { order(id: :desc) }
end
