class MakeLikesPolymorphic < ActiveRecord::Migration[7.0]
  def change
    remove_reference :likes, :post, foreign_key: true
    add_reference :likes, :likeable, polymorphic: true, index: true
  end
end
