extends Node2D

const OBJET_ENNEMI = preload("res://Characters_scenes/ennemi.tscn")
const BULLET_OBJECT = preload("res://Characters_scenes/balle.tscn")


var score = 0

func _physics_process(delta):
	var reponse = %EncadreReponse.getText()

	var liste_ennemis = %ZoneDeTir.get_overlapping_bodies()
	for i in range(len(liste_ennemis)-1):
		if(liste_ennemis[i].has_method("die") && liste_ennemis[i].getReponse()==reponse):
			tirer(liste_ennemis[i])
			%EncadreReponse.resetText()
	score+=0.03 #fait augmenter petit à petit le score au fil du temps
	%Score.text = "Score : " + str(round(score))

func apparaitre_ennemi() : 
	var nouvel_ennemi = OBJET_ENNEMI.instantiate()
	nouvel_ennemi.connect("mort",_on_ennemi_mort)
	%CheminSpawn.progress_ratio= randf()
	nouvel_ennemi.global_position = %CheminSpawn.global_position
	add_child(nouvel_ennemi)
	return nouvel_ennemi


func _on_ennemi_mort():
	score+=100

func tirer(nouvel_ennemi):
	var new_bullet = BULLET_OBJECT.instantiate()
	new_bullet.global_position = %TomateMain.global_position
	new_bullet.look_at(nouvel_ennemi.global_position)
	add_child(new_bullet)
	




func _on_timer_timeout():
	apparaitre_ennemi()


func _on_tomate_main_tomate_mort():
	%GameOver.visible = true
	%ScoreFinal.text = str(round(score))
	$GameOver/AnimationPlayer.play("game_over")
	await get_tree().create_timer(1.0).timeout 
	get_tree().paused = true
