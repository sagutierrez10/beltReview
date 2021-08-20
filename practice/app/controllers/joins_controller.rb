class JoinsController < ApplicationController

  def create
    @join_event = Join.create(event: Event.find(params[:event_id]), user: current_user)
    if @join_event.valid?
      redirect_to :back
    end
  end

  def destroy
    @this_join = Join.find(params[:id])
    if @this_join
      @this_join.destroy
      redirect_to :back
    end
  end

end
