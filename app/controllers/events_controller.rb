class EventsController < ApplicationController
  before_action :set_event, :only => [:show,:edit,:update,:destroy]
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
    if @event.save
      flash[:notice] = "新增成功"
      # 重定向，提交资料后
      redirect_to :action => :index
    else
      render :action => :new 
    end  
  end # /events/show/:id def show @page_title = @event.name end # /events/edit/:id def edit end # /events/update/:id
  def update
    if @event.update(event_params)
      flash[:notice] = "更新成功"
      redirect_to :action => :show ,:id => @event
    else
      render :action => :edit
    end
  end
  # /events/destroy/:id
  def destroy
    @event.destroy
      flash[:alert] = "删除成功"
    redirect_to :action => :index
  end
  # 因为表单提交有安全隐患，定制一个私有方法来控制表单提交的条件
  private 
  def set_event
    @event = Event.find(params[:id])
  end
  def event_params
    params.require(:event).permit(:name,:description)
  end
end
