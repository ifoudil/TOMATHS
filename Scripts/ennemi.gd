extends CharacterBody2D

@onready var player = get_node("/root/Jeu/TomateMain")

signal eliminate()
# queue free will kill the thing


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200
	move_and_slide()
	
