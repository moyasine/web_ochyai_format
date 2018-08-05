class Templete < ApplicationRecord
  validates :what_thing, length: { in: 1..150 }
  validates :where_good, length: { in: 1..150 }
  validates :where_kimo, length: { in: 1..150 }
  validates :how_effective, length: { in: 1..150 }
  validates :what_discussion, length: { in: 1..150 }
  validates :what_next, length: { in: 1..150 }
end
