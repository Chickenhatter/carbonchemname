extends Node2D
var direction = 0
var chain_length = 0
var double_bond = 0
var hydroxyl_exists = 0
var place = 0
var plyce = 0
var listplace = []
var random_place = 0
var chainoff_length = 0
var offshoots = []
var offpos = []
var nome = ""

var hydroxyl_is_here = false
var ene_is_here = false
var offshoot_is_here = false

var ethyl = []
var methyl = []
var butyl = []
var propyl = []
var pentyl = []

var offshootings = true
var hydroxyl = true

const carbon = preload('res://summons/carbon.tscn')
const alkene = preload('res://summons/carbon3.tscn')
const hydroxl = preload('res://summons/hydroxyl.tscn')
@onready var placechild = $whereplace

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	newmolecule()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func mainchain():
	chain_length = randi_range(1,10)
	double_bond = randi_range(1,9)
	print('chain_length:',chain_length)
	print('double_bond:',double_bond)
	if double_bond < chain_length:
		for i in range(chain_length-1):
			if i == (double_bond-1):
				var thing = alkene.instantiate()
				place = i*86
				listplace += [[place,0]]
				listplace += [[place+61,-61]]
				thing.global_position = Vector2(place,0)
				placechild.add_child(thing)
				ene_is_here = true
			elif i > (double_bond-1):
				var thing = carbon.instantiate()
				place = (double_bond-1)*86 + 61
				plyce = -((i-double_bond+1)*86+61)
				listplace += [[place,plyce]]
				thing.global_position = Vector2(place,plyce)
				placechild.add_child(thing)
			else:
				var thing = carbon.instantiate()
				place = i*86
				listplace += [[place,0]]
				thing.global_position = Vector2(place,0)
				placechild.add_child(thing)
	else:
		for i in range(chain_length):
			var thing = carbon.instantiate()
			place = i*86
			listplace += [[place,0]]
			thing.global_position = Vector2(place,0)
			placechild.add_child(thing)

func smallerchains():
	if chain_length > 2:
		offshoot_is_here = true
		random_place = randi_range(1,chain_length-2)
		chainoff_length = randi_range(1,(((chain_length-1)/(2))))
		offshoots += [[random_place,chainoff_length]]
		place = listplace[random_place][0]
		plyce = listplace[random_place][1]
		offpos += [random_place]
		if (double_bond-1) > random_place:
			if offpos.count(random_place) == 0:
				for i in range(1,chainoff_length+1):
					var thing = carbon.instantiate()
					plyce = -(i*86)
					print(Vector2(place,plyce))
					thing.global_position = Vector2(place,plyce)
					placechild.add_child(thing)
					offshoots +=  [[random_place+1,chainoff_length]]
			elif offpos.count(random_place) == 1:
				for i in range(1,chainoff_length+1):
					var thing = carbon.instantiate()
					plyce = (i*86)
					thing.global_position = Vector2(place,plyce)
					placechild.add_child(thing)
					offshoots +=  [[random_place+1,chainoff_length]]
		
		elif (double_bond-1) == random_place:
			for i in range(1,chainoff_length+1):
					var thing = carbon.instantiate()
					plyce = (i*86)
					thing.global_position = Vector2(place,plyce)
					placechild.add_child(thing)
					offshoots +=  [[random_place+1,chainoff_length]]
		elif (double_bond) == random_place:
			for i in range(1,chainoff_length+1):
					var thing = carbon.instantiate()
					place += 86
					thing.global_position = Vector2(place,plyce)
					placechild.add_child(thing)
					offshoots +=  [[random_place+1,chainoff_length]]
			
		else:
			if offpos.count(random_place) == 0:
				for i in range(1,chainoff_length+1):
					var thing = carbon.instantiate()
					place += 86
					thing.global_position = Vector2(place,plyce)
					placechild.add_child(thing)
					offshoots +=  [[random_place+1,chainoff_length]]
			elif offpos.count(random_place) == 1:
				for i in range(1,chainoff_length+1):
					var thing = carbon.instantiate()
					place -= 86
					thing.global_position = Vector2(place,plyce)
					placechild.add_child(thing)
					offshoots +=  [[random_place+1,chainoff_length]]


func newmolecule():
	for child in placechild.get_children():
		child.queue_free()
	mainchain()
	if hydroxyl == true:
		hydroxsummon()
	if offshootings == true:
		for i in range(1,3):
			smallerchains()
	decypher()

func hydroxsummon():
	hydroxyl_exists = randi_range(1,1)
	if hydroxyl_exists == 1:
			var thing = hydroxl.instantiate()
			thing.global_position = Vector2(-62,0)
			placechild.add_child(thing)
			hydroxyl_is_here = true

func decypher():
	if offshoot_is_here == true:
		for i in range(0,len(offshoots)): #adds the names to number groups
			if offshoots[i][1] == 1:
				methyl += [random_place]
			if offshoots[i][1] == 2:
				ethyl += [random_place]
			if offshoots[i][1] == 3:
				propyl += [random_place]
			if offshoots[i][1] == 4:
				butyl += [random_place]
			if offshoots[i][1] == 5:
				pentyl += [random_place]
		if butyl.size() > 0:
			for i in range(0,len(butyl)):
				nome += str(butyl[i]) + ','
			nome = nome.left(-1)
			
	
	nome += number_prefix(chain_length)
	if hydroxyl_is_here != false:
		if ene_is_here != false:
			nome += '-'
			nome += str(double_bond)
			nome += '-en-1-ol'
		else:
			nome += 'anol'
	elif ene_is_here != false:
		nome += 'ene'
	else:
		nome += 'ane'
	print(nome)

func number_prefix(a):
	if a == 1:
		return "meth"
	elif a == 2:
		return "eth"
	elif a == 3:
		return "prop"
	elif a == 4:
		return "but"
	elif a == 5:
		return "pent"
	elif a == 6:
		return "hex"
	elif a == 7:
		return "hept"
	elif a == 8:
		return "oct"
	elif a == 9:
		return "non"
	elif a == 10:
		return "dec"
