class Request < ApplicationRecord
  belongs_to :user
  belongs_to :requested_friend, class_name: "User"
end
