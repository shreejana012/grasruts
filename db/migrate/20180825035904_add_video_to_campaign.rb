class AddVideoToCampaign < ActiveRecord::Migration[5.1]
  def change
    add_column :campaigns, :video, :string
  end
end