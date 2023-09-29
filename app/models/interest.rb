class Interest < ApplicationRecord
  # belongs_to :sub_categories
  belongs_to :users, optional: true
end
