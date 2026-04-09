rails new unit_converter_api --api
cd unit_converter_api
rails g controller conversions

files to copy paste:
conversion_controller.rb
routes.rb
and then create a file named units.json in config like here mannually adn copy  paste that code too

rails server
 (after rails server running paste tge below urls in chorme to see the json output)

 http://localhost:3000/convert?value=1000&type=m_to_km
 http://localhost:3000/convert?value=5000&type=g_to_kg

 (give values you want)

 (to run in terminal)
 curl "http://localhost:3000/convert?value=5000&type=g_to_kg"
