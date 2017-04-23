class AddVoting < ActiveRecord::Migration
	def change
		create_table :votes do |t|
			t.integer :user_id, null: false
			t.integer :voting_id, null: false
			t.string :type, null: false
			t.string :vote_type, null: false
		end
		add_foreign_key :votes, :users
		add_index :votes, :type
		add_index :votes, :vote_type
	end
end
