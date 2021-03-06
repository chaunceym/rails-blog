class EventsController < ApplicationController
  before_action :authenticate_user! ,:except => [:index]
  before_action :set_event, :only => [:show,:edit,:update,:destroy,:dashboard]
  # GET /events/index
  # Get /events
  def index
    if params[:keyword]
      @events = Event.where(["name like ?", "%#{params[:keyword]}%"])
    else
      @events = Event.all
    end

    if params[:order]
      sort_by = (params[:order] == "name") ? "name" : "id"
      @events = @events.order(sort_by)
    end

    @events = @events.page(params[:page]).per(10)
    @event = Event.new 
    respond_to do |format| 
      format.html
      format.xml {
        render :xml => @events.to_xml
      }
      format.json {
        render :json => @events.to_json
      }
      format.atom {
        @feed_title = "My event list" }
    end
  end

  def latest
    @events = Event.order("id DESC").limit(3)
  end
  def bulk_update
    ids = Array(params[:ids])
    events = ids.map{ |i| Event.find_by_id(i) }.compact
    if params[:commit] == "Delete"
      events.each{|e| e.destroy}
    elsif params[:commit] == "Publish"
      events.each{|e| e.update(:status => "published")}
    end
    redirect_to events_path
  end
  #POST /events
  def create
    @event = Event.new(event_params) 
    @event.user = current_user
    if @event.save
      flash[:notice] = "新增成功"
      # 重定向，提交资料后
      redirect_to events_path
    else
      render :action => :new 
    end  
  end
  # GET /events/:id 
  def show 
    @page_title = @event.name 

    respond_to do |format| 
      format.html{
        @page_title = @event.name
      }
      format.xml
      format.json {
        render :json => {id: @event.id, name:@event.name}.to_json
      }
    end
  end 

  def dashboard

  end
  # POST /events/:id/edit 
  def edit
  end 
  # PATCH /events/:id
  def update
    if @event.update(event_params)
      flash[:notice] = "更新成功"
      redirect_to event_path(@event)
    else
      render :action => :edit
    end
  end
  # DELETE /events/:id
  def destroy
    @event.destroy
      flash[:alert] = "删除成功"
    redirect_to events_path
  end
  # 因为表单提交有安全隐患，定制一个私有方法来控制表单提交的条件
  private 
  def set_event
    @event = Event.find(params[:id])
  end
  def event_params
    params.require(:event).permit(:name,:description, :category_id,:status,:group_ids => [])
  end
end
