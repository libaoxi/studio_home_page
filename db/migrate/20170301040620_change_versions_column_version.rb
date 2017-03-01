class ChangeVersionsColumnVersion < ActiveRecord::Migration
    def change
        change_column :versions,:version,:string
    end
end
