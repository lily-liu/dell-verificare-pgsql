# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'bcrypt'

# Manager.delete_all
# User.delete_all
# City.delete_all
# Store.delete_all
# Sellin.delete_all
# Inventory.delete_all

Manager.create!(
    name: "manager1"
)

User.create!(
    username: 'admin',
    password_digest: BCrypt::Password.create("password"),
    level: 0,
    manager_id: 1,
    name: 'admin name',
    email: 'admin@email.com',
    phone: "8989898989",
    gender: 1
)

User.create!(
    username: 'admin2',
    password_digest: BCrypt::Password.create("password"),
    level: 0,
    manager_id: 1,
    name: 'admin name',
    email: 'admin1@email.com',
    phone: "8989898989",
    gender: 1
)

City.create!(
    name: 'Jakarta'
)

Store.create!(
    store_uid: 1,
    city_id: 1,
    name: 'Test Store',
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu'
)

Store.create!(
    store_uid: 2,
    city_id: 1,
    name: 'Test Store 2',
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu'
)

Sellin.create!(
    service_tag: "A123",
    quarter_year: 2015,
    quarter: 3,
    quarter_week: 10,
    item_type: 0,
    source_store: 1,
    target_store: 1
)
Sellin.create!(
    service_tag: "B456",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    target_store: 1
)

Inventory.create!(
    service_tag: "A123",
    status: 0,
    sellin_id: 1,
    store_id: 1,
    user_id: 1
)
