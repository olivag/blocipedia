class CollaboratorsController < ApplicationController
  def create
    @collaborator = Collaborator.new(collab_params)
    @collaborator.save

    redirect_to @collaborator.wiki
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @collaborator.delete
    redirect_to @collaborator.wiki
  end

  def collab_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end