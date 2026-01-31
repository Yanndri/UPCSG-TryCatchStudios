class_name Durability

static var medkit := 100
static var durability := {
	"Medkit" : 100,
	"Shotgun" : 100,
	"Toolbox" : 100,
	"Bag" : 100,
	"Flashlight" : 100
}

static func sanity_punish(note : String) -> String:
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		var random_num := randi_range(10, 30)
		character["sanity"] -= random_num
		note += "\n\n" + character["name"] + " feels a bit more scared "
	return note

static func change_durability_random_item(amount : int) -> String:
	var keys = durability.keys()
	var item = keys[randi() % keys.size()]
	
	# Subtract 9 from that key
	durability[item] += amount
	
	print("item: ", item, " durability: ", durability[item])
	return item

static func change_durability_item(item : String, amount : int) -> String:
	#var keys = durability.keys()
	#var item = keys[randi() % keys.size()]
	
	# Subtract 9 from that key
	durability[item] += amount
	
	print("item: ", item, " durability: ", durability[item])
	return item

static func get_durability(item : String) -> int:
	return durability.get(item, 0)
