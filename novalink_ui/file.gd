extends Node

signal setup

var config_dir = OS.get_system_dir(0)+"/../.ushos"
var acc_config_path = config_dir+"/acc.json"
var apps_config_path = config_dir+"/apps.json"

var username: String
var mainuser: bool
var apps: Dictionary
var debug = OS.is_debug_build()

func _ready():
	var dir = DirAccess.open(OS.get_system_dir(0)+"/..")
	if not dir.dir_exists(config_dir):
		DirAccess.make_dir_absolute(config_dir)
	
	if !FileAccess.file_exists(acc_config_path) or !FileAccess.file_exists(apps_config_path):
		emit_signal("setup")
	else:
		load_config_files()


func load_config_files():
	if FileAccess.file_exists(acc_config_path):
		var acc_file = FileAccess.open(acc_config_path, FileAccess.READ).get_as_text()
		var json = JSON.new()
		var acc_result = json.parse(acc_file)
		
		if acc_result.ok:
			var acc_dict = acc_result.result
			username = acc_dict["username"]
			name = acc_dict["name"]
			mainuser = acc_dict["mainuser"]
		else:
			print("Error parsing acc.json:", acc_result.error)
	
	if FileAccess.file_exists(apps_config_path):
		var apps_file = FileAccess.open(apps_config_path, FileAccess.READ).get_as_text()
		var json = JSON.new()
		var apps_result = json.parse(apps_file)
		
		if apps_result.ok:
			apps = apps_result.result
		else:
			print("Error parsing apps.json:", apps_result.error)


func save_config_files():
	var acc_dict = {
		"username": username,
		"mainuser": mainuser
	}
	
	var acc_data = JSON.stringify(acc_dict)
	var apps_data = JSON.stringify(apps)
	
	if FileAccess.file_exists(acc_config_path):
		var acc_file = FileAccess.open(acc_config_path, FileAccess.WRITE)
		acc_file.store_string(acc_data)
		acc_file.close()
	else:
		print("Error saving acc.json")
	
	if FileAccess.file_exists(apps_config_path):
		var apps_file = FileAccess.open(apps_config_path, FileAccess.WRITE)
		apps_file.store_string(apps_data)
		apps_file.close()
	else:
		print("Error saving apps.json")


func set_account_info(_username, _name, _mainuser):
	username = _username
	mainuser = _mainuser
	save_config_files()


func set_apps(_apps):
	apps = _apps
	save_config_files()
