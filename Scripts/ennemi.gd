extends CharacterBody2D

@onready var player = get_node("/root/Jeu/TomateMain") # il y a une meilleure maniere de le faire en l'assignant quand il spawn je crois

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200
	move_and_slide()

func die():
	queue_free()

func setQuestion(): #on pourra lui passer la question en parametre apres
	%Question.text = str(randi() % 10) #entre 0 et 9
	
func getReponse():
	return %Question.text
