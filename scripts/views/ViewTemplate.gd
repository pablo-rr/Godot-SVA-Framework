# Add behaviour to your views extending this script in them
# Example: dynamically adding elements to the view reading from a JSON
extends Node2D

signal view_setted
signal view_unsetted
 
func _ready() -> void:
	ViewManager.add_view(self)
	self.visible = false
	self.position = Vector2(720, 0)

# Will act as _ready() and be called when the view is used by ViewManager.change_scene("scene")
# Add behaviour by calling '.setup()' in the extended script
func setup() -> void:
	emit_signal("view_setted")
	
# Will be called when the view is hid by ViewManager.change_scene("scene")
# Use this to clear the view when it is not in use, it will make better use of the resources of the phone
# Add behaviour by calling '.unsetup()' in the extended script
func unsetup() -> void:
	emit_signal("view_unsetted")
