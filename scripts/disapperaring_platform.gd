extends StaticBody2D

@export var cycle_time = 2.0
@export var is_visible = true

@onready var mesh_instance = $MeshInstance2D
@onready var collision_shape = $CollisionShape2D

func _ready():
	_toggle_visibility()

func _toggle_visibility() -> void:
	is_visible = !is_visible
	mesh_instance.visible = is_visible
	collision_shape.disabled = !is_visible
	await get_tree().create_timer(cycle_time).timeout
	_toggle_visibility()
