extends CharacterBody2D

@export var gravity = 350
@export var speed = 200
@export var acceleration = 0.2
@export var jump_force = 260

@onready var sprite = $AnimatedSprite2D
var player_in_area = false

func _physics_process(delta):
	# Si le joueur est en l'air, il subit la gravité
	if !is_on_floor():
		velocity.y = clamp(velocity.y + gravity * delta, -500, 500)
	
	# Déplacement du joueur
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		sprite.flip_h = (direction == 1)
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	velocity.x = lerp(velocity.x, direction * speed, acceleration)
	update_animation(direction)
	move_and_slide()

# Met à jour l'animation du joueur en fonction du mouvement
func update_animation(direction):
	if is_on_floor():
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("run")
	else:
		sprite.play("jump")
