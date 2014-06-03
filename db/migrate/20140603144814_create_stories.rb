class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
    	t.string :title
    	t.integer :score

    	t.timestamps
    end
  end
end
