# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
roles_array=['Super Admin', 'Customer']

roles_array.each do |role|
  Role.create!(name: role)
end


user = User.new

user.first_name            = 'Amdin'
user.last_name             = 'Amdin'
user.email                 = 'admin@gmail.com'
user.password              = '123456'
user.password_confirmation = '123456'
user.phone                 = '123456'
user.save(validate: false)

user.add_role(AppConstants::SUPER_ADMIN)