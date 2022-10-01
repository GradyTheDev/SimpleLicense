extends Resource

## Holds copyright names, and dates
class_name Copyright

## Format [br]
## John Doe, Corp Entity, ...
@export_placeholder("John Doe, Corp Entity, ...") var creators: String = ""
## Format [br]
## 1930, 2002-2003, ...
@export_placeholder("1930, 2002-2003, ...") var years: String = ""


## returns "<years>, <creators>"
func _to_string() -> String:
	# copyright symbol -> \u00A9
	return "{0}, {1}".format([years, creators])
