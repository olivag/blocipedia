class Wiki < ActiveRecord::Base
  belongs_to :user

  after_initialize :initialize_role

  #scope :visible_to, -> (user) { user ? where(private: false) : all }

  def self.set_to_public_wikis(user)
    @wikis = user.wikis.where(private: true)
    @wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
  end

  private
    
    def initialize_role
      self.private = false if self.private.nil?
    end
end