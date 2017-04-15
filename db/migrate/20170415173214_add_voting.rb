class AddVoting < ActiveRecord::Migration
	def change
		create_table :question_votes do |t|
			t.integer :question_id, null: false
			t.integer :user_id, null: false
		end
		create_table :answer_votes do |t|
			t.integer :answer_id, null: false
			t.integer :user_id, null: false
		end
		add_foreign_key :question_votes, :questions
		add_foreign_key :question_votes, :users
		add_foreign_key :answer_votes, :answers
		add_foreign_key :answer_votes, :users
	end
end
