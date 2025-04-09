extends Control  

@onready var menu = preload("res://Characters_scenes/level.tscn")
@onready var animation_coulis = $Sprite2D/AnimationPlayer
@onready var start_btn = $StartBtn
@onready var exit_btn = $ExitBtn

func _ready():
	start_btn.connect("button_down", Callable(self, "_on_start_btn_button_down"))
	exit_btn.connect("button_down", Callable(self, "_on_exit_btn_button_down"))
	animation_coulis.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_start_btn_button_down() -> void:
	print("Start button clicked")
	animation_coulis.speed_scale = 1.2
	animation_coulis.play("coulis")

func _on_animation_finished(anim_name: String) -> void:
	print("Animation finished:", anim_name)
	if anim_name == "coulis":
		get_tree().change_scene_to_packed(menu)

func _on_exit_btn_button_down() -> void:
	print("Exit button clicked")
	get_tree().quit()
