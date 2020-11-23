class Category < ApplicationRecord
  belongs_to :technology
  has_many :repositories
end
