class VersionsController < ApplicationController
    before_action :set_version, only: [:show, :edit, :update, :destroy]
    before_action :set_update_apk,only:[:index,:new,:edit,:create,:update,:destroy]
    before_action :save_file,only:[:create,:update]

    # GET /versions
    # GET /versions.json
    def index
        @versions = @update_apk.versions
    end

    # GET /versions/1
    # GET /versions/1.json
    def show
    end

    # GET /versions/new
    def new
        @version = Version.new(update_apk_id:params['update_apk_id'])
    end

    # GET /versions/1/edit
    def edit
    end

    # POST /versions
    # POST /versions.json
    def create
        @version = Version.new(version_params)
        @version.filename = params['version']['file'].original_filename
        @version.update_apk_id = version_params['update_apk_id'].to_i
        respond_to do |format|
            if @version.save
                format.html { redirect_to @version, notice: 'Version was successfully created.' }
                format.json { render :show, status: :created, location: @version }
            else
                format.html { render :new }
                format.json { render json: @version.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /versions/1
    # PATCH/PUT /versions/1.json
    def update
        @version.filename = version_params.original_filename
        respond_to do |format|
            if @version.update(version_params)
                format.html { redirect_to @version, notice: 'Version was successfully updated.' }
                format.json { render :show, status: :ok, location: @version }
            else
                format.html { render :edit }
                format.json { render json: @version.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /versions/1
    # DELETE /versions/1.json
    def destroy
        @version.destroy
        respond_to do |format|
            format.html { redirect_to update_apk_versions_path(@update_apk), notice: 'Version was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_version
        @version = Version.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def version_params
        params.require(:version).permit(:update_apk_id,:state,:version)
    end

    def set_update_apk
        if params['update_apk_id']
            @update_apk = UpdateApk.find(params['update_apk_id'])
        end
    end
    def save_file
        if Rails.env == 'development'
            file = '/Users/baoxi/Workspace/temp/'+params['version']['file'].original_filename
        elsif Rails.env == 'production'
            file = '/vagrant/static/apk/'+params['version']['file'].original_filename
        end
        if File.exist?(file)
            File.delete(file)
        end
        File.open(file,'wb') do |f|
            f.write(params['version']['file'].read)
        end
    end
end
