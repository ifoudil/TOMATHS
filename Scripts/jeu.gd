extends Node2D

const OBJET_ENNEMI = preload("res://Characters_scenes/ennemi.tscn")


func apparaitre_ennemi() : 
	var nouvel_ennemi = OBJET_ENNEMI.instantiate()
	%CheminSpawn.progress_ratio= randf()
	nouvel_ennemi.global_position = %CheminSpawn.global_position
	add_child(nouvel_ennemi)
	


func _on_timer_timeout():
	apparaitre_ennemi()
