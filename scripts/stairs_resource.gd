class_name StairsResource
extends Resource

enum Direction {UP=-1, DOWN=1, EXIT=0}
@export var direction: Direction = Direction.UP

enum Pair {A,B,C}
@export var pair:Pair=Pair.A
