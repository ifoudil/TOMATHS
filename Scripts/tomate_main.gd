extends CharacterBody2D



func _physics_process(delta):
	var liste_entites_touche = %Hurtbox.get_overlapping_bodies()
		if liste_entites_touche.size()!=0:
			#emit kill signal
