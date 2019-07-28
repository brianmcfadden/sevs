class AddClassificationToDrugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :drugs, :classification, foreign_key: true
  end
end
