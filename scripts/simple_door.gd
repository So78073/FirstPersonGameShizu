extends StaticBody3D

@export var key = 0
@export var status = false

var keys_player = []
var player_on_area = false
var can_use = false


func _ready():
	if status == true:
		$anim.play('close_ready')
	else :
		$anim.play('open_ready')

func _process(delta):
	if player_on_area == true and Input.is_action_just_pressed("fire") and can_use == true:
		status = !status
		
		if status == true:
			$anim.play("open")

		else :
			$anim.play("close")
			
		

func _on_area_3d_body_entered(body):
	if body.name == "player":
		if body.keys.find(key) == 0:
			can_use = true
			print('Esta aberto')
		else:
			print('Esta fechado')
			can_use = false
		player_on_area = true



func _on_area_3d_body_exited(body):
	if body.name == "player":
		player_on_area = false




func _on_anim_animation_finished(anim_name):
	can_use = true

func _on_anim_animation_started(anim_name):
	can_use = false
