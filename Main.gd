extends Node2D

func _ready():
	Input.set_custom_mouse_cursor(load("res://assets/UI/crossair_black.png"), Input.CURSOR_ARROW, Vector2(16,16))
	set_camera_limits()

func set_camera_limits():
	var map_limits = $Ground.get_used_rect()
	var map_cellsize = $Ground.cell_size
	
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

func _on_tank_shoot(bullet: PackedScene, pos, dir):
	var b:Bullet = bullet.instance()
	self.add_child(b)	
	b.start(pos, dir)


func _on_Player_health_changed(amount):
	$HUD.update_healthbar(amount)
