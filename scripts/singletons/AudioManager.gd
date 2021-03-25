extends "res://scripts/singletons/Manager.gd"

var master_muted : bool = false
var sfx_muted : bool = false
var music_muted : bool = false
var mute_buttons : Array = []

func get_channel_mute(channel_name : String) -> bool:
	var channel : int = AudioServer.get_bus_index(channel_name)
	return AudioServer.is_bus_mute(channel)

func set_channel_mute(channel_name : String, muted : bool) -> void:
	var channel : int = AudioServer.get_bus_index(channel_name)
	AudioServer.set_bus_mute(channel, muted)
	if(channel_name == "Master"):
		master_muted = muted
	elif(channel_name == "Sfx"):
		sfx_muted = muted
	elif(channel_name == "music"):
		music_muted = muted
		
func set_channel_db(channel_name : String, db : int) -> void:
	var channel : int = AudioServer.get_bus_index(channel_name)
	AudioServer.set_bus_volume_db(channel, db)
	
func add_mute_button(new_mute : TextureButton) -> void:
	mute_buttons.append(new_mute)
	
func set_mute_buttons(muted : bool) -> void:
	for i in mute_buttons.size():
		mute_buttons[i].set_mute(get_channel_mute("Master"))
	
