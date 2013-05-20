class Cart < ActiveRecord::Base
  attr_accessible :user_id

  validates :user, presence: true

  has_many :line_items, as: :referable
  belongs_to :user
end