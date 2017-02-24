class ReportBuilder < Julia::Builder
  column 'Transaction Date', :transaction_date
  column 'Store ID', :store_uid
  column 'Store name', :store_name
  column 'Store category', :store_category
  column 'Store building', :building_name
  column 'Store address', :store_address
  column 'Store phone', :store_phone
  column 'Store email', :store_email
  column 'Store owner', :store_owner
  column 'CAM name', :cam_name
  column 'PIC name', :pic_name
  column 'PIC level', :user_level
  column 'Region name', :region_name
  column 'Region', :region
  column 'City name', :city_name
  column 'Service Tag', :service_tag
  column 'Part Number', :part_number
  column 'Product type', :product_type
  column 'Product name', :product_name
  column 'Distributor', -> { "#{Store.find(distributor).select('stores.name')}" }
  column 'Master dealer', -> { "#{Store.find(master_dealer).select('stores.name')}" }
  column 'Quarter year', :quarter_year
  column 'Quarter', :quarter
  column 'Quarter week', :quarter_week


end