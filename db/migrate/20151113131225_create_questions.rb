class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions, :id => false do |t|
      t.string :title
      t.string :kind
      t.string :uuid, :primary => true
      t.references :topic, type: :uuid, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
