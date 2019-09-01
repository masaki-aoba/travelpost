class AddCountrySpotToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :country_spot, :string
  end
end
