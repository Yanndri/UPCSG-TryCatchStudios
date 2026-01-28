extends Control

@export var starting_journal : JournalEntry
@export var journal_entries : Array[JournalEntry]

var current_journal_entry : JournalEntry

var journal_entries_audit : Array[JournalEntry] #All journal entries used are stored here
var notes_audit : PackedStringArray #All notes used are stored here

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.connect("item_changed", item_chosen) ##This only works for pick_item event
	GlobalValues.connect("day_changed", func(day): %Day.text = "[b]Day " + str(day))
	
	get_journals()

func get_journals():
	if starting_journal != null:
		current_journal_entry = starting_journal
		starting_journal = null
		start_journal(current_journal_entry)
		return
	
	GlobalValues.Day += 1
	
	var get_random_index := randi_range(0, journal_entries.size() - 1)
	current_journal_entry = journal_entries.pop_at(get_random_index)
	
	start_journal(current_journal_entry)

func start_journal(journal_entry : JournalEntry): #Start of every Journal Entry meaning page 1
	#current_journal_entry = find_journal_entry(journal_title)#Get the journal entry
	write_journal(journal_entry, 1)

#Writes the notes from the entry, can toggle between next and back page by changing flip amount either 1 or -1
func write_journal(journal_entry : JournalEntry, flip_amount : int): 
	var note : String = journal_entry.flip_journal(flip_amount) #Get the note from the next page of the journal
	
	%JournalAnimations.play("flip") #Animation only, the animation also changes transparency of text label
	toggle_disable_all_buttons(true) #disable buttons while the animation is ongoing
	await get_tree().create_timer(0.5).timeout #for animation
	toggle_disable_all_buttons(false) #enable all buttons since the animation is finished
	
	%Body.text = note #set the note as the text body
	toggle_visibility(journal_entry) #toggle the buttons in the notes visibility based on the journal_entry

func toggle_disable_all_buttons(is_working : bool): #So while the journal is animating, you can't multi click
	%NextPage.disabled = is_working
	%BackPage.disabled = is_working
	%PickRations.disabled = is_working
	%PickItem.disabled = is_working
	%Skip.disabled = is_working

#Enter a Journal title and this will find the JournalEntry from the array in journal_entries
func find_journal_entry(title : String) -> JournalEntry:
	for journal_entry in journal_entries:
		if journal_entry.Title == title:
			return journal_entry
	return null

#go to next page of the journal entry
func _on_next_page_pressed() -> void: write_journal(current_journal_entry, 1)

#Go to back page
func _on_back_page_pressed() -> void: write_journal(current_journal_entry, -1)

#Toggle the visibility of components in the Journal
func toggle_visibility(journal_entry : JournalEntry):
	%Day.visible = journal_entry.is_first_page() #Only visible if the first note of the journal entry
	%BackPage.visible = not journal_entry.is_first_page() #Only visible if not the first note of the journal entry
	#%NextPage.visible = not journal_entry.is_last_page() #Only visible if not the last note of the journal entry
	
	GlobalValues.chosen_item = "" #erase the values from the pick item event to start over again
	%PickEvent.visible = false
	%YesOrNo.visible = false
	%PickRations.visible = false
	%Skip.visible = false
	if journal_entry.pick_event == true:
		%PickEvent.visible = true
		%YesOrNo.visible = false
		%NextPage.visible = false
		if GlobalValues.chosen_item != "": %NextPage.visible = true
	if journal_entry.yes_or_no_event == true:
		%PickEvent.visible = false
		%YesOrNo.visible = true
	if journal_entry.is_after_last_page(): 
		%PickRations.visible = true
		%Skip.visible = true

func _on_pick_item_pressed() -> void:
	%CameraManager.main_view()
	%PickAnItemLabel.visible = true
	GlobalValues.click_event_type = GlobalValues.click_events.items

func _on_pick_rations_pressed() -> void:
	%CameraManager.main_view()
	%ChooseRations.visible = true
	GlobalValues.click_event_type = GlobalValues.click_events.rations

func item_chosen(item : String): #This only works for pick_item event
	if item != "": #Only show when item has been chosen
		%NextPage.visible = true 

func _on_skip_pressed() -> void:
	skip_note(current_journal_entry)

func skip_note(journal_entry : JournalEntry):
	if journal_entry.is_after_last_page():
		get_journals()
		%CameraManager.main_view()

func new_event():
	pass
