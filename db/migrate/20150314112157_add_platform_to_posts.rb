class AddPlatformToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :platform, index: true
  end
end
