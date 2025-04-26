extends Node3D

@onready var die = $Die

@onready var label = $CanvasLayer/Label

@export var char_stats: CharacterStats

var dice_rolling = true

func _rolling():
	dice_rolling = false
	die._roll()


func _on_die_roll_finished(value):
	label.text = str(value)
	Events.mana = value
	
	await get_tree().create_timer(1).timeout
	label.text = ''
	dice_rolling = true
	
