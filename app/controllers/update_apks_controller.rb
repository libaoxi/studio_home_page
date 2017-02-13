class UpdateApksController < ApplicationController
    before_action :set_update_apk, only: [:show, :edit, :update, :destroy]
    # GET /update_apks
    # GET /update_apks.json
    def index
        @update_apks = UpdateApk.all
    end

    # GET /update_apks/1
    # GET /update_apks/1.json
    def show
    end

    # GET /update_apks/new
    def new
        @update_apk = UpdateApk.new(uuid:UUIDTools::UUID.timestamp_create.to_s)
    end

    # GET /update_apks/1/edit
    def edit
    end

    #比较版本
    def check_update
        respond_to do |format|
            format.json{render json: UpdateApk.compare(params[:appKey],params[:version].to_f) }
        end
    end

    # POST /update_apks
    # POST /update_apks.json
    def create
        @update_apk = UpdateApk.new(update_apk_params)
        # @update_apk.uuid = UUIDTools::UUID.timestamp_create.to_s
        respond_to do |format|
            if @update_apk.save
                format.html { redirect_to @update_apk, notice: 'Update apk was successfully created.' }
                format.json { render :show, status: :created, location: @update_apk }
            else
                format.html { render :new }
                format.json { render json: @update_apk.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /update_apks/1
    # PATCH/PUT /update_apks/1.json
    def update
        respond_to do |format|
            if @update_apk.update(update_apk_params)
                format.html { redirect_to @update_apk, notice: 'Update apk was successfully updated.' }
                format.json { render :show, status: :ok, location: @update_apk }
            else
                format.html { render :edit }
                format.json { render json: @update_apk.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /update_apks/1
    # DELETE /update_apks/1.json
    def destroy
        @update_apk.destroy
        respond_to do |format|
            format.html { redirect_to update_apks_url, notice: 'Update apk was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_update_apk
        @update_apk = UpdateApk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_apk_params
        params.require(:update_apk).permit(:name,:uuid)
    end
end
