class Symptom < ApplicationRecord
  validates_uniqueness_of :name
  has_many :side_effect
end
