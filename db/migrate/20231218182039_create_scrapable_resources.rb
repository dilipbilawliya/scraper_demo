class CreateScrapableResources < ActiveRecord::Migration[7.0]
  def change
    create_table :scrapable_resources do |t|
      t.string :url
      t.json :fields

      t.timestamps
    end
  end
end
