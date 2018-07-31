class Coord < ApplicationRecord
  belongs_to :user, optional: true
end
