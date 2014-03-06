# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Status.create(name: "Not Started")
Status.create(name: "In Progress")
Status.create(name: "Finished")
Status.create(name: "Delayed")
Status.create(name: "Abandoned")

admin_role = Role.create!(name: "Manager")
Role.create(name: "Worker")
users = {
	"jamiees2@gmail.com" => "jeska193sajd"
}
users.each do |email,password|
	if User.find_by_email(email).blank?
		puts "Creating user #{email} with password: #{password}"
		user = User.create!(email: email.dup, password: password.dup, password_confirmation: password.dup)
    user.roles << admin_role
	end
end
