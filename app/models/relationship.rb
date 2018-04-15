class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true  # not necessarily since Rails 5
  validates :followed_id, presence: true  # not necessarily since Rails 5
end
