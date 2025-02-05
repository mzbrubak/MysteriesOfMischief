extends Character_Base
var possessionOffset:Vector2
var isPossessing:bool = false
signal NameEntryModeToggle


func _ready():
	MainMenuMusic.stop()
	
	super._ready()
	speed=200

func _process(delta):
	MainMenuMusic.stop()
	
	if isPossessing:
		return
	super._process(delta)
	if Input.is_action_just_pressed("Possess"):
		attemptPossession()
	if Input.is_action_just_pressed("Attack  or Character Action") and pause_menu.visible==false:
		NameEntryModeToggle.emit()

#don't need fairy to act during possession

func _physics_process(delta):
	if isPossessing:
		return
	super._physics_process(delta)
#don't need fairy to move during possession
	
func attemptPossession():
	if interactionCandidates.is_empty():
		#print("No possessable characters in range.")
		pass
	else:
		var index=0
		var possessionCandidate=null
		while possessionCandidate==null and index<interactionCandidates.size():
			if interactionCandidates[index].has_method("becomePossessed"):
				possessionCandidate=interactionCandidates[index]
			index+=1
		if possessionCandidate==null:
			#print("No possessable characters in range.")
			pass
		else:
			if possessionCandidate.find_child("NameEntry").text==possessionCandidate.NAME:
				#print("Possessing ",possessionCandidate)
				possessionCandidate.becomePossessed()
				find_child("Hitbox").disabled=true
				possessionCandidate.possessionEnding.connect(endPossession)
				possessionOffset=position-possessionCandidate.position
				get_node("Sprite2D").visible=false
				isPossessing=true
			else:
				#print("Can't possess character without knowing their name")
				pass

func endPossession(Character):
	position=Character.position+possessionOffset
	find_child("Hitbox").disabled=false
	isPossessing=false
	Character.possessionEnding.disconnect(endPossession)
	get_node("Sprite2D").visible=true
	Camera.make_current()
	
