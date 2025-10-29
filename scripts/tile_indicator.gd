class_name TileIndicator
extends Actor

func _ready() -> void:
	_make_texture(tile_size)

func _make_texture(_tile_size:Vector2i):
	var img := Image.create(_tile_size.x, _tile_size.y, false, Image.FORMAT_RGBA8)
	img.fill(Color.WHITE)
	var tex:= ImageTexture.create_from_image(img)
	sprite_2d.texture = tex
