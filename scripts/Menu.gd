extends Node2D

var gamescene = preload("res://scenes/Game.tscn")
var game

func _ready():
	game = gamescene.instance()
	
	



func _on_StartButton_pressed():
	$UI.visible = false
	add_child (game)



func _on_QuitButton_pressed():
	get_tree().quit()
