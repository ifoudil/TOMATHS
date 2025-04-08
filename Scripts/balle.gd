extends Area2D

var travelled_distance =0


func _physics_process(delta: float) -> void:
	const BULLET_SPEED = 1000
	const MAX_RANGE = 2500
	
	var direction = Vector2.RIGHT.rotated(rotation)
	
	var angle = direction.angle()
	rotation = angle
	
	position += direction * BULLET_SPEED * delta #makes the thing time dependant instead of frame dependant, didnt have to do it for characters cuz move and slide did it for us
	travelled_distance+= BULLET_SPEED * delta
	if(travelled_distance>MAX_RANGE):
		queue_free()





func _on_body_entered(body):
	if(body.has_method("die")):
		queue_free()
		body.die()
