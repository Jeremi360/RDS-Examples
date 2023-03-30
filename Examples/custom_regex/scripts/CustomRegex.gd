extends Node

export (String, FILE, "*.rk") var file_path : String

onready var ResourcesDefine := $ResourcesDefine
onready var Audio := $AudioStreamPlayer2D
onready var color = $ColorRect
onready var bg = $BG
onready var label = $Panel/HBoxContainer/Label
onready var button = $Panel/HBoxContainer/Button

func _ready():

	var id_regex = "([a-zA-Z0-9_]+ ?)+"

	Rakugo.parser_add_regex_at_runtime("show", "^show (?<id>%s)" %  id_regex )
	Rakugo.parser_add_regex_at_runtime("hide", "^hide (?<id>%s)" %  id_regex )
	Rakugo.parser_add_regex_at_runtime("play", "^play (?<id>%s)" %  id_regex )
	Rakugo.parser_add_regex_at_runtime("stop", "^stop (?<id>%s)" %  id_regex )

	Rakugo.connect("parser_unhandled_regex", self, "_on_parser_unhandled_regex")

	button.connect("pressed", self, "_on_button_pressed")

	if file_path != "":
		Rakugo.parse_and_execute_script(file_path)


func _on_button_pressed():
	Rakugo.step()

func _on_parser_unhandled_regex(key:String, result:RegExMatch):
	var ids = result.get_string("id").split(" ")
	
	label.text = result

	match(key):
		"show":
			###Color
			for i in ids:
				if i == "color":
					color.color = ColorN(ids[1])
					color.visible = true
				
			###Background
				if i == "bg":
					var name_num = ResourcesDefine.bg.get('name').find(str(ids[1]))
					var path_to_file = ResourcesDefine.bg.get('path')[name_num]
					
					bg.texture = load(path_to_file)
					bg.visible = true
			
		"hide":
			var layers = ['color', 'bg', 'sprite']
			for i in layers.size():
				if ids[0].begins_with(str(layers[i])):
					ids[0] = layers[i]
			
			
			find_node(ids[0]).visible = false


		"play":
			for i in ids:
			###Play music
				if i == "music":
					var name_num = ResourcesDefine.music.get('name').find(ids[1])
					var path_to_file = ResourcesDefine.music.get('path')[name_num]
					
					if "fadein" in ids:
						Audio.play_music(path_to_file, true, float(ids[3]))
						
					else:
						Audio.play_music(path_to_file, false, 0)
						
			###Play sound
				if i == "sound":
					var name_num = ResourcesDefine.sound.get('name').find(ids[1])
					var path_to_file = ResourcesDefine.sound.get('path')[name_num]
					
					Audio.play_sound(path_to_file)
						
						
		"stop":
			for i in ids:
				
				if i == "music":
					if "fadeout" in ids:
						Audio.stop_music(true, float(ids[2]))
					
					else:
						Audio.stop_music(false, 0)
