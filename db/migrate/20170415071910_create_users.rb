class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :full_name, null: false
			t.string :email, unique: true, null: false
			t.string :password_digest
			t.timestamps
		end
	end
end
