extends RefCounted

class_name WordData

enum Type {
	RANDOM,
	NORMAL,
	BLINKING,
	LEET,
	MOCK,
	MULTI_VALIDATION
}

var text: String
var text_to_validate: String
var type: Type
var validations: int
var is_eldrich = false
var is_random = false

func _init(_text: String, _type: Type, _validations = 0, _is_eldrich = false):
	text = _text;
	text_to_validate = _text
	type = _type;
	validations = _validations
	is_eldrich = _is_eldrich
	
	
static func new_random(_type: Type, _validations = 0):
	var out = WordData.new("", _type, _validations)
	out.is_random = true
	return out