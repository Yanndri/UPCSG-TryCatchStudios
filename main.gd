extends Node3D

@export var intro_scene : PackedScene = preload("res://intro.tscn")

func _ready() -> void:
	restart()

func restart():
	%JournalEntries.visible = false
	%MainUI.visible = false
	%Settings.visible = false
	%GameOver.visible = false
	GlobalValues.characters = { "Character1" : {
		"name": "Wilson",
		"pronouns" : "He",
		"sanity" : 69,
		"hunger" : 120,
		"thirst" : 90
	},
	"Character2" : {
		"name": "Wendy",
		"pronouns" : "She",
		"sanity" : 100,
		"hunger" : 90,
		"thirst" : 120
	},}
	
	main_menu()

func main_menu():
	%CameraManager.switch_camera(2)

func play_game(): #Pressed by Main Menu on play
	%CameraManager.switch_camera(0) #Switch to main camera
	start_game()
	%MainUI.visible = true
	%Settings.visible = true

func start_game():
	GlobalValues.click_event_type = GlobalValues.click_events.NA
	GlobalValues.Day = 1
	GlobalValues.food_amount = 6
	GlobalValues.water_amount = 6
	
	GlobalValues.connect("day_changed", new_day)
	new_day(1)

func new_day(_day : int):
	GlobalValues.chosen_item = ""
	%Map.glow_journal()

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_packed(intro_scene)
