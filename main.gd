extends Node3D

func _ready() -> void:
	restart()

func restart():
	%JournalEntries.visible = false
	%MainUI.visible = false
	%Settings.visible = false
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
	
	GlobalValues.connect("day_changed", new_day)
	new_day(1)

func new_day(_day : int):
	GlobalValues.chosen_item = ""
	%Map.glow_journal()
