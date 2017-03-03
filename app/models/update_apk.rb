class UpdateApk < ActiveRecord::Base
    has_many :versions
    DURL = 'http://60.10.135.153:5000/apk/'
    def compare(uuid,version)
        result = {}
        vs = self.class.find_by_uuid(uuid)
        if vs.nil?
            result[:errorInfo] = "找不到这个AppKey。"
            result[:errorCode] = -1 
            return result
        end
        vs = vs.versions
        if vs.size == 0
            result[:errorInfo] = "未找到任何版本。"
            result[:errorCode] = -1
            return result
        end
        ft = ["0.0.0",nil,'不强制更新']
        vs.each do |l|
            if diff(l.version,ft[0]) == 1
                ft[0] = l.version
                ft[1] = l.filename
                ft[2] = l.state if l.state == '强制更新'
            end
        end
        case diff(ft[0],version)
        when -1
            result[:errorInfo] = '用户版本高于数据库版本.'
            result[:errorCode] = -1
        when 0
            result[:errorInfo] = '用户版本是最新版本.'
            result[:errorCode] = 1000
            result[:isUpdate] = 'no'
        when 1
            result[:errorInfo] = '用户版本不是最新版本'
            result[:errorCode] = 1000
            ft[2] == '强制更新' ? result[:isUpdate] = 'must' : result[:isUpdate] = 'yes'
        end
        result[:downloadUrl] = DURL+ft[1]
        result
    end

    #获取最新版本app，异常返回真财网
    def latest(uuid)
        begin
            filename = DURL+self.class.find_by_uuid(uuid).versions.order(updated_at: :desc).first.filename
        rescue
            filename = 'http://www.zc12369.com'
        end
    end

    private
    def diff(v1,v2)
        v1 = v1.split('.')
        v2 = v2.split('.')
        (0..2).each do |n|
            v = (v1[n] <=> v2[n])
            return v if v == 1
            return v if v == -1 
        end
        return 0
    end
end
