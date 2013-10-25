# Public:
#
# Example:
#
#
#
#
#
class NotificationSettingsController < ApplicationController

  def update
    @notification_setting = NotificationSetting.find(params[:id])
    if @notification_setting.update_attributes(update_params)
      render json: @notification_setting
    else
      render :json => @notification_setting.errors.full_messages, status: 422
    end

  end

  private
    def update_params
      params.require(:notification_settings).permit(  :vote,
                                                      :idea,
                                                      :idea_thread,
                                                      :sound
                                                    )
    end
end
