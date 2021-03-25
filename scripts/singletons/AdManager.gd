extends "res://scripts/singletons/Manager.gd"

onready var actions_before_ad : int = 4
onready var actions_before_ad_reset = actions_before_ad

# Use when you want an ad to show after a number of actions
# Example: show an ad after finnishing a number of levels (the checkpoint calls 'remove_action()')
func remove_action() -> void:
	actions_before_ad -= 1
	if(actions_before_ad <= 0):
		actions_before_ad = 0
		get_parent().get_node("/root/app/AdMob").show_interstitial()
		
func get_admob() -> Node:
	return get_parent().get_node("/root/app/AdMob")
