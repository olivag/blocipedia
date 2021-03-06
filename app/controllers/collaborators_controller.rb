class CollaboratorsController < ApplicationController
  def create

    new_user_ids = params[:collaborator][:user_id]

    new_user_ids.each do |id|
      break if id.blank?

      Collaborator.create(
        wiki_id: params[:collaborator][:wiki_id],
        user_id: id
      )
    end
    redirect_to :back
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @collaborator.delete
    redirect_to :back
  end
end