extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_hydrogen_1_area_entered(area: Area2D) -> void:
	if area.name == "carbon":
		$hydrogen1/hydrogensprite.play('none')


func _on_hydrogen_2_area_entered(area: Area2D) -> void:
	if area.name == "carbon":
		$hydrogen2/hydrogensprite.play('none')


func _on_hydrogen_3_area_entered(area: Area2D) -> void:
	if area.name == "carbon":
		$hydrogen3/hydrogensprite.play('none')



func _on_hydrogen_4_area_entered(area: Area2D) -> void:
	if area.name == "carbon":
		$hydrogen4/hydrogensprite.play('none')
