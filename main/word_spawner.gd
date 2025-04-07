extends RefCounted

class_name WordSpawner

var current_phase: WordManager.Phase
var current_wordlist: WordList = null
var current_spawn_timeout = 0
var word_factory: WordFactory

func _init(_word_factory: WordFactory) -> void:
	word_factory = _word_factory

func spawn_word(phase: WordManager.Phase, delta_time: float) -> BaseWord:
	if current_phase != phase:
		#phase changed:
		current_phase = phase
		current_wordlist = null
		
		
	if current_wordlist == null || (current_wordlist != null && current_wordlist.is_finished()):
		var available_lists = wordlists.get(current_phase)
		current_wordlist = available_lists[randi_range(0, available_lists.size()-1)].duplicate()
		current_spawn_timeout = current_wordlist.spawn_interval
		return null
	
	current_spawn_timeout -= delta_time
		
	if current_spawn_timeout <= 0:
		current_spawn_timeout = current_wordlist.spawn_interval
		var word_data =  current_wordlist.pop()
		
		var word_text: String = word_data.text		
		var word_instance: BaseWord
	   
		match word_data.type:
			WordData.Type.NORMAL:
				word_instance = word_factory.create_normal_word(word_text, "wave")
			WordData.Type.BLINKING: 
				word_instance = word_factory.create_blinking_word(word_text, "wave")
			WordData.Type.MULTI_VALIDATION: 
				word_instance = word_factory.create_multivalidation_word(word_text, "heart", word_data.validations)
			WordData.Type.LEET:
				word_instance = word_factory.create_normal_word(word_text, "l33t")
			WordData.Type.MOCK:
				word_instance = word_factory.create_normal_word(word_text, "sin")
			WordData.Type.RANDOM:
				#TODO
				pass
		
		word_instance.position = get_random_spawn_point()
		return word_instance
	
	return null	
		
		
func get_random_spawn_point() -> Vector2:
	var max_x = DisplayServer.screen_get_size().x
	var max_y = DisplayServer.screen_get_size().y
	var random_side: int = randi_range(0, 1)
	var random_y: int = randi_range(0, max_y)
	
	match random_side:
		0: return Vector2(max_x, random_y) # right
		1: return Vector2(0, random_y) # left
		_: return Vector2.ZERO	
	
	


	






var word_list_easy: WordList = WordList.new(
	 [
		"butterfly",
		"meadow",
		"sunlight",
		"lullaby",
		"dream",
		"cloud",
		"rainbow",
		"forest",
		"star",
		"whispers",
		"soft",
		"breeze",
		"glimmer",
		"petal",
		"echo",
		"dew",
		"fawn",
		"moonlight",
		"bloom",
		"sleep",
		"wind",
		"laughter",
		"crystal",
		"lantern",
		"drift",
		"heart",
		"mist",
		"twilight",
		"wander",
		"reflection",
		"whimsy",
		"glow"
	],
	[
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.MULTI_VALIDATION),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new_random(WordData.Type.NORMAL),
	WordData.new_random(WordData.Type.BLINKING),
	WordData.new("???", WordData.Type.MULTI_VALIDATION),
], 1.5, 50)

var word_list_easy_2: WordList = WordList.new(
	 [
	],
	[
	WordData.new("light", WordData.Type.BLINKING),
	WordData.new("seen", WordData.Type.BLINKING),
	WordData.new("clarity", WordData.Type.BLINKING),
	WordData.new("blind", WordData.Type.BLINKING),
	WordData.new("strobe", WordData.Type.BLINKING),
	WordData.new("blink", WordData.Type.BLINKING),
	WordData.new("light", WordData.Type.BLINKING),
	WordData.new("seen", WordData.Type.BLINKING),
	WordData.new("clarity", WordData.Type.BLINKING),
	WordData.new("blind", WordData.Type.BLINKING),
	WordData.new("strobe", WordData.Type.BLINKING),
	WordData.new("blink", WordData.Type.BLINKING),
	WordData.new("light", WordData.Type.BLINKING),
   	WordData.new("seen", WordData.Type.BLINKING),
   	WordData.new("clarity", WordData.Type.BLINKING),
   	WordData.new("blind", WordData.Type.BLINKING),
   	WordData.new("strobe", WordData.Type.BLINKING),
   	WordData.new("blink", WordData.Type.BLINKING),
], 2, 50, 1, 30)


var word_list_medium: WordList = WordList.new( [
		 "hollow",
		 "veil",
		 "silk",
		 "murmur",
		 "unseen",
		 "murk",
		 "Ucxudhrutl",
		 "HoLLoWeD",
		 "forgotten",
		 "unearthed",
		 "VEilEd",
		 "starlight",
		 "foG",
		 "Yovaaztosh",
		 "SHIVER",
		 "abyss",
		 "eerie",
		 "fathom",
		 "nightshade",
		 "oc'thaatloh",
		 "pulse",
		 "EnIgMa",
		 "wraith",
		 "yid'ognnig",
		 "ObScUrE",
		 "blackened",
		 "cxothalbh",
		 "unravel",
		 "cryptic",
		 "unholy",
		 "yoc'thaggiss",
		 "dread",
		 "ABOMINATION"
		 ],
		[
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.BLINKING),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.BLINKING),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.BLINKING),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.BLINKING),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.BLINKING),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.BLINKING),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.BLINKING),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.BLINKING),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.BLINKING),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new_random(WordData.Type.NORMAL),
		WordData.new("abyss", WordData.Type.MULTI_VALIDATION)
], 1.4, 55)

var word_list_nightmare: WordList = WordList.new([],[
	WordData.new("help me", WordData.Type.MULTI_VALIDATION, 2),
	WordData.new("grief", WordData.Type.BLINKING),
	WordData.new("searing", WordData.Type.BLINKING),
	WordData.new("mournful", WordData.Type.BLINKING),
	WordData.new("hElp mE", WordData.Type.NORMAL),
	WordData.new("requiem", WordData.Type.BLINKING),
	WordData.new("Zughrotl'Thuth", WordData.Type.NORMAL),
	WordData.new("shattered", WordData.Type.BLINKING),
	WordData.new("HELP ME", WordData.Type.NORMAL),
	WordData.new("phantom", WordData.Type.BLINKING),
	WordData.new("blight", WordData.Type.BLINKING),
	WordData.new("Aic'Thygh'Vhis", WordData.Type.NORMAL),
	WordData.new("ruin", WordData.Type.BLINKING),
	WordData.new("nightmarish", WordData.Type.BLINKING),
	WordData.new("malevolent", WordData.Type.BLINKING),
	WordData.new("rot", WordData.Type.BLINKING),
	WordData.new("help...", WordData.Type.NORMAL),
	WordData.new("Aighraadhrux", WordData.Type.BLINKING),
	WordData.new("abyssal", WordData.Type.BLINKING),
	WordData.new("sorrows", WordData.Type.BLINKING),
	WordData.new("help me ... please", WordData.Type.NORMAL),
	WordData.new("writhing", WordData.Type.BLINKING),
	WordData.new("madness", WordData.Type.BLINKING),
	WordData.new("cursed", WordData.Type.BLINKING),
	WordData.new("Ctuignn'Gnu", WordData.Type.NORMAL),
	WordData.new("eldritch", WordData.Type.BLINKING),
	WordData.new("unseen", WordData.Type.BLINKING),
	WordData.new("void", WordData.Type.BLINKING),
	WordData.new("tainted", WordData.Type.NORMAL),
	WordData.new("disembodied", WordData.Type.BLINKING),
	WordData.new("frenzied", WordData.Type.BLINKING),
	WordData.new("unfathomable", WordData.Type.BLINKING),
	WordData.new("abominable", WordData.Type.BLINKING),
	WordData.new("Laucthaar'Xa", WordData.Type.NORMAL),
	WordData.new("foulness", WordData.Type.BLINKING),
	WordData.new("eldritch", WordData.Type.BLINKING),
	WordData.new("netherworld", WordData.Type.BLINKING),
	WordData.new("horrid", WordData.Type.BLINKING),
	WordData.new("devouring", WordData.Type.BLINKING),
	WordData.new("Yokaazh'Vhotl", WordData.Type.MULTI_VALIDATION, 2),
], 1.3, 60)
			
	
var wordlists = {
	WordManager.Phase.EASY: [word_list_easy],
	WordManager.Phase.MEDIUM: [word_list_medium],
	WordManager.Phase.NIGHTMARE: [word_list_nightmare],
}
	
