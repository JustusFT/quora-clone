class AddComments < ActiveRecord::Migration
	def change
		create_table :comments do |t|
			t.string :comment, null: false
			t.integer :user_id, null: false
			t.integer :answer_id, null: false
		end
		add_foreign_key :comments, :users
		add_foreign_key :comments, :answers
	end
end
