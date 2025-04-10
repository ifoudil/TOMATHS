extends Node2D

const OBJET_ENNEMI = preload("res://Characters_scenes/ennemi.tscn")
const BULLET_OBJECT = preload("res://Characters_scenes/balle.tscn")
const MENU_PRINCIPAL = preload("res://Characters_scenes/level.tscn")



var tabEnnemis = {} # Enregistre tous les ennemis pour faciliter la réinitialisation

func _physics_process(delta):
	if not get_tree().paused :
		var reponse = %EncadreReponse.getText()

		var liste_ennemis = %ZoneDeTir.get_overlapping_bodies()
		for i in range(len(liste_ennemis)-1):
			if(liste_ennemis[i].has_method("die") && liste_ennemis[i].getReponse()==reponse):
				tirer(liste_ennemis[i])
				%EncadreReponse.resetText()
		Global.score+=0.03 #fait augmenter petit à petit le score au fil du temps
		%Score.text = "Score : " + str(round(Global.score))
		


func apparaitre_ennemi() : 
	var nouvel_ennemi = OBJET_ENNEMI.instantiate()
	nouvel_ennemi.connect("mort",_on_ennemi_mort)
	%CheminSpawn.progress_ratio= randf()
	nouvel_ennemi.global_position = %CheminSpawn.global_position
	add_child(nouvel_ennemi)
	ajouter_ennemi_tab(nouvel_ennemi)
	return nouvel_ennemi

func ajouter_ennemi_tab(ennemi):
	var cle = str(tabEnnemis.size())
	tabEnnemis[cle] = ennemi

func _on_ennemi_mort(ennemi):
	Global.score+=100
	retirer_ennemi_tab(ennemi)
	ennemi.queue_free()

func tirer(nouvel_ennemi):
	var new_bullet = BULLET_OBJECT.instantiate()
	new_bullet.global_position = %TomateMain.global_position
	new_bullet.look_at(nouvel_ennemi.global_position)
	add_child(new_bullet)
	retirer_ennemi_tab(nouvel_ennemi)
	
func retirer_ennemi_tab(ennemi):
	for cle in tabEnnemis.keys():
		if tabEnnemis[cle] == ennemi:
			tabEnnemis.erase(ennemi)
			break



func _on_timer_timeout():
	apparaitre_ennemi()


func _on_tomate_main_tomate_mort():
	%GameOver.visible = true
	%ScoreFinal.text = str(round(Global.score))
	get_tree().paused = true
	$GameOver/AnimationPlayer.play("game_over")


func _on_button_pressed():
	var html_path = "res://Ajouts/TUTO TOMATHS/index.html"  # Le chemin relatif dans ton projet Godot	
	# Convertir en chemin absolu
	var absolute_path = ProjectSettings.globalize_path(html_path)
	# Ajouter 'file://' pour que ce soit un chemin compréhensible par le navigateur
	var file_url = "file://" + absolute_path
	# Ouvrir le fichier dans le navigateur
	OS.shell_open(file_url)



func _on_recommencer_pressed():
	get_tree().paused = false
	recommencer()
	
	

func recommencer():
	%GameOver.visible = false
	%Pause.visible = false
	%TomateMain.reset_vie()
	%EncadreReponse.resetText()
	
	if tabEnnemis.size() > 0:
		for i in tabEnnemis.keys():
			if is_instance_valid(tabEnnemis[i]) and tabEnnemis[i].has_method("die"):
				tabEnnemis[i].die()
			
	Global.score = 0
	%Score.text = "Score : " + str(round(Global.score))
	

func _on_sortir_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(MENU_PRINCIPAL)

func toggle_pause():
	%Pause.visible = !%Pause.visible
	get_tree().paused = !get_tree().paused

func _unhandled_input(event):
	if event.is_action_pressed("pause") and not %GameOver.visible:
		toggle_pause()


func _on_reprendre_pressed():
	toggle_pause()
