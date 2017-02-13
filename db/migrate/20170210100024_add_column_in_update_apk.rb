class AddColumnInUpdateApk < ActiveRecord::Migration
    def change
        add_column :update_apks,:uuid,:string
    end
end
