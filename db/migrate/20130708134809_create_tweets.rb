class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.time :tweeted_at
      t.integer :twitter_user_id
      t.timestamps
    end
  end
end
