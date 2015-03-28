class HandlesController < ApplicationController

  def index
    if params[:q] && params[:q] != ""
      @handles = Handle.tagged_with(params[:q])
    else
      @handles = Handle.all
    end
  end

  def show
    @handle = Handle.find(params[:id])
  end

  def autocomplete_tags
    @tags = ActsAsTaggableOn::Tag.
      where("name LIKE ?", "#{params[:q]}%").
      order(:name)
    respond_to do |format|
      format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
    end
  end

  def update
    @handle = Handle.find(params[:id])
    @handle.tag_list = params[:handle][:tag_list]
    # @handle.tag_list.add(params[:handle][:tag_list], parse: true)
    @handle.name = params[:handle][:name]
    @handle.save
    redirect_to @handle
  end

  private

  def handle_params
    params.require(:handle).permit(:name, :notes, :followers, :following, tag_list: [])
  end
end
