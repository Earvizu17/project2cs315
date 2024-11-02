extends Node2D

@export var level_num = 0
@export var enemy_scene: PackedScene = preload("res://enemy.tscn") # Drag your enemy scene here in the Inspector
@export var enemy_spawn_area: Rect2 = Rect2(Vector2(250, 200), Vector2(500, 300))  # Default spawn area; adjust as needed

func _ready():
	$HUD.level(level_num)
	set_gems_label()
	for gem in $Gems.get_children():
		gem.gem_collected.connect(_on_gem_collected)

func _on_gem_collected():
	set_gems_label()

func set_gems_label():
	$HUD.gems(Global.gems_collected)

func _on_door_player_entered(level):
	get_tree().change_scene_to_file(level)

func _input(event):
	if event.is_action_pressed("reset_level"):
		get_tree().reload_current_scene.call_deferred()
		Global.gems_collected = 0
		set_gems_label()
