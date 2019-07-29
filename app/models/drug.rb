class Drug < ApplicationRecord
  validates_uniqueness_of :name
  has_many :side_effect
  belongs_to :classification
  belongs_to :manufacturer
end
