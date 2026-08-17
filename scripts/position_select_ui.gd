class_name PositionSelectUI
extends Node2D

@onready var cursor: GridObject = $Cursor
@onready var selected_template: GridObject = $Selected

var selected_cells: Array[Vector2i]=[]

signal positions_selected(positions:Array[Vector2i])

var origin:Vector2i
var target_type:TargetType

func _ready() -> void:
	var parent = get_parent() as Actor
	origin = parent.grid_position

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		for action:StringName in GameInputHandler.DIRECTIONS.keys():
			if event.is_action_pressed(action):
				var offset: Vector2i = GameInputHandler.DIRECTIONS[action]
				cursor.grid_position += offset
				_update_selected()
				break	
				
	if event.is_action_pressed("ui_cancel"):
		#キャンセル時は空を返す
		positions_selected.emit([] as Array[Vector2i]) 
		queue_free()
	elif event.is_action_pressed("ui_accept"):
		# grid_positonに直して返す
		var grid_positions:Array[Vector2i]
		for pos:Vector2i in selected_cells:
			grid_positions.append(pos+origin)
		positions_selected.emit(grid_positions) 
		queue_free()		

func _update_selected() ->void:
	selected_cells.clear()
	
	match target_type.select_mode:
		TargetType.Mode.POINT:
			selected_cells.append(cursor.grid_position)
		TargetType.Mode.AREA:
			selected_cells.append_array(get_area_cells(target_type.radius))
		TargetType.Mode.LINE:
			selected_cells.append_array(get_line_cells(target_type.radius))

	# テンプレート以外のコピーを削除
	for child in get_children():
		if child != selected_template and child != cursor:
			child.queue_free()
			
	selected_template.visible = false

	for cell in selected_cells:
		var copy = selected_template.duplicate()
		copy.visible = true
		copy.grid_position = cell
		add_child(copy)
		

			
func get_area_cells(_radius:int) -> Array[Vector2i]:
	# マンハッタン距離
	var cells: Array[Vector2i] = []
	var center := cursor.grid_position
	for dy in range(-_radius, _radius + 1):
		for dx in range(-_radius, _radius + 1):
			var current_distance = abs(dx) + abs(dy)
			if current_distance <= _radius:
				cells.append(center + Vector2i(dx, dy))
	return cells

func get_line_cells(_radius:int) -> Array[Vector2i]:
	#ブレゼンハム
	var cells: Array[Vector2i] = []
	
	var start := Vector2i.ZERO
	var target := cursor.grid_position

	var diff = target - start
	var dx:int = abs(diff.x)
	var dy:int = abs(diff.y)
	
	var sx: int = sign(diff.x)
	var sy: int = sign(diff.y)

	var x := start.x
	var y := start.y

	var err: int = dx - dy
	
	var half := Vector2i(_radius,_radius)
	var used_rect := Rect2i(-half, half*2)

	while true:
		var cell =Vector2i(x,y)
		if used_rect.has_point(cell):
			cells.append(cell)

		if x == target.x and y == target.y:
			break

		var e2: int = err * 2

		if e2 > -dy:
			err -= dy
			x += sx

		if e2 < dx:
			err += dx
			y += sy

	# front:始点は除く
	cells.pop_front()
	return cells

func configure_target_type(_type:TargetType) -> void:
	target_type = _type
