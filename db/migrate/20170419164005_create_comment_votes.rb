class CreateCommentVotes < ActiveRecord::Migration
	def change
		create_table :comment_votes do |t|
			t.integer :comment_id, null: false
			t.integer :user_id, null: false
			t.string :vote_type, null: false
		end
		add_foreign_key :comment_votes, :comments
		add_foreign_key :comment_votes, :users
	end
end
