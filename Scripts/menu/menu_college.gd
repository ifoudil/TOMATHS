extends Control

signal play

# Les sprites d'animation (1 par zone)
@onready var sprite_mult: AnimatedSprite2D = $AnimatedSprite2D5
@onready var sprite_nbrelatif: AnimatedSprite2D = $AnimatedSprite2D6
@onready var sprite_equa: AnimatedSprite2D = $AnimatedSprite2D7
@onready var sprite_carre: AnimatedSprite2D = $AnimatedSprite2D8  

# Les zones d'interaction
@onready var area_mult = $Area2DMult
@onready var area_nbrelatif = $Area2DNbRelatif
@onready var area_equa = $Area2DEqua
@onready var area_carre = $Area2DCarre

# Préchargement des scènes associées
var scene_mult = preload("res://test.tscn")
var scene_nbrelatif = preload("res://test.tscn")
var scene_equa = preload("res://test.tscn")
var scene_carre = preload("res://test.tscn")

# États joueur dans chaque zone
var player_in_mult = false
var player_in_nbrelatif = false
var player_in_equa = false
var player_in_carre = false

# Pour contrôler la transition
var target_scene = null
var target_sprite: AnimatedSprite2D = null
var animation_played = false

func _ready():
	# Connexions pour chaque Area2D
	area_mult.body_entered.connect(_on_entered_mult)
	area_mult.body_exited.connect(_on_exited_mult)

	area_nbrelatif.body_entered.connect(_on_entered_nbrelatif)
	area_nbrelatif.body_exited.connect(_on_exited_nbrelatif)

	area_equa.body_entered.connect(_on_entered_equa)
	area_equa.body_exited.connect(_on_exited_equa)

	area_carre.body_entered.connect(_on_entered_carre)
	area_carre.body_exited.connect(_on_exited_carre)

# === Fonctions d'entrée/sortie ===
func _on_entered_mult(body):
	if body.name == "Player":
		player_in_mult = true

func _on_exited_mult(body):
	if body.name == "Player":
		player_in_mult = false

func _on_entered_nbrelatif(body):
	if body.name == "Player":
		player_in_nbrelatif = true

func _on_exited_nbrelatif(body):
	if body.name == "Player":
		player_in_nbrelatif = false

func _on_entered_equa(body):
	if body.name == "Player":
		player_in_equa = true

func _on_exited_equa(body):
	if body.name == "Player":
		player_in_equa = false

func _on_entered_carre(body):
	if body.name == "Player":
		player_in_carre = true

func _on_exited_carre(body):
	if body.name == "Player":
		player_in_carre = false

# === Gestion des entrées ===
func _process(delta):
	if Input.is_action_just_pressed("enter") and not animation_played:
		if player_in_mult:
			_start_transition(scene_mult, sprite_mult)
		elif player_in_nbrelatif:
			_start_transition(scene_nbrelatif, sprite_nbrelatif)
		elif player_in_equa:
			_start_transition(scene_equa, sprite_equa)
		elif player_in_carre:
			_start_transition(scene_carre, sprite_carre)

# === Démarrage animation + changement de scène ===
func _start_transition(scene, sprite):
	animation_played = true
	target_scene = scene
	target_sprite = sprite
	target_sprite.play("splash")
	play.emit()

	if not target_sprite.is_connected("animation_finished", Callable(self, "_on_animation_finished")):
		target_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

# === Quand l'animation est finie ===
func _on_animation_finished():
	get_tree().change_scene_to_packed(target_scene)
