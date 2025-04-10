extends Control

signal play

# Sprites d'animation pour chaque zone
@onready var sprite_binaire: AnimatedSprite2D = $AnimatedSprite2D6
@onready var sprite_binaire_avancee: AnimatedSprite2D = $AnimatedSprite2D7
@onready var sprite_dlzero: AnimatedSprite2D = $AnimatedSprite2D8

# Zones interactives (nouveau nom)
@onready var area_binaire = $Area2DBinaire
@onready var area_binaire_avancee = $Area2DBinaireAvancee
@onready var area_dlzero = $Area2DDLZero

# Précharge des scènes à charger
var scene_binaire = preload("res://jeu.tscn")
var scene_binaire_avancee = preload("res://jeu.tscn")
var scene_dlzero = preload("res://jeu.tscn")

# Suivi de la présence du joueur
var player_in_binaire = false
var player_in_binaire_avancee = false
var player_in_dlzero = false

# Contrôle de la transition
var target_scene = null
var target_sprite: AnimatedSprite2D = null
var animation_played = false

func _ready():
	# Connexions pour chaque zone
	area_binaire.body_entered.connect(_on_entered_binaire)
	area_binaire.body_exited.connect(_on_exited_binaire)

	area_binaire_avancee.body_entered.connect(_on_entered_binaire_avancee)
	area_binaire_avancee.body_exited.connect(_on_exited_binaire_avancee)

	area_dlzero.body_entered.connect(_on_entered_dlzero)
	area_dlzero.body_exited.connect(_on_exited_dlzero)

#Fonctions d’entrée/sortie pour chaque zone
func _on_entered_binaire(body):
	if body.name == "Player":
		player_in_binaire = true

func _on_exited_binaire(body):
	if body.name == "Player":
		player_in_binaire = false

func _on_entered_binaire_avancee(body):
	if body.name == "Player":
		player_in_binaire_avancee = true

func _on_exited_binaire_avancee(body):
	if body.name == "Player":
		player_in_binaire_avancee = false

func _on_entered_dlzero(body):
	if body.name == "Player":
		player_in_dlzero = true

func _on_exited_dlzero(body):
	if body.name == "Player":
		player_in_dlzero = false

#Vérifie si joueur appui sur entree lorsque contacte avec tomate
func _process(delta):
	if Input.is_action_just_pressed("enter") and not animation_played:
		if player_in_binaire:
			Global.questionsChemin="res://Questions/Superieur/binaireSimple.txt"
			_start_transition(scene_binaire, sprite_binaire)
		elif player_in_binaire_avancee:
			Global.questionsChemin="res://Questions/Superieur/binaire.txt"
			_start_transition(scene_binaire_avancee, sprite_binaire_avancee)
		elif player_in_dlzero:
			Global.questionsChemin="res://Questions/Superieur/binaire.txt"
			_start_transition(scene_dlzero, sprite_dlzero)
			
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

#Animation + Changement de scène
func _start_transition(scene, sprite):
	animation_played = true
	target_scene = scene
	target_sprite = sprite
	target_sprite.play("splash")
	play.emit()

	# Connecte l'événement de fin d'animation s’il n’est pas déjà connecté
	if not target_sprite.is_connected("animation_finished", Callable(self, "_on_animation_finished")):
		target_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

# Quand l'animation est finie, on change de scène
func _on_animation_finished():
	get_tree().change_scene_to_packed(target_scene)


# === Tout ce qui est en rapport avec le menu pause  ===

func toggle_pause():
	%Pause.visible = !%Pause.visible
	get_tree().paused = !get_tree().paused
	
func _on_sortir_pressed():
	get_tree().paused = false
	var menu_principal = preload("res://Characters_scenes/level.tscn")
	get_tree().change_scene_to_packed(menu_principal)

func _on_reprendre_pressed():
	toggle_pause()

func _on_tuto_pressed():
	var html_path = "res://Ajouts/TUTO TOMATHS/index.html"  # Le chemin relatif dans ton projet Godot	
	# Convertir en chemin absolu
	var absolute_path = ProjectSettings.globalize_path(html_path)
	# Ajouter 'file://' pour que ce soit un chemin compréhensible par le navigateur
	var file_url = "file://" + absolute_path
	# Ouvrir le fichier dans le navigateur
	OS.shell_open(file_url)
