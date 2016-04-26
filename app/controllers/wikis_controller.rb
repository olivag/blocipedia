class WikisController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]
  after_action :verify_policy_scoped, only: :index
  after_action :verify_authorized, only: [:create, :new]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    #Only admins and Premium members can view private wikis
    #Guests and public users can view public wikis
    if @wiki.private
      if current_user.nil?
        flash[:alert] = "You must be signed in and a Premium member to view private wikis."
        redirect_to new_user_session_path
      elsif current_user.standard?
        flash[:alert] = "You must be a Premium member to view private wikis."
        redirect_to wikis_path
      end     
    end
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    # if @wiki.private && current_user.standard?
    #   flash[:alert] = "You must be a Premium member to view private wikis."
    #   redirect_to wikis_path
    # end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title.chop}\" has been deleted."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleteing the wiki. Please try again."
      redirect_to @wiki
    end
  end

  private

    def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || wikis_path)
    end
end
