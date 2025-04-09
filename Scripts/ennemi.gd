extends CharacterBody2D

@onready var player = get_node("/root/Jeu/TomateMain") # il y a une meilleure maniere de le faire en l'assignant quand il spawn je crois
@onready var icon = $Icon

const VITESSE_ENNEMI = 50

signal mort

var questRep = {}
var text_file_path = "res://Questions/Lycee/derivees.txt"


func _ready() : 
	questRep = creer_dictionnaire(text_file_path)
	setQuestion()


func get_text_file_content(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content


func creer_dictionnaire(chemin_fichier):
	var dictionnaire_remplir = {}
	var text_content = get_text_file_content(chemin_fichier)
	var clef  = ""
	var valeur = ""
	var obtenu = false
	for caractere in text_content : 
		if !obtenu :
			if caractere != ',':
				clef+=caractere
		else :
			if caractere != '\n' && caractere != '\r':
				valeur+=caractere
		if caractere == ",":
			dictionnaire_remplir[clef] = ""
			obtenu = true
		if caractere  == '\n':
			dictionnaire_remplir[clef] = valeur
			valeur = ""
			clef = ""
			obtenu = false
	return dictionnaire_remplir


func _physics_process(delta):	
	var direction = global_position.direction_to(player.global_position)
	
	var angle = direction.angle()
	icon.rotation = angle
	
	velocity = direction * VITESSE_ENNEMI
	move_and_slide()
	
func die():
	queue_free()
	mort.emit(self)

func pick_random(dictionary: Dictionary) -> Variant:
	var random_key = dictionary.keys().pick_random()
	return random_key
	
func setQuestion(): 
	%Question.text = pick_random(questRep)

	
func getReponse():
	return questRep[%Question.text];
