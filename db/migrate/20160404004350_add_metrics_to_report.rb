class AddMetricsToReport < ActiveRecord::Migration
  def change
    add_column :reports, :volume, :boolean
    add_column :reports, :satisfaction, :boolean
    add_column :reports, :first_response_time, :boolean
    add_column :reports, :resolution_time, :boolean
    add_column :reports, :top_tags, :boolean
  end
end
