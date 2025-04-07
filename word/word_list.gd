extends RefCounted

class_name WordList

var list: Array[WordData] = []
var list_random_words = []
var speed
var speed_increase_interval
var speed_increase_amount
var spawn_interval
var consumed_words = 0
 
func _init(_list_random_word: Array[String], _list: Array[WordData], _spawn_interval: float, _speed: int = 100, _speed_increase_interval: int = 0, _speed_increase_amount: int = 0):
	list_random_words = _list_random_word
	list = _list
	speed = _speed
	speed_increase_interval = _speed_increase_interval
	speed_increase_amount = _speed_increase_amount
	spawn_interval = _spawn_interval
	
func is_finished() -> bool:
	return list.is_empty()	

func pop() -> WordData:
	consumed_words+=1
	var word: WordData = list.pop_front()
	if word.is_random:
		word.text = get_random_word()
	return word

func get_random_word() -> String:
	var random = randi_range(0, list_random_words.size() - 1)
	return list_random_words.pop_at(random)

func get_speed_increase_amount() -> float:
	if speed_increase_interval == 0:
		return 0
	return (consumed_words / speed_increase_interval) * speed_increase_amount

	
func duplicate() -> WordList:
	return WordList.new(list_random_words.duplicate(), list.duplicate(), spawn_interval, speed, speed_increase_interval, speed_increase_amount)
	