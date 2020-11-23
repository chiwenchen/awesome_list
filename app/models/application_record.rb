require 'pg'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.connection
end
