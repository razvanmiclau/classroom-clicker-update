class AddUuidToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :uuid, :string
    add_index :questions, :uuid, unique: true
  end
end
