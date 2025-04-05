extends CharacterBody2D

@onready var player = get_node("/root/Jeu/TomateMain") # il y a une meilleure maniere de le faire en l'assignant quand il spawn je crois

const VITESSE_ENNEMI = 50

var questRep = {"x^a":"ax^a-1",
"1/x":"-1/x^2",
}

var text_file_path = "res://Questions/derivees.txt" 

func _ready() : 
	var text_content = get_text_file_content(text_file_path) #en gros faut lire depuis le fichier pour remplir le dictionnaire (et donc vider celui qu'il y a la)
	print(text_content)
	

func get_text_file_content(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
	



func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * VITESSE_ENNEMI
	move_and_slide()
	
func die():
	queue_free()


func setQuestion(): #on pourra lui passer la question en parametre apres
	for i in questRep: #pire manière possible de selectionner une valeur aléatoire
		if randi() % 10 <=2:
			%Question.text=i;
			break;
		else :
			%Question.text=i;
		

	
func getReponse():
	return questRep[%Question.text];
