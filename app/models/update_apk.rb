class UpdateApk < ActiveRecord::Base
    has_many :versions
    def self.compare(uuid,version)
        puts uuid
        result = {}
        vs = self.find_by_uuid(uuid)
        if vs.nil?
            result[:errorInfo] = "找不到这个AppKey。"
            result[:errorCode] = -1 
            return result
        end
        vs = vs.versions.where('version >= ?',version)
        if vs.size == 0
            result[:errorInfo] = "未找到任何版本。"
            result[:errorCode] = -1
            return result
        end
        ft = [0,nil,nil]
        vs.each do |l|
            if l.version > ft[0]
                ft[0] = l.version
                ft[1] = l.filename
                ft[2] = l.state
            end
        end
        if ft[0] < version
            result[:errorInfo] = '用户版本高于数据库版本.'
            result[:errorCode] = -1
        elsif ft[0] == version
            result[:errorInfo] = '用户版本是最新版本.'
            result[:errorCode] = 1000
            result[:isUpdate] = 'no'
        elsif ft[0] > version
            result[:errorInfo] = '用户版本不是最新版本'
            result[:errorCode] = 1000
            ft[2] == '强制更新' ? result[:isUpdate] = 'must' : result[:isUpdate] = 'yes'
        end
        result[:downloadUrl] = 'http://60.10.135.153:5000/apk/'+ft[1]
        result
    end
end
