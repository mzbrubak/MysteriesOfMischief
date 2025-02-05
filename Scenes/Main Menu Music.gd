extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	
	# If the music is not playing, then play the music
	if $".".playing == false:
		$".".play()
	
	# If the music is playing, then set the volume_db equal to the music volume minus 80
	if $".".playing == true:
		$".".volume_db = MusicVolume.musicVolume - 80;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pass
	
	# If the music has ended at 31 seconds, play the music again and set the loop timer back to 0
	if $".".playing == false:
		$".".play()
	
	if $".".playing == true:
		$".".volume_db = MusicVolume.musicVolume - 80
