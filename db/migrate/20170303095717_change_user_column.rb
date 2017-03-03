class ChangeUserColumn < ActiveRecord::Migration
    def change
        change_column :users,:is_admin,:string,:default=>false
    end
end
