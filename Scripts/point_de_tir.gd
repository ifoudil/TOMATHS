extends Area2D

# je n'arrive pas a le faire fonctionner mais idéalement ça replacerait la ZoneDeTir area2D au milieu de node jeu
func _physics_process(delta: float) -> void:
	var things_in_range = get_overlapping_bodies()
	if things_in_range.size() > 0:
		var target = things_in_range[0] #target le premier truc de la liste
		look_at(target.global_position)

func shoot():
	const BULLET_OBJECT = preload("res://Characters_scenes/balle.tscn")
	var new_bullet = BULLET_OBJECT.instantiate()
	new_bullet.global_position = global_position
	new_bullet.global_rotation = global_rotation
	add_child(new_bullet)





func _on_timer_timeout():
	pass # Replace with function body.
