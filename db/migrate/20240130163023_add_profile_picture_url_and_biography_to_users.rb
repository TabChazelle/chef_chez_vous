class AddProfilePictureUrlAndBiographyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :profile_picture_url, :string
    add_column :users, :biography, :text
  end
end
