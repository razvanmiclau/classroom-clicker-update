class AddEngagementRateToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :engagement_rate, :integer
  end
end
