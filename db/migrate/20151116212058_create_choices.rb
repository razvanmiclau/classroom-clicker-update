class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.references :question, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
  end
end
