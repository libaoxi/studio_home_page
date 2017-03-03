class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :remeber_token
      t.boolean :is_admin

      t.timestamps
    end
  end
end
