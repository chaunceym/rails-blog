class EventsController < ApplicationController
  # GET /events/index
  # Get /events
  def index
    @events = Event.all
  end
  #GET /events/new
  def new
    @event = Event.new 
  end
  #POST /events/create
  def create
    @event = Event.new(event_params) 
    @event.save
    # 重定向，提交资料后
    redirect_to :action => :index
  end

  # /events/show/:id
  def show
    @event = Event.find(params[:id])
  end

  # /events/edit/:id
  def edit
    @event = Event.find(params[:id])
  end
  # /events/update/:id
  def update
    @event = Event.find(params[:id])

    @event.update(event_params)
    redirect_to :action => :show ,:id => @event
  end
  # /events/destroy/:id
  def destroy
    @event = Event.find(params[:id])

    @event.destroy
    redirect_to :action => :index
  end
  # 因为表单提交有安全隐患，定制一个私有方法来控制表单提交的条件
  private 
  def event_params
    params.require(:event).permit(:name,:description)
  end
end
