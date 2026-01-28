extends Node3D

var took_food : bool
var took_water : bool

func _ready() -> void:
	GlobalValues.connect("item_changed", decide_ration)
	GlobalValues.connect("click_event_type_changed", ration_time)
	%food_eaten.visible = false
	%bottle_eaten.visible = false

func ration_time(click_event : int):
	if click_event ==  GlobalValues.click_events.rations:
		%food_eaten.visible = false
		%bottle_eaten.visible = false
		took_food = false
		took_water = false

func decide_ration(item : String):
	if GlobalValues.click_event_type ==  GlobalValues.click_events.NA: #Meaning no calculations at this click event
		return
	match item:
		"Food": 
			if not took_food:
				took_food = true
				reduce_food()
				%food_eaten.visible = true #the food that was took is now on the table
		"Removed Food": 
			if took_food:
				took_food = false
				increase_food()
				%food_eaten.visible = false #the food that was took is now on the table
		"Water": 
			if not took_water:
				took_water = true
				reduce_water()
				%bottle_eaten.visible = true #the bottle that was took is now on the table
		"Removed Water":
			if took_water:
				took_water = false
				increase_water()
				%bottle_eaten.visible = false #the bottle that was took is now on the table
	#count_available_food()

func reduce_food(): #Take food
	#print("reduce_food")
	for child in %Food.get_children():
		if child is MeshInstance3D:
			if child.visible:
				child.visible = false
				break

func increase_food(): #increase food
	#print("increase_food")
	for child in %Food.get_children():
		if child is MeshInstance3D:
			if not child.visible:
				child.visible = true
				break

func reduce_water():
	#print("reduce_water")
	for child in %Water.get_children():
		if child is MeshInstance3D:
			if child.visible:
				child.visible = false
				break

func increase_water():
	#print("increase_water")
	for child in %Water.get_children():
		if child is MeshInstance3D:
			if not child.visible:
				child.visible = true
				break

#func count_available_food():
	#var food_count : int = 0
	#for child in %Water.get_children():
		#if child is MeshInstance3D:
			#if child.visible:
				#food_count += 1
	#print("food_count: ", food_count)
