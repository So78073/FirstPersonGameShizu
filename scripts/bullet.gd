extends CharacterBody3D

var speed = 5  # Velocidade de movimento


	
func _physics_process(delta):

	var direction = (transform.basis * Vector3(1, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	move_and_slide()

