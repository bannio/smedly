class HandlesController < ApplicationController

  def index
    if params[:q] && params[:q] != ""
      tags = params[:q].split(",")
      if params[:type] == "OR"
        @handles = Handle.tagged_with(tags, any: true, wild: true)#.order("LOWER(name)")
      else
        @handles = Handle.tagged_with(tags)#.order("LOWER(name)")
      end
    else
      @handles = Handle.all.order("LOWER(name)")
    end
  end

  def show
    @handle = Handle.find(params[:id])
  end

  def new
    @handle = Handle.new
  end

  def create
    @handle = Handle.new
    @handle.tag_list = params[:handle][:tag_list] # replaces existing tags
    @handle.name = params[:handle][:name]
    @handle.notes = params[:handle][:notes]
    @handle.following = params[:handle][:following]
    if @handle.save
      redirect_to handles_path
    else
      flash.now[:alert] = "This handle name may already be in use"
      render 'new'
    end
  end

  def autocomplete_tags
    @tags = ActsAsTaggableOn::Tag.
      where("name LIKE ?", "#{params[:q]}%").
      order(:name)
    respond_to do |format|
      format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
    end
  end

  def refresh
    # refresh twitter stats
    @handle = Handle.find(params[:id])
    @handle.refresh_twitter_stats
    @handle.save
    redirect_to @handle
  end

  def refresh_all
    # refresh all handles' twitter stats
    handles = Handle.updated_more_than_a_week_ago.to_a
    if !handles.empty?
      RefreshAllStats.perform_later(handles)
      flash[:notice] = "Refresh in progress - updating #{view_context.pluralize(handles.count, 'entry')}"
    else
      flash[:notice] = "Everything up to date"
    end
    redirect_to handles_path
  end

  def update
    @handle = Handle.find(params[:id])
    @handle.tag_list = params[:handle][:tag_list] # replaces existing tags
    @handle.name = params[:handle][:name]
    @handle.notes = params[:handle][:notes]
    @handle.following = params[:handle][:following]

    if @handle.save
      redirect_to @handle
    else
      flash.now[:alert] = "The update was not saved due to an error"
      render 'show'
    end
  end

  def destroy
    @handle = Handle.find(params[:id])
    @handle.destroy
    redirect_to handles_path
  end

  private

  def handle_params
    params.require(:handle).permit(:name, :notes, :followers, :following, :tag_list)
  end
end
