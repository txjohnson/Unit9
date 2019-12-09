extends Node2D


const card = preload("res://objects/Card.tscn")
const back = preload("res://images/wakfu logo2.png")

const num_cards = 24

const cards = [
	preload("res://images/ale.png"),
	preload("res://images/bird.png"),
	preload("res://images/candycat.png"),
	preload("res://images/chest.png"),
	preload("res://images/coconut.png"),
	preload("res://images/coin.png"),
	preload("res://images/conch.png"),
	preload("res://images/flag.png"),
	preload("res://images/flower.png"),
	preload("res://images/gecko.png"),
	preload("res://images/gift.png"),
	preload("res://images/key.png"),
	preload("res://images/knife.png"),
	preload("res://images/lollipop.png"),
	preload("res://images/octopus.png"),
	preload("res://images/pearl.png"),
	preload("res://images/scallop.png"),
	preload("res://images/seahorse.png"),
	preload("res://images/seaurchin.png"),
	preload("res://images/skull.png"),
	preload("res://images/spider.png"),
	preload("res://images/spire.png"),
	preload("res://images/vase.png"),
	preload("res://images/wine.png") ]

const cardnames = [
	"Ale", "Bird", "Candy Cat", "Chest",
	"Coconut", "Coin", "Conch", "Flag", 
	"Flower", "Gecko", "Gift", "Key", 
	"Knife", "Lollipop", "Octopus", "Pearl",
	"Scallop", "Sea Horse", "Sea Urchin", "Skull",
	"Spider", "Spire", "Vase", "Wine" ]

var card_sequence = []

var rnd = RandomNumberGenerator.new()

var first_pick = null
var second_pick = null
var num_matches = 0
	
func _ready():
	create_cards ()


func clear_picks ():
	first_pick = null
	second_pick = null


func reset_picks ():
	if first_pick != null:
		first_pick .flip()
		
	if second_pick != null:
		second_pick .flip()

	clear_picks()


func allows_picking ():
	return first_pick == null or second_pick == null


func onpick (who):
	print ("Owner received click from ", who.card_name)

	if first_pick == null:
		$Card1Name .text = who.card_name
		first_pick = who
		who .flip()
	
	elif second_pick == null:
		$Card2Name .text = who.card_name
		second_pick = who
		who .flip()	
		check_for_match()	


func check_for_match():
	if first_pick.card_name == second_pick.card_name:
		$CardCompare.text = "="
		num_matches += 1
		$Matches.text = "Number of matches: " + str(num_matches)
		clear_picks()
	else:
		$CardCompare.text = "<>"
		$Wait.start()
		yield($Wait, "timeout")
		var waiting_timer = Timer.new()
		$CardCompare.text = "??"
		reset_picks()


func shuffle ():
	randomize()
	
	var all = []
	for i in range (0, num_cards): all .append (i)
	all.shuffle()
	
	card_sequence.clear ()
	
	for i in range (0, 12):
		card_sequence.append (all[i])
		card_sequence.append (all[i])
	
	card_sequence.shuffle()	


func create_cards():
	var origin = Vector2 (480, 128)
	var selected = 0

	shuffle()

	for j in range (0, 4):
		for i in range (0, 6):
			var c = card.instance()
			c.back_texture = back
			c.front_texture = cards [card_sequence [selected]]
			c.card_name = cardnames [card_sequence [selected]]
			c.position = origin + Vector2 (i * 200, j * 160);
			c.listener = self.get_path()
			$Cards.add_child (c)
			selected += 1


func _on_Button_button_down():
	get_tree().reload_current_scene()
