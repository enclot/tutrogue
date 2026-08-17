class_name TargetType
extends Resource

enum Mode {
	SELF,  # 自分に
	POINT, # 指定のみ
	AREA,  # 指定を中心にエリアで
	LINE   # 指定までの直線
}

@export var select_mode: Mode = Mode.SELF
@export var radius: int = 0
