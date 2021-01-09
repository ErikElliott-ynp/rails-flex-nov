class ChirpsController < ApplicationController
    before_action :require_logged_in, only: [:edit, :update]

    def edit
        @chirp = Chirp.find_by(id: params[:id])
        render :edit
    end

    def update
        @chirp = Chirp.find_by(id: params[:id])
        # @chirp = current_user.chirps.find_by(id: params[:id])

        # if @chirp && @chirp.update(chirp_params)
        if @chirp.user_id == current_user.id && @chirp.update(chirp_params)
            redirect_to user_url(@chirp.user_id)
        else
            flash.now[:errors] = ["You can't do that silly"]
            render :edit
        end
    end

    private 
    def chirp_params
        params.require(:chirp).permit(:body)
    end

end
