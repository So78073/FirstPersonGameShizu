extends CharacterBody3D

var keys = []


@export_category("Player Settings")
@export var speed = 5.0
var speed_run = speed * 2
@export var jump_force = 4.5

var gravity = 9.8
@export_category("Setings Mouse")
@export var mouse_sency := 0.2
var mouseMode = false
var cam_ver = 0.0
@export var min_cam := -80.0
@export var max_cam := 80.0

var can_click = true
var can_move = true
var can_fire = true
#==============================================================================
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _physics_process(delta):

	move(delta)
	mouseModeFn()
	raycastUpdate()
	move_and_slide()
	debug()


#==============================================================================

func move(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		if Input.is_action_pressed("run"):
			velocity.x = direction.x * speed_run
			velocity.z = direction.z * speed_run
		else:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

func mouseModeFn():
	if Input.is_action_just_pressed("ui_cancel"):
		mouseMode = !mouseMode
		if mouseMode == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else: 
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func raycastUpdate():
	var raycast = $node/cam/Came/raycast/RayCast3D
	raycast.force_raycast_update()
	var collider = raycast.get_collider()
	
	if raycast.is_colliding() and Input.is_action_just_pressed("fire"):
		if collider.name == "key":
			if keys.find(collider.key_code) == -1:
				keys.append(collider.key_code)
				collider.free()

		else: 
			if collider is Node3D:
				print(collider.name)

func debug():
	if Input.is_action_just_pressed("debug"):
		pass
# -----------------------------------------------------------------------------

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sency))
		
		cam_ver -= event.relative.y * mouse_sency
		cam_ver = clamp(cam_ver, min_cam, max_cam)
		$node/cam.rotation_degrees.x = cam_ver
	





