extends Area2D

export (Texture) var back_texture setget back_texture_set, back_texture_get
export (Texture) var front_texture setget front_texture_set, front_texture_get
export (String) var  card_name

export (NodePath) var listener
onready var game = get_node(listener)

onready var parent = get_parent()

const back = preload("res://images/cardback.png")
const front = preload("res://images/cardfront.png")
var flipped = false


func _ready():
	update_glyph()

func back_texture_set(new_value):
	back_texture = new_value
	update_glyph()
	
func back_texture_get():
	return back_texture

func front_texture_set(new_value):
	front_texture = new_value
	update_glyph()
	
func front_texture_get():
	return front_texture

func _input_event(viewport, event, shape_idx):
	if game.allows_picking() == false: return
	
	if not flipped:
		if event is InputEventMouseButton \
		and event.button_index == BUTTON_LEFT \
		and event.is_pressed():
			self.on_click()

func on_click():
	game .onpick (self)

func flip():
	if flipped:
		flipped = false
		update_glyph()
	else:
		flipped = true
		update_glyph()

func update_glyph():
	if flipped and front_texture != null:
		$Glyph.texture = front_texture
		resize()
	elif back_texture != null:
		$Glyph.texture = back_texture
		resize()
	
func resize():
	var want = Vector2(100, 100)
	var have = $Glyph.texture.get_size()
	var scaling = want / have
	$Glyph.scale = scaling