class ChangeVersionColumnVersion < ActiveRecord::Migration
    def change
        change_column :versions,:version,:float
    end
end
