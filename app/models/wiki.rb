class Wiki < ActiveRecord::Base
  belongs_to :user

  after_initialize :initialize_role

  private
    
    def initialize_role
      self.private = false if self.private.nil?
    end
end