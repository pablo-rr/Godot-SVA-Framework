extends "res://scripts/singletons/Manager.gd"

const ALERT_BASIC : String = "res://addons/CoolButtonsLibrary/alerts/cbAlertBasic.tscn"
const ALERT_BASIC_INPUT : String = "res://addons/CoolButtonsLibrary/alerts/cbAlertBasicInput.tscn"
const ALERT_CHOICE : String = "res://addons/CoolButtonsLibrary/alerts/cbAlertChoice.tscn"
const ALERT_CHOICE_INPUT : String = "res://addons/CoolButtonsLibrary/alerts/cbAlertChoiceInput.tscn"

# Leave "new_view" as an empty string "" to stay in the same view
func instance_alert(alert_path : String, desc : String, icon_path : String, color : Color, new_view : String) -> TextureRect:
	var icon : Texture = load(icon_path)
	var alert : TextureRect = load(alert_path).instance()
	alert.set_description(desc)
	alert.set_icon(icon)
	alert.set_color(color)
	alert.set_new_view(new_view)
	get_parent().get_node("app").add_child(alert)
	alert.show()
	return alert

func instance_alert_basic(desc : String, icon_path : String, color : Color, new_view : String) -> TextureRect:
	return instance_alert(ALERT_BASIC, desc, icon_path, color, new_view)
	
func instance_alert_basic_input(desc : String, icon_path : String, color : Color, new_view : String) -> TextureRect:
	return instance_alert(ALERT_BASIC_INPUT, desc, icon_path, color, new_view)
	
func instance_alert_choice(desc : String, icon_path : String, color : Color, new_view : String) -> TextureRect:
	return instance_alert(ALERT_CHOICE, desc, icon_path, color, new_view)
	
func instance_alert_choice_input(desc : String, icon_path : String, color : Color, new_view : String) -> TextureRect:
	return instance_alert(ALERT_CHOICE_INPUT, desc, icon_path, color, new_view)
