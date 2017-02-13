class CreateUpdateApks < ActiveRecord::Migration
  def change
    create_table :update_apks do |t|
      t.string :name
      t.integer :version
      t.string :filename

      t.timestamps
    end
  end
end
