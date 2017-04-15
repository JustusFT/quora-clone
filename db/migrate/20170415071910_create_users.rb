class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :full_name
			t.string :email, unique: true
			t.string :password
			t.string :password_digest
		end
	end
end
