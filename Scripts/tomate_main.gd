extends CharacterBody2D

var vie = 10 #nombre de points de vie de la tomate

func _physics_process(delta):
	var liste_entites_touche = %Hurtbox.get_overlapping_bodies()



func _on_hurtbox_body_entered(body):
	vie-=1
	if(vie == 0):
		queue_free()
	if body.has_method("die"):
		body.die() # Replace with function body.
