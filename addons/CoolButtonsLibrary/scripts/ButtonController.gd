tool
extends TextureButton

signal button_released
signal button_pressed

export var button_icon : Texture = null setget set_button_icon
export var button_description : String = "desc" setget set_button_description
export(String, "Self modulation", "Generic", "Success", "Error", "Warn", "White", "Lavender", "Pink", "Purple", "Orange") var button_color : String = "Generic" setget set_button_color

onready var press_offset : int = rect_size.y/20

func _ready() -> void:
	setup_color()
	connect("button_down", self, "press_action")
	connect("button_up", self, "release_action")

func setup_color() -> void:
	var new_color : Color
	if(button_color == "Generic"):
		new_color = PremadeColors.COLOR_GENERIC
	elif(button_color == "Success"):
		new_color = PremadeColors.COLOR_SUCCESS
	elif(button_color == "Error"):
		new_color = PremadeColors.COLOR_ERROR
	elif(button_color == "Warn"):
		new_color = PremadeColors.COLOR_WARN
	elif(button_color == "Lavender"):
		new_color = PremadeColors.COLOR_LAVENDER
	elif(button_color == "Pink"):
		new_color = PremadeColors.COLOR_PINK
	elif(button_color == "Purple"):
		new_color = PremadeColors.COLOR_PURPLE
	elif(button_color == "White"):
		new_color = PremadeColors.COLOR_WHITE
	elif(button_color == "Orange"):
		new_color = PremadeColors.COLOR_ORANGE
	
	if(button_color != "Self modulation"):
		self_modulate = Color8(new_color.r, new_color.g, new_color.b)
	
func play_sfx() -> void:
	randomize()
	$pressSfx.pitch_scale = rand_range(0.9, 1.1)
	$pressSfx.play()

func press_action() -> void:
	emit_signal("button_pressed")
	$content.rect_position.y += press_offset
	play_sfx()
	
func release_action() -> void:
	emit_signal("button_released")
	$content.rect_position.y -= press_offset
		
func set_button_icon(icon : Texture) -> void:
	if(Engine.editor_hint):
		button_icon = icon
		$content/icon.texture = icon
	
func set_button_description(desc : String) -> void:
	if(get_node_or_null("content/buttonDesc") != null and Engine.editor_hint):
		button_description = desc
		$content/buttonDesc.text = desc
		
func set_button_color(color : String) -> void:
	if(Engine.editor_hint):
		button_color = color
		setup_color()
