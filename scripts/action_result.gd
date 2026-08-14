class_name ActionResult
extends RefCounted

#ターンを消費する場合はtrue
var succeeded = false

#代替actionがあったらターンを消費せずに次のループでそのアクションを実行する
var alternative:Action = null

func _init(_succeeded:bool, _alternative:Action=null) -> void:
	succeeded = _succeeded
	alternative = _alternative
