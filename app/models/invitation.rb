class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :friender, class_name: "User"
end
