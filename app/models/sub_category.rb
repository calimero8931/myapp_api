class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :interests
  has_many :users, through: :interests

end
