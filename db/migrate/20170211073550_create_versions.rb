class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :update_apks
      t.string :state
      t.integer :version
      t.string :filename
      t.timestamps
    end
    remove_column :update_apks,:version
    remove_column :update_apks,:state
    remove_column :update_apks,:filename
  end
end
