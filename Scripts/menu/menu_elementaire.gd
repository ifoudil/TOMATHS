extends Control

signal play

# Sprites d’animation pour chaque zone
@onready var sprite_addition: AnimatedSprite2D = $AnimatedSprite2D4
@onready var sprite_soustraction: AnimatedSprite2D = $AnimatedSprite2D5
@onready var sprite_multiplication: AnimatedSprite2D = $AnimatedSprite2D6

# Zones interactives
@onready var area_addition = $Area2DAddi
@onready var area_soustraction = $Area2DSous
@onready var area_multiplication = $Area2DMult

# Précharge des scènes à charger
var scene_addition = preload("res://test.tscn")
var scene_soustraction = preload("res://test.tscn")
var scene_multiplication = preload("res://test.tscn")

# Suivi de la présence du joueur
var player_in_addition = false
var player_in_soustraction = false
var player_in_multiplication = false

# Contrôle de la transition
var target_scene = null
var target_sprite: AnimatedSprite2D = null
var animation_played = false

func _ready():
	# Connexions pour chaque zone
	area_addition.body_entered.connect(_on_entered_addition)
	area_addition.body_exited.connect(_on_exited_addition)

	area_soustraction.body_entered.connect(_on_entered_soustraction)
	area_soustraction.body_exited.connect(_on_exited_soustraction)

	area_multiplication.body_entered.connect(_on_entered_multiplication)
	area_multiplication.body_exited.connect(_on_exited_multiplication)

# Fonctions d’entrée/sortie
func _on_entered_addition(body):
	if body.name == "Player":
		player_in_addition = true

func _on_exited_addition(body):
	if body.name == "Player":
		player_in_addition = false

func _on_entered_soustraction(body):
	if body.name == "Player":
		player_in_soustraction = true

func _on_exited_soustraction(body):
	if body.name == "Player":
		player_in_soustraction = false

func _on_entered_multiplication(body):
	if body.name == "Player":
		player_in_multiplication = true

func _on_exited_multiplication(body):
	if body.name == "Player":
		player_in_multiplication = false

# Gestion des entrées
func _process(delta):
	if Input.is_action_just_pressed("enter") and not animation_played:
		if player_in_addition:
			_start_transition(scene_addition, sprite_addition)
		elif player_in_soustraction:
			_start_transition(scene_soustraction, sprite_soustraction)
		elif player_in_multiplication:
			_start_transition(scene_multiplication, sprite_multiplication)

# Lance animation + scène
func _start_transition(scene, sprite):
	animation_played = true
	target_scene = scene
	target_sprite = sprite
	target_sprite.play("splash")
	play.emit()

	if not target_sprite.is_connected("animation_finished", Callable(self, "_on_animation_finished")):
		target_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

# Changement de scène une fois l'animation finie
func _on_animation_finished():
	get_tree().change_scene_to_packed(target_scene)
