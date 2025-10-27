class_name TileState
extends Sprite2D


var color_lit: Color = Color.TRANSPARENT
var color_dark: Color = Color8(50,50,50,225) #発見したが見えてない
var color_clear: Color = Color.BLACK #Color8(77,77,77,255) #未発見

var is_explored:bool = false:
	set(value):
		is_explored = value
		modulate = color_lit if is_explored else color_clear

var is_in_view:bool = false:
	set(value):
		is_in_view = value
		modulate = color_lit if is_in_view else color_dark
		if is_in_view and not is_explored:
			is_explored = true
			
var is_transparent:bool = false

var is_walkable:bool = false

# new()で作ったときしか呼ばれない
func _init(grid_position:Vector2i, tile_size:Vector2i, transparent:bool, walkable:bool) -> void:
	centered = false
	is_explored = false
	is_transparent = transparent
	is_walkable = walkable

	_make_texture(tile_size)
	position = grid_position * tile_size

	
func _make_texture(tile_size:Vector2i):
	var img := Image.create(tile_size.x, tile_size.y, false, Image.FORMAT_RGBA8)
	img.fill(Color.WHITE)
	var tex:= ImageTexture.create_from_image(img)
	texture = tex
	
