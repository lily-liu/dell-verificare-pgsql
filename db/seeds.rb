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
    username: 'dashboard',
    password_digest: BCrypt::Password.create("password"),
    level: 1,
    manager_id: 1,
    name: 'admin name',
    email: 'admin1@email.com',
    phone: "8989898989",
    gender: 1
)

User.create!(
    username: 'area_manager',
    password_digest: BCrypt::Password.create("password"),
    level: 2,
    manager_id: 1,
    name: 'admin name',
    email: 'admin2@email.com',
    phone: "8989898989",
    gender: 1
)

User.create!(
    username: 'promoter',
    password_digest: BCrypt::Password.create("password"),
    level: 3,
    manager_id: 1,
    name: 'admin name',
    email: 'admin3@email.com',
    phone: "8989898989",
    gender: 1
)

User.create!(
    username: 'merchandiser',
    password_digest: BCrypt::Password.create("password"),
    level: 4,
    manager_id: 1,
    name: 'admin name',
    email: 'admin4@email.com',
    phone: "8989898989",
    gender: 1
)

User.create!(
    username: 'sales_representative',
    password_digest: BCrypt::Password.create("password"),
    level: 5,
    manager_id: 1,
    name: 'admin name',
    email: 'admin5@email.com',
    phone: "8989898989",
    gender: 1
)

Region.create!(
    name: 'Jabodetabek',
    position: 1
)

City.create!(
    name: 'Jakarta',
    region_id: 1
)

Store.create!(
    store_uid: "STR-139",
    city_id: 1,
    name: 'Genius Intel',
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 1
)

Store.create!(
    store_uid: "STR-251",
    city_id: 1,
    name: 'Genius NBC',
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 0
)
Store.create!(
    store_uid: "STR-1445",
    city_id: 1,
    name: 'HnD Computer 1',
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 2
)
Store.create!(
    store_uid: "STR-3913",
    city_id: 1,
    name: 'HnD Computer 2',
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 2
)
Store.create!(
    store_uid: "STR-1208",
    city_id: 1,
    name: 'Amunisi Com',
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 2
)
Store.create!(
    store_uid: "STR-530",
    city_id: 1,
    name: 'Celebes Computer Centre',
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 2
)

Sellin.create!(
    service_tag: "4TB8J52",
    quarter_year: 2015,
    quarter: 3,
    quarter_week: 10,
    item_type: 0,
    source_store: 1,
    target_store: 1
)
Sellin.create!(
    service_tag: "HHH0L52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    target_store: 1
)
Sellin.create!(
    service_tag: "H8D9J52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    target_store: 1
)
Sellin.create!(
    service_tag: "DQB8J52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    target_store: 1
)
Sellin.create!(
    service_tag: "42QVK52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    target_store: 1
)
Sellin.create!(
    service_tag: "DFC9J52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    target_store: 1
)
Sellin.create!(
    service_tag: "4YPVK52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    target_store: 1
)
