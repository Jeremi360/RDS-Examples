extends Dialogue

const later = 1
const now = 2

func _ready() -> void:
	Rakugo.define_character("Me", "m", Color.skyblue)
	Rakugo.define_character("Sylive", "s", Color.pink)

func intro_dialog():
	start_event("intro_dialog")

	show("bg lecturehall")
	say(null,
		"It's only when I hear the sounds of shuffling feet and supplies being put away that I realize that the lecture's over."
	)

	step()
	say(null,
	"Professor Eileen's lectures are usually interesting, but today I just couldn't concentrate on it."
	)

	step()
	say(null,
	"I've had a lot of other thoughts on my mind...thoughts that culminate in a question."
	)

	step()
	say(null,
		"It's a question that I've been meaning to ask a certain someone."
	)

	step()
	show("bg uni")
	say(null,
		"When we come out of the university, I spot her right away."
	)

	step()
	show("sylvie green normal")
	say(null,
		"I've known [s.name] since we were kids. She's got a big heart and she's always been a good friend to me."
	)

	step()
	say(null,
		"But recently... I've felt that I want something more."
	)

	step()
	say(null,
	"But recently... I've felt that I want something more."
	)

	step()
	say(null,
		"More than just talking, more than just walking home together when our classes end.",
		{"typing":false}
	)

	step()
	
	var choice = menu([
		["To ask her right away.", now, {}],
		["To ask her later.", later, {}],
	])
	
	if is_active():
		if cond(choice == now):
			$rightaway.start()

		elif cond(choice == later):
			$later.start()
	
	exit()
	end_event()
