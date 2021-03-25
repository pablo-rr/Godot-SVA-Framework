extends TextureRect

signal alert_shown
signal alert_hid

var description : String = "desc"
# How to use input_text:
# Imagine that you want to add a player to the 'highscore'
# The easiest way would be using the cbAlertBasicInput, using the 'input' node as the field to save the name
# To access the text in 'input', you have to:
# 	1.- Assign a variable to the alert instance (var alert = AlertManager.instance_alert_basic_input(parameters))
#		** Have into account that cbAlerts inherit from TextureRect when using static typing ** 
#	2.- Connect the 'alert_hid' signal to the scene in use
#	3.- Set the alert itself as a binding (this will make the alert the parameter of the function that you connect)
#	4.- Access the alert's input by calling 'alert.get_input_text()' inside the function you connected to the signal
var input_text : String = ""

func _ready() -> void:
	show()
	
func set_description(desc : String) -> void:
	if(get_node_or_null("content/alertDesc") != null):
		$content/alertDesc.text = desc
		
func set_color(color : Color) -> void:
	self_modulate = Color8(color.r, color.g, color.b)
	
func set_icon(icon : Texture):
	if(get_node_or_null("content/icon") != null):
		$content/icon.texture = icon
	
func set_new_view(view : String) -> void:
	$cbOk.new_view = view

func show() -> void:
	emit_signal("alert_shown")
	var tween : Tween = Tween.new()
	var tween_instance = add_child(tween)
	tween.interpolate_property(self, "rect_position", Vector2(0, -1280), Vector2(0, 255), 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	yield(get_tree().create_timer(1.0), "timeout")
	tween.queue_free()
	
func hide() -> void:
	if(get_node_or_null("content/input") != null):
		input_text = $content/input.text
	emit_signal("alert_hid")
	var tween : Tween = Tween.new()
	var tween_instance = add_child(tween)
	tween.interpolate_property(self, "rect_position", Vector2(0, 255), Vector2(0, 2560), 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	yield(get_tree().create_timer(1.0), "timeout")	
	tween.queue_free()
	self.queue_free()
	
func get_input_text() -> String:
	return input_text

