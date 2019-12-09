extends Area2D

export (Texture) var texture setget texture_set, texture_get

func _ready():
	$Sprite.texture = texture


func texture_set(new_value):
	print("Setting texture.")
	texture = new_value
	$Sprite.texture = new_value
	
func texture_get():
	return $Sprite.texture
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	owner.get_node("Background").texture = texture

