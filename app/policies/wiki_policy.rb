class WikiPolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      if user.nil? || user.standard?
        scope.where(private: false)
      else
        scope.all
      end
    end
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
