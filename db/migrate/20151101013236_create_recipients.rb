class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.references :report, index: true
      t.string :email

      t.timestamps
    end
  end
end
