class Build < ActiveRecord::Base
  validates :uuid, uniqueness: true
end
