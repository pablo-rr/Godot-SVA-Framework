extends Node2D

# Parameter 'new_view' is a Node2D (the view) and not its name in a String
signal view_changed(new_view)
# Parameter 'new_view' is a Node2D (the view) and not its name in a String
signal view_added(new_view)

# All views MUST be stored in the Node2D 'app'
# Views stored in the Node2D 'app' are automatically added to this Dictionary
# Useful when iterating actions to be made in all views
# Don't remove the 'main' view, modify it instead
onready var views : Dictionary = {}
onready var latest_view : Node = null

# Parameter 'new_view' : String is the name of the view (in the Node2D 'app'
# Tween the old view out of borders and put new view in
# Will call the method unsetup() in the old view, and setup() in the new view
# Be sure to implement these methods in all your views if you don't use the view_template.tscn
func change_view(new_view : String) -> void:
	var view_node : Node = get_view(new_view)
	var unsetup_view : Node
	if(latest_view != view_node):
		for view in views:
			views[view].visible = false
		unsetup_view = latest_view
		latest_view.visible = true	
		view_node.setup()
		view_node.visible = true
		var tween : Tween = Tween.new()
		var tween_instance = add_child(tween)
		tween.interpolate_property(latest_view, "position", latest_view.position, Vector2(720, 0), 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween.start()
		tween.interpolate_property(view_node, "position", Vector2(-720, 0), Vector2(0, 0), 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween.start()
		latest_view = view_node
		yield(get_tree().create_timer(1), "timeout")
#		Calling 'unsetup' in 'pause' view would make it unload. We don't want that
		if(latest_view.name != "pause"):
			unsetup_view.unsetup()
		emit_signal("view_changed", view_node)
		tween.queue_free()

# Return the view (given by name) stored in Node2D 'app'
func get_view(view_name : String) -> Node:
	var view : Node = get_parent().get_node(str("app/", view_name))
	return view
	
# Used in all 'ready()' methods used in the views
func add_view(new_view : Node) -> void:
	emit_signal("view_added", new_view)
	views[new_view.name] = new_view
	
func set_latest_view(new_view : Node) -> void:
	latest_view = new_view
	
func get_latest_view() -> Node:
	return latest_view
