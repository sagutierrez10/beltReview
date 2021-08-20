class EventsController < ApplicationController

  def index
    @user = User.find(session[:user_id])
    @users = User.all
    @events_in_state = Event.all.where(state: @user.state)
    @events_other_state = Event.all.where.not(state: @user.state)


  end
  def show
    @event = Event.find(params[:id])
    @comments = @event.comments
  end
  def edit
    @this_event = Event.find_by(id: params[:id])
    render text: "Doesn't say to have a template to change this event."
  end

  def create
    @event = Event.create(event_params)
    if @event.save
      redirect_to :back
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @this_event = Event.find_by(id: params[:id])
    if current_user == @this_event.user
      @this_event.destroy
      return redirect_to :back
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :city,:state, :user_id)
  end
end
