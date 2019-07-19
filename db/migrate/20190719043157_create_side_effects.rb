class CreateSideEffects < ActiveRecord::Migration[5.2]
  def change
    create_table :side_effects do |t|
      t.belongs_to :drug, foreign_key: true
      t.belongs_to :symptom, foreign_key: true

      t.timestamps
    end
  end
end
