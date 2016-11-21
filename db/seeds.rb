# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'bcrypt'

User.create!([
        username: 'admin'  ,
        password_digest: BCrypt::Password.create("my password"),
        level: 0,
        name: 'admin name',
        email: 'admin@email.com',
        phone: 8989898989,
        gender: 1
      ])
