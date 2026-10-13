extends Node2D
var direction = 0
var chain_length = 0
var double_bond = 0
var hydroxyl_exists = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func mainchain():
	direction = randi_range(1,4)
	chain_length = randi_range(1,10)
	double_bond = randi_range(1,9)
	hydroxyl_exists = randi_range(1,5)
	if double_bond < chain_length:
		for i in range(chain_length-1):
			pass
