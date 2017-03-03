class ChangeColumnUser < ActiveRecord::Migration
    def change
        rename_column :users,:remeber_token,:remeber_digest
    end
end
