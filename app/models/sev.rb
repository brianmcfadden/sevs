class Sev
  include ActiveModel::Model
  attr_accessor :drug, :symptom
  validates :drug, presence: true
  validates :symptom, presence: true
end
