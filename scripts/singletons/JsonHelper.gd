extends "res://scripts/singletons/Manager.gd"

# If the file doesn't exist, a new one is created in the location, with the given Dictionary in 'filler'
func get_as_dictionary(json_path : String, filler : Dictionary) -> Dictionary:
	check_file_existance(json_path, filler)	
	var file : File = File.new()
	file.open(json_path, File.READ)
	var file_string : String = file.get_as_text()
	var file_data : Dictionary = JSON.parse(file_string).result
	file.close()
	return file_data

# If the file doesn't exist, a new one is created in the location, with the given Arratin 'filler'
func get_as_array(json_path : String, filler : Array) -> Array:
	check_file_existance(json_path, filler)
	var file : File = File.new()
	file.open(json_path, File.READ)
	var file_string : String = file.get_as_text()
	var file_data : Array = JSON.parse(file_string).result
	file.close()
	return file_data
	
# Will create a file in the path given if it doesn't exist, filling it's content with the 'filler' param
func check_file_existance(json_path : String, filler):
	var file : File = File.new()
	if(!file.file_exists(json_path)):
		file.open(json_path, File.WRITE)
		var json_filler = JSON.print(filler, "\t")
		file.store_string(json_filler)
		file.close()
		
# Useful when inserting new data from other dictionary
# Try not to use Integers as keys
func merge_dictionaries(target : Dictionary, merged : Dictionary) -> Dictionary:
	for key in merged:
		target[(key)] = merged[(key)]
	return target
		
# This function will erase all previous data and save only the 'new_data' parameter
# BE CAREFUL WHEN USING THIS FUNCTION IF YOU DON'T WANT TO LOSE DATA
func save_dictionary(json_path : String, new_data : Dictionary):
	var file : File = File.new()
	var data_string : String = JSON.print(new_data, "\t")
	file.open(json_path, File.WRITE)
	file.store_string(data_string)
	file.close()
	
# This function will erase all previous data and save only the 'new_data' parameter
# BE CAREFUL WHEN USING THIS FUNCTION IF YOU DON'T WANT TO LOSE DATA
func save_array(json_path : String, new_data : Array):
	var file : File = File.new()
	var data_string : String = JSON.print(new_data)
	file.open(json_path, File.WRITE)
	file.store_string(data_string)
	file.close()
