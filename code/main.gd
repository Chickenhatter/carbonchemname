extends Node2D
var direction = 0
var chain_length = 0
var double_bond = 0
var hydroxyl_exists = 0
var place = 0
var plyce = 0

const carbon = preload('res://summons/carbon.tscn')
const alkene = preload('res://summons/carbon3.tscn')
const hydroxl = preload('res://summons/hydroxyl.tscn')
@onready var placechild = $whereplace

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mainchain()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func mainchain():
	direction = randi_range(1,4)
	chain_length = randi_range(1,10)
	double_bond = randi_range(1,9)
	hydroxyl_exists = randi_range(1,1)
	chain_length = 9
	double_bond = 2
	print('chain_length:',chain_length)
	print('double_bond:',double_bond)
	print('hydroxl:',hydroxyl_exists)
	if double_bond < chain_length:
		for i in range(chain_length-1):
			if i == (double_bond-1):
				var thing = alkene.instantiate()
				place = i*86
				thing.global_position = Vector2(place,0)
				placechild.add_child(thing)
			elif i > (double_bond-1):
				var thing = carbon.instantiate()
				place = (double_bond-1)*86 + 2 * 61
				plyce = (i-double_bond)*86+2*61
				thing.global_position = Vector2(place,-plyce)
				placechild.add_child(thing)
			else:
				var thing = carbon.instantiate()
				place = i*86
				thing.global_position = Vector2(place,0)
				placechild.add_child(thing)
	else:
		for i in range(chain_length):
			var thing = carbon.instantiate()
			place = i*86
			thing.global_position = Vector2(place,0)
			placechild.add_child(thing)
	if hydroxyl_exists == 1:
		var thing = hydroxl.instantiate()
		thing.global_position = Vector2(-62,0)
		placechild.add_child(thing)
