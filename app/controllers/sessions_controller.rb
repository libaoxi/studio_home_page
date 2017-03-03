class SessionsController < ApplicationController
    #访问登陆页面
    def login
    end

    #请求登陆
    def sign_in
        if !params[:name] || !params[:password]
            flash[:notice] = '用户名或密码不能为空!'
            render action:'login'
        else
            @user = User.find_by_name(params[:name])
            if @user.authenticate(params[:password])
                session[:user_id] = @user.id
                session[:sign_in_datetime] = Time.now
                redirect_to update_apks_path
            else
                flash[:notice] = '该用户没有注册！'
                render action:'login'
            end
        end
    end

    #请求登出
    def sign_out
        session[:user_id] = nil
        render action:'login'
    end

    def is_login
        if session[:user_id].nil?
            render action:'login'
        end
    end
end
