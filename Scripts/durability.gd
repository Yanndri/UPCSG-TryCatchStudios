class_name Durability

static var medkit := 100
static var durability := {
	"Medkit" : 100,
	"Shotgun" : 100
}

static func break_random_item(damage : int) -> String:
	var keys = durability.keys()
	var break_item = keys[randi() % keys.size()]

	# Subtract 9 from that key
	durability[break_item] -= damage
	
	print("break_item: ", break_item)
	return break_item
	
