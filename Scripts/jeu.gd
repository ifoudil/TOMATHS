extends Node2D

const OBJET_ENNEMI = preload("res://Characters_scenes/ennemi.tscn")
const BULLET_OBJECT = preload("res://Characters_scenes/balle.tscn")

func _physics_process(delta):
	var reponse = %EncadreReponse.getText()

	var liste_ennemis = %ZoneDeTir.get_overlapping_bodies()
	for i in range(len(liste_ennemis)-1):
		if(liste_ennemis[i].has_method("die") && liste_ennemis[i].getReponse()==reponse):
			tirer(liste_ennemis[i])
			%EncadreReponse.resetText()

func apparaitre_ennemi() : 
	var nouvel_ennemi = OBJET_ENNEMI.instantiate()
	%CheminSpawn.progress_ratio= randf()
	nouvel_ennemi.global_position = %CheminSpawn.global_position
	nouvel_ennemi.setQuestion()
	add_child(nouvel_ennemi)
	return nouvel_ennemi
	
func tirer(nouvel_ennemi):
	var new_bullet = BULLET_OBJECT.instantiate()
	new_bullet.global_position = %TomateMain.global_position
	new_bullet.look_at(nouvel_ennemi.global_position)
	add_child(new_bullet)
	


func _on_timer_timeout():
	apparaitre_ennemi()

	
