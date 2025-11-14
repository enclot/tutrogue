class_name SpecifiedPositionUI
extends Node2D

@onready var cursor: TileIndicator = $TileIndicator
@onready var target_positions: Node2D = $TargetPositions

const directions={
	"move_up":Vector2i.UP,
	"move_down":Vector2i.DOWN,
	"move_left":Vector2i.LEFT,
	"move_right":Vector2i.RIGHT,
	"move_up_left":Vector2i.UP+ Vector2i.LEFT,
	"move_up_right":Vector2i.UP+ Vector2i.RIGHT,
	"move_down_left":Vector2i.DOWN+ Vector2i.LEFT,
	"move_down_right":Vector2i.DOWN+ Vector2i.RIGHT,	
}

signal position_selected(b)

var specifiable_component:SpecifiableComponent

var base_position:Vector2i #playerのgrid_position

func initialize(_user_actor:Actor, _specifiable:SpecifiableComponent) -> void:
	specifiable_component = _specifiable
	
	base_position = _user_actor.grid_position
	cursor.grid_position = _user_actor.grid_position
	cursor.map = _user_actor.map

func _input(event: InputEvent) -> void:
	for direction in directions:
		if event.is_action_pressed(direction):
			var offset: Vector2i = directions[direction]
			var target_position = cursor.grid_position + offset
			var distance = base_position.distance_to(target_position)
			if distance<specifiable_component.reach:
				#target position候補を取得
				specifiable_component.target_positions = _get_specified_positions(target_position)
				MovementAction.new(cursor,offset).perform()
	if event.is_action_pressed("ui_cancel"):
		position_selected.emit(false)
		queue_free()
	elif event.is_action_pressed("ui_accept"):
		position_selected.emit(true)
		queue_free()	


func _get_specified_positions(_target_position:Vector2i) -> Array[Vector2i]:
	
	for c in target_positions.get_children():
		c.queue_free()
		
	var line_grid = _bresenham_line(base_position, _target_position)
	line_grid.pop_front() #自分の位置は外す
	
	if not specifiable_component.piercing:
		line_grid = line_grid.slice(0,1)  # 最初の要素が最も自分の位置に近い
	  
	#表示用
	for pos in line_grid:
		var new_cursor:Actor = cursor.duplicate()
		new_cursor.grid_position = pos
		new_cursor.modulate = Color.html("#ff3e63a7")
		target_positions.add_child(new_cursor)
		
	return line_grid

func _bresenham_line(start: Vector2i, goal: Vector2i) -> Array[Vector2i]:
	var points: Array[Vector2i] = []

	var x0 = start.x
	var y0 = start.y
	var x1 = goal.x
	var y1 = goal.y

	var dx = abs(x1 - x0)
	var dy = -abs(y1 - y0)
	var sx = sign(x1 - x0)
	var sy = sign(y1 - y0)
	var err = dx + dy

	while true:
		points.append(Vector2i(x0, y0))  # 座標を追加

		if x0 == x1 and y0 == y1:
			break

		var e2 = 2 * err
		if e2 >= dy:
			err += dy
			x0 += sx
		if e2 <= dx:
			err += dx
			y0 += sy

	return points
