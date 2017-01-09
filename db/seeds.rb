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

Manager.create!(
    name: "manager2"
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
    username: 'promoter2',
    password_digest: BCrypt::Password.create("password"),
    level: 3,
    manager_id: 2,
    name: 'admin name',
    email: 'admin32@email.com',
    phone: "8989898989",
    gender: 1
)

User.create!(
    username: 'merchandiser',
    password_digest: BCrypt::Password.create("password"),
    level: 4,
    manager_id: 2,
    name: 'admin name',
    email: 'admin4@email.com',
    phone: "8989898989",
    gender: 1
)

User.create!(
    username: 'sales_representative',
    password_digest: BCrypt::Password.create("password"),
    level: 5,
    manager_id: 2,
    name: 'admin name',
    email: 'admin5@email.com',
    phone: "8989898989",
    gender: 1
)

User.create!(
    username: 'store',
    password_digest: BCrypt::Password.create("password"),
    level: 6,
    manager_id: 2,
    name: 'admin name',
    email: 'admin6@email.com',
    phone: "8989898989",
    gender: 1
)

Region.create!(
    name: 'Jabodetabek',
    position: 0
)

Region.create!(
    name: 'Jabar-Jateng-Jogja',
    position: 1
)
Region.create!(
    name: 'Jatim-Sulawesi-Kalimantan',
    position: 2
)
Region.create!(
    name: 'Sumatra',
    position: 3
)

City.create!(
    name: 'Jakarta',
    region_id: 1
)

City.create!(
    name: 'Bandung',
    region_id: 1
)

Store.create!(
    store_uid: "STR-139",
    city_id: 1,
    name: 'Genius Intel',
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    level: 0,
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
    level: 1,
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 0
)
Store.create!(
    store_uid: "STR-1445",
    city_id: 1,
    name: 'HnD Computer 1',
    level: 2,
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 2
)
Store.create!(
    store_uid: "STR-3913",
    city_id: 2,
    name: 'HnD Computer 2',
    level: 0,
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 2
)
Store.create!(
    store_uid: "STR-1208",
    city_id: 2,
    name: 'Amunisi Com',
    level: 1,
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 2
)
Store.create!(
    store_uid: "STR-530",
    city_id: 2,
    name: 'Celebes Computer Centre',
    level: 2,
    address: 'Cilandak, Jakarta selatan',
    phone: '081281821',
    email: 'store@email.com',
    store_owner: 'owner1',
    store_building: 'gedung mangdu',
    store_category: 2
)

Absence.create!(
    absence_type: 1,
    user_id: 1,
    store_id: 1,
    latitude: 3.22,
    longitude: 3.154
)

Absence.create!(
    absence_type: 2,
    user_id: 2,
    store_id: 2,
    latitude: 3.22,
    longitude: 3.154
)

Sellin.create!(
    service_tag: "4TB8J52",
    quarter_year: 2015,
    quarter: 3,
    quarter_week: 10,
    item_type: 0,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Sellin.create!(
    service_tag: "HHH0L52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Sellin.create!(
    service_tag: "H8D9J52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Sellin.create!(
    service_tag: "DQB8J52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Sellin.create!(
    service_tag: "42QVK52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Sellin.create!(
    service_tag: "DFC9J52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Sellin.create!(
    service_tag: "4YPVK52",
    quarter_year: 2015,
    quarter: 4,
    quarter_week: 8,
    item_type: 1,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Sellin.create!(
    service_tag: "5YNVK52",
    quarter_year: 2015,
    quarter: 2,
    quarter_week: 3,
    item_type: 1,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Sellin.create!(
    service_tag: "7YNVK52",
    quarter_year: 2015,
    quarter: 2,
    quarter_week: 3,
    item_type: 1,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Sellin.create!(
    service_tag: "9YNVK53",
    quarter_year: 2015,
    quarter: 2,
    quarter_week: 3,
    item_type: 1,
    source_store: 1,
    product_type: "3437-i34010-4-500-UBT-D",
    target_store: 1
)

Posm.create!(
    name: "posm10",
    category: 1,
    quantity: 100
)

Posm.create!(
    name: "posm2",
    category: 2,
    quantity: 100
)

Posm.create!(
    name: "posm3",
    category: 3,
    quantity: 100
)

PosmStoreInventory.create!(
    posm_id: 1,
    store_id: 1,
    user_id: 1,
    quantity: 20,
    visibility: File.open(Rails.root + "public/uploads/kona.jpg")
)

PosmStoreInventory.create!(
    posm_id: 1,
    store_id: 2,
    user_id: 2,
    quantity: 20,
    visibility: File.open(Rails.root + "public/uploads/kona.jpg")

)

PosmStoreInventory.create!(
    posm_id: 2,
    store_id: 1,
    user_id: 1,
    quantity: 20,
    visibility: File.open(Rails.root + "public/uploads/kona.jpg")
)

PosmStoreInventory.create!(
    posm_id: 2,
    store_id: 2,
    user_id: 1,
    quantity: 20,
    visibility: File.open(Rails.root + "public/uploads/kona.jpg")
)

PosmStoreInventory.create!(
    posm_id: 2,
    store_id: 2,
    user_id: 2,
    quantity: 20,
    visibility: File.open(Rails.root + "public/uploads/kona.jpg")
)

PosmStoreInventory.create!(
    posm_id: 3,
    store_id: 1,
    user_id: 2,
    quantity: 20,
    visibility: File.open(Rails.root + "public/uploads/kona.jpg")
)

PosmStoreInventory.create!(
    posm_id: 3,
    store_id: 2,
    user_id: 1,
    quantity: 20,
    visibility: File.open(Rails.root + "public/uploads/kona.jpg")
)

Visibility.create!(
    store_id: 3,
    user_id: 2,
    remark: "v1",
    category: 0,
    visibility: File.open(Rails.root + "public/uploads/kona.jpg")
)

Visibility.create!(
    store_id: 3,
    user_id: 2,
    remark: "v2",
    category: 0,
    visibility: File.open(Rails.root + "public/uploads/kona.jpg")
)

SellKit.create!(
    name: "nyan1",
    description: "asdasd",
    file_name: File.open(Rails.root + "public/uploads/pdf.pdf"),
    category: 0,
    family: 0
)

SellKit.create!(
    name: "nyan2",
    description: "dsadsa",
    file_name: File.open(Rails.root + "public/uploads/pdf.pdf"),
    category: 1,
    family: 1
)

Post.create!(
    title: "test1",
    content: "testing pertama",
    user_id: 1,
    level: 0
)

Post.create!(
    title: "comment1",
    content: "testing pertama comment",
    user_id: 2,
    level: 1,
    parent_id: 1
)

# Inventory.create!(
#     service_tag: "4TB8J52",
#     status: 0,
#     sellin_id: 1,
#     store_id: 1,
#     user_id: 1,
#     added_by: User.find(1)
# )
#
# Inventory.create!(
#     service_tag: "HHH0L52",
#     status: 0,
#     sellin_id: 1,
#     store_id: 2,
#     user_id: 2,
#     added_by: User.find(1)
# )
#
# Inventory.create!(
#     service_tag: "H8D9J52",
#     status: 0,
#     sellin_id: 1,
#     store_id: 2,
#     user_id: 7,
#     added_by: User.find(1)
# )
#
# Inventory.create!(
#     service_tag: "DQB8J52",
#     status: 0,
#     sellin_id: 1,
#     store_id: 4,
#     user_id: 5,
#     added_by: User.find(1)
# )
#
# Inventory.create!(
#     service_tag: "42QVK52",
#     status: 0,
#     sellin_id: 1,
#     store_id: 4,
#     user_id: 1,
#     added_by: User.find(1)
# )
#
# Inventory.create!(
#     service_tag: "DFC9J52",
#     status: 0,
#     sellin_id: 1,
#     store_id: 2,
#     user_id: 6,
#     added_by: User.find(1)
# )
#
# Inventory.create!(
#     service_tag: "4YPVK52",
#     status: 0,
#     sellin_id: 1,
#     store_id: 1,
#     user_id: 6,
#     added_by: User.find(1)
# )
#
# Inventory.create!(
#     service_tag: "5YNVK52",
#     status: 0,
#     sellin_id: 1,
#     store_id: 2,
#     user_id: 6,
#     added_by: User.find(1)
# )

