# Public:
#
# Example:
#
#
#
#
#
class ActivitiesController < ApplicationController

  def index
    get_activities
    render json: @activities
  end

  def show
    @activity = PublicActivity::Activity.find(params[:id])
    render json: @activity
  end

  private
    def get_activities
      if params[:idea_id]
        get_idea
        @activities = @idea.related_activities
      else
        @activities = PublicActivity::Activity.all
      end
    end

    def get_idea
      @idea    = Idea.find(params[:idea_id])
    end
end
