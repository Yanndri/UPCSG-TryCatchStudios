class_name CharacterStats

static func get_feeling_comments(sanity : int) -> String:
	var sanity_note : String
	if sanity < 20:
		sanity_note = " is really struggling right now, "
	elif sanity < 40:
		sanity_note = " is pushing through the day"
	elif sanity < 60:
		sanity_note = " is feeling okay, managing to stay balanced "
	elif sanity < 80:
		sanity_note = " is doing well, and keeping a steady rhythm "
	elif sanity < 100:
		sanity_note = " is feeling great, and full of positivity "

	return sanity_note

static func get_hunger_comments(hunger : int) -> String:
	var hunger_note : String
	if hunger < 20:
		hunger_note = " completely starving "
	elif hunger < 40:
		hunger_note = " hungry "
	elif hunger < 60:
		hunger_note = " starting to feel hungry "
	elif hunger < 80:
		hunger_note = " well fed "
	elif hunger < 100:
		hunger_note = " full from food "

	return hunger_note

static func get_thirst_comments(thirst : int) -> String:
	var thirst_note : String
	if thirst < 20:
		thirst_note = " and is desperately parched "
	elif thirst < 40:
		thirst_note = " and is thirsty "
	elif thirst < 60:
		thirst_note = " and is beginning to feel the dryness "
	elif thirst < 80:
		thirst_note = " and is slightly satiated "
	elif thirst < 100:
		thirst_note = " and is well hydrated "

	return thirst_note
