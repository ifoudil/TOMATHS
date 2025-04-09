extends Node2D

@export var target_scene = "res://menu_notion.tscn"
signal porte

@onready var sprite = $AnimatedSprite2D
var player_in_area = false
var animation_played = false

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":  
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("enter") and not animation_played:
		animation_played = true
		sprite.play("door_open")
		porte.emit()
		sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_animation_finished():
	sprite.play_backwards("door_open")
	sprite.stop()
	animation_played = false
	var current_scene_path = get_tree().current_scene.scene_file_path
	# Gestion des scènes de retour
	if current_scene_path.ends_with("menu_lycee.tscn"):
		# Retour vers la scène précédente (menu_lycee)
		if Global.previous_scene != "":
			get_tree().change_scene_to_file(Global.previous_scene)
		else:
			get_tree().change_scene_to_file("res://menu_lycee.tscn")
	elif current_scene_path.ends_with("menu_elementaire.tscn"):
		# Retour vers la scène menu_elementaire
		if Global.previous_scene != "":
			get_tree().change_scene_to_file(Global.previous_scene)
		else:
			get_tree().change_scene_to_file("res://menu_elementaire.tscn")
	elif current_scene_path.ends_with("menu_college.tscn"):
		# Retour vers la scène menu_college
		if Global.previous_scene != "":
			get_tree().change_scene_to_file(Global.previous_scene)
		else:
			get_tree().change_scene_to_file("res://menu_college.tscn")
	elif current_scene_path.ends_with("menu_superieur.tscn"):
		# Retour vers la scène menu_superieur
		if Global.previous_scene != "":
			get_tree().change_scene_to_file(Global.previous_scene)
		else:
			get_tree().change_scene_to_file("res://menu_superieur.tscn")
	else:
		# Enregistrement et changement classique
		Global.previous_scene = current_scene_path
		get_tree().change_scene_to_file(target_scene)

func tuto_game():
	var html_path = "res://Ajouts/index.html" 
	var absolute_path = ProjectSettings.globalize_path(html_path)
	var file_url = "file://" + absolute_path
	OS.shell_open(file_url)

func _on_porte():
	tuto_game()
	
