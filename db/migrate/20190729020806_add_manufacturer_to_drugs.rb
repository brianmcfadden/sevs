class AddManufacturerToDrugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :drugs, :manufacturer, foreign_key: true
  end
end
