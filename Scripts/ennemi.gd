extends CharacterBody2D

@onready var player = get_node("/root/Jeu/TomateMain") # il y a une meilleure maniere de le faire en l'assignant quand il spawn je crois

const VITESSE_ENNEMI = 50

signal mort

var questRep = {}
var text_file_path = "res://Questions/tablesMultiplication.txt"


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
	velocity = direction * VITESSE_ENNEMI
	move_and_slide()
	
func die():
	queue_free()
	mort.emit()

func pick_random(dictionary: Dictionary) -> Variant:
	var random_key = dictionary.keys().pick_random()
	return random_key
	
func setQuestion(): 
	%Question.text = pick_random(questRep)

	
func getReponse():
	return questRep[%Question.text];
	
	


"""

Code pour l'ennemi :
@onready var prompt = $Label # ça peut être un label ou un tableau ou je sais pas quoi juste le truc dans lequel est stocké la question
@onready var prompt_text = prompt.text


# De ce que j'ai pu voir c'est grosso modo ce que devrait faire le getReponse()
func get_prompt() -> String:
	var expr = Expression.new()
	var error = expr.parse(prompt_text) # error = 0 si pas d'erreur
	
	if error != OK: # OK = 0
		print("Parse error: ", error)
		return ""
		
	
	var resultat = expr.execute()
	print("resulat : ", resultat)
	return str(resultat) 
	
	
--------------

# Code pour la partie qui gère les entrées de l'utilisateur et de vérifier si la réponse est bonne

var active_enemy = null
var current_letter_index: int = -1

func find_new_active_enemy(typed_character: String):
	var prompt = $Ennemi.get_prompt()
		
	if prompt.substr(0,1) == typed_character:
		print("trouvé")
		active_enemy = $Ennemi
		current_letter_index = 1

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.is_pressed():
		var typed_event = event as InputEventKey
		var key_typed = OS.get_keycode_string(typed_event.keycode)
		
		# ça assigne les touches du pad numérique car sinon elles sont pas reconnues mais ça reconnait bien les touches normales
		# faut probablement chercher un moyen plus efficace de faire ça car on va pas faire ça à chaque fois
		# ça peut aussi être enlevé si ça devient trop chiant
		match typed_event.keycode:
			KEY_KP_0: key_typed = "0"
			KEY_KP_1: key_typed = "1"
			KEY_KP_2: key_typed = "2"
			KEY_KP_3: key_typed = "3"
			KEY_KP_4: key_typed = "4"
			KEY_KP_5: key_typed = "5"
			KEY_KP_6: key_typed = "6"
			KEY_KP_7: key_typed = "7"
			KEY_KP_8: key_typed = "8"
			KEY_KP_9: key_typed = "9"
			
		print("key : ", key_typed)
		
		if active_enemy == null:
			find_new_active_enemy(key_typed)
		
		# faut laisser ça en if sinon ça plante ou ça demande rentrer 2 fois la réponse
		if active_enemy != null:
			var prompt = active_enemy.get_prompt()
			
			var next_character = prompt.substr(current_letter_index, 1)
			
			if key_typed == next_character:
				print("enemy hit")
				current_letter_index += 1
				
			if current_letter_index == prompt.length():
				current_letter_index = -1
				active_enemy.queue_free()
				active_enemy = null
				print("tué")

"""
