class AddReferencesToRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :requests, :friender, foreign_key: {to_table: :users}, index: true
    add_reference :requests, :friendee, foreign_key: {to_table: :users}, index: true
  end
end
