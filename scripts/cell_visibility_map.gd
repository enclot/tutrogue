class_name CellVisibilityMap
extends Node2D


var image:Image
var image_texture:ImageTexture

var width:int
var height:int
var map_scale:Vector2

@onready var sprite_2d: Sprite2D = $Sprite2D

var cells:Array[CellVisibility]


func initialize(_width:int, _height:int, _scale:Vector2)->void:
	width = _width
	height = _height
	map_scale = _scale

	for i in width*height:
		cells.append(CellVisibility.new())

	image = Image.create(width, height, false, Image.FORMAT_RGBA8)
	image.fill(Color.BLACK)
	image_texture = ImageTexture.create_from_image(image)
	
	sprite_2d.texture = image_texture
	sprite_2d.scale = map_scale
	sprite_2d.centered = false #左上が原点になるように
	# ソフトにしたいなら LINEAR
	#sprite_2d.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR

	
# cellsの内容に従ってテクスチャーを作り直す
func update() -> void:
	for y in height:
		for x in width:
			var cell := cells[y*width+x]
			var alpha:float
			if !cell.is_explored:
				#未探索
				alpha = 1.0
			elif !cell.is_visible:
				#探索済みだが現在見えていない
				alpha = 0.7
			else:
				#それ以外
				alpha = 0
				
			image.set_pixel(x,y, Color(0,0,0,alpha))
	image_texture.update(image)
	
	
func get_cell(_pos: Vector2i) -> CellVisibility:
	return cells[_pos.y * width + _pos.x]

func is_in_bounds(pos: Vector2i) -> bool:
	return (
		0 <= pos.x
		and pos.x < width
		and 0 <= pos.y
		and pos.y < height
		)

func clear_visible_flags() -> void:
	for cell:CellVisibility in cells:
		cell.is_visible = false
		# (注意) cell.is_explored はリセットしない
