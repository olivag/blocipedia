class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.nil?
        return scope.where(private: false)
      end
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !(wiki.private?) || wiki.owner == user || wiki.collaborators.include?(user)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !(wiki.private?) || wiki.collaborators.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end

   # def resolve
    #   if user.nil? || user.standard?
    #     scope.where(private: false)
    #   else
    #     scope.all
    #   end
    # end
  end
  
  def update?
    edit?
  end

  def create?
    user.present?
    ##is this code necessary because authenticate_user method is
    ##already making sure someone is logged in, which is
    ##the only requirement to create a wiki, is it only 
    ##neccesary because of the application policy?
  end

  def new?
    user.present?
  end

  def edit?
    user == record.user || user.admin?
  end

  def destroy?
    edit?
  end
  
  # def show?
    ## How do i put the show action logic here from the controller,
    ## would it redirect from here, should i just keep it on,
    ## controller
  # end
end
