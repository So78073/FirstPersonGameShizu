extends Node3D

const speed = 40.0

@onready var mesh = $MeshInstance3D
@onready var raycast = $RayCast3D

func _process(delta):
	position += transform.basis * Vector3(0, 0, -speed) * delta
