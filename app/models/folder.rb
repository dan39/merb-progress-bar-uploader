class Folder < ActiveRecord::Base
                      acts_as_tree :order => "title"
                     has_many :basefiles, :dependent => :destroy
 # =>                      
 # =>                      has_many :user_roles
 # =>                       has_many :roles, :through => :user_roles
 # =>                     
 # =>                     #def has_role?(role)
 # =>                     #     self.roles.count(:conditions => ['name = ?', role]) > 0
 # =>                     #   end
 # =>                     #
 # =>                     #   def add_role(role)
 # =>                     #     return if self.has_role?(role)
 # =>                     #     self.roles << Role.find_by_name(role)
 # =>                     #   end
## =>                      =>         1
## =>                      =>         2
## =>                      =>         3
## =>                      =>           def has_role?(role)
## =>                      =>             self.roles.count(:conditions => ['name = ?', role]) > 0 || self.is_admin?
## =>                      =>           end
 # =>                          
 # =>                        def has_rolea?(role)  
 # =>                          @role_names = self.find(session[:user]).roles.map(&:name)
 # =>                            unless @role_names.include?(role)
 # =>                              true
 # =>                            else
 # =>                              false
 # =>                              
 # =>                            end
 # =>                        end
 # =>                          
end