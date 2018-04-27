class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class User < ApplicationRecord
  has_many :roles, through: :relationships
  has_many :permissions, as: :permitable
end

class Role < ApplicationRecord
  has_many :users, through: :relationships
  has_many :permissions, as: :permitable
end

class Relationships < ApplicationRecord
  belongs_to :user
  belongs_to :role
end

class Permission < ApplicationRecord
  belongs_to :permitable, polymorphic: true
end
