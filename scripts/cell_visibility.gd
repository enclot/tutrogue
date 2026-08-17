class_name CellVisibility
extends RefCounted

# is_visibleがtrueになったらis_exploredも合わせてtrueになる
var is_visible:bool = false:
	set(value):
		is_visible = value
		if is_visible and not is_explored:
			is_explored = true

var is_explored:bool = false
