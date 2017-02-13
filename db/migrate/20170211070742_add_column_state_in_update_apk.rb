class AddColumnStateInUpdateApk < ActiveRecord::Migration
    def change
        add_column :update_apks,:state,:string
    end
end
