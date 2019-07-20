class SideEffect < ApplicationRecord
  belongs_to :drug
  belongs_to :symptom
  validates_uniqueness_of :symptom_id, :scope => :drug_id
end
