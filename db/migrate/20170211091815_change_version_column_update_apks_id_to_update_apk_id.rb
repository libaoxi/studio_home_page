class ChangeVersionColumnUpdateApksIdToUpdateApkId < ActiveRecord::Migration
    def change
        rename_column :versions,:update_apks_id,:update_apk_id
    end
end
