extends Control

@export var journal_entries : Array[JournalEntry]

var current_journal_entry_title : String
var current_journal_entry : JournalEntry

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.connect("item_changed", item_chosen) ##This only works for pick_item event
	
	current_journal_entry_title = "Pipes"
	next_page()

#Enter a Journal title and this will find the JournalEntry from the array in journal_entries
func find_journal_entry(title : String) -> JournalEntry:
	for journal_entry in journal_entries:
		if journal_entry.Title == title:
			return journal_entry
	return null

#go to next page of the journal entry
func _on_next_page_pressed() -> void:
	next_page()

#extended function after next page is pressed
func next_page() -> void:
	current_journal_entry = find_journal_entry(current_journal_entry_title)#Get the journal entry
	var note : String = current_journal_entry.flip_journal() #Get the note from the next page of the journal
	
	%JournalAnimations.play("flip") #Animation only, the animation also changes transparency of text label
	await get_tree().create_timer(0.5).timeout #for animation
	
	%Body.text = note #set the note as the text body
	toggle_visibility(current_journal_entry) #toggle the buttons in the notes visibility
	
	GlobalValues.chosen_item = ""
	%PickEvent.visible = false
	%YesOrNo.visible = false
	if current_journal_entry.pick_event == true:
		%PickEvent.visible = true
		%YesOrNo.visible = false
	if current_journal_entry.yes_or_no_event == true:
		%PickEvent.visible = false
		%YesOrNo.visible = true
	

#Go to back page
func _on_back_page_pressed() -> void:
	back_page()

#extended function after back page is pressed
func back_page() -> void:
	current_journal_entry = find_journal_entry(current_journal_entry_title)#Get the journal entry
	var note : String = current_journal_entry.flip_backwards_journal() #Get the note from the back page of the journal
	
	%JournalAnimations.play_backwards("flip") #Animation only, the animation also changes transparency of text label
	await get_tree().create_timer(0.3).timeout #for animation

	%Body.text = note #set the note as the text body
	toggle_visibility(current_journal_entry) #toggle the buttons in the notes visibility

#Toggle the visibility of components in the Journal
func toggle_visibility(journal_entry : JournalEntry):
	%Day.visible = journal_entry.is_first_page() #Only visible if the first note of the journal entry
	%BackPage.visible = not journal_entry.is_first_page() #Only visible if not the first note of the journal entry
	%NextPage.visible = not journal_entry.is_last_page() #Only visible if not the last note of the journal entry

func _on_pick_item_pressed() -> void:
	%CameraManager.main_view()
	%PickAnItemLabel.visible = true

func item_chosen(item : String): #This only works for pick_item event
	if item != "": #Only show when item has been chosen
		%NextPage.visible = true 
