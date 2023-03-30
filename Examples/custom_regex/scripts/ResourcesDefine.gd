extends Node

export (String, DIR) var bgs_dir : String
export (String, DIR) var sprites_dir : String

export (String, DIR) var music_dir : String
export (String, DIR) var sounds_dir : String

export var resources : Resource

func _ready():
	# turn this only if you run game from editor
	if !OS.has_feature("editor"):
		return

	if bgs_dir != "":
		define_images(resources.bg, bgs_dir)
	
	if sprites_dir != "":
		define_images(resources.sprites, sprites_dir)

	if music_dir != "":
		define_audio(resources.music, music_dir)
	
	if sounds_dir != "":
		define_audio(resources.sound, sounds_dir)


func define_images(type, path):
	var dir = Directory.new()
	
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			var formats = [".png", ".jpg"]
				
			if file_name.ends_with(formats):
				#Preloading.
				resources.loaded_images.append(ResourceLoader.load(path + "/" + file_name))
				
				
				type["path"].push_back(path+file_name)
				
				for i in formats:
					file_name = file_name.trim_suffix(i)
				
				type["name"].push_back(file_name)


			file_name = dir.get_next()
			#print(loaded_images)
			
	else:
		push_error("Images error")

func define_audio(type, path):
	var dir = Directory.new()
	
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			var formats = [".ogg", ".wav", ".mp3"]
				
			if file_name.ends_with(formats):
				#Preloading.
				resources.loaded_audio.append(ResourceLoader.load(path + file_name))
				#print("music: " + str(loaded_audio))
				
				
				type["path"].push_back(path+file_name)
				
				for i in formats:
					file_name = file_name.trim_suffix(i)
				
				type["name"].push_back(file_name)
				
				
			file_name = dir.get_next()
			#print(type)
			
	else:
		push_error("Sounds error")
