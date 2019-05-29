extends "res://Tank.gd"

onready var parent = get_parent()
export (float) var turret_speed = 1.0
export (int) var detect_radius = 400

var target = null

func _ready():
	var circle = CircleShape2D.new()
	$DetectRadius/CollisionShape2D.shape = circle
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func control(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()
	else:
		pass

func _on_DetectRadius_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name == "Player":
		target = body


func _on_DetectRadius_body_shape_exited(body_id, body, body_shape, area_shape):
	if body == target:
		target = null

func _process(delta):
	if target:
		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1, 0).rotated($Turret.global_rotation)
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		
		
		
		