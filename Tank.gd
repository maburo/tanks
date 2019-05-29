extends KinematicBody2D

signal shoot
signal health_changed
signal death

export (PackedScene) var Bullet
export (int) var speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var health

var velocity = Vector2()
var can_shoot = true
var alive = true

func _ready():
	$GunTimer.wait_time = gun_cooldown
	
func control(delta):
	pass
	
func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)
	
func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		
		var dir = Vector2(1, 0).rotated($Turret.global_rotation).normalized()
		var v = $Turret/Muzzle.global_position
		print("Tank ", v)
		emit_signal("shoot", Bullet, v, dir)

func _on_GunTimer_timeout():
	can_shoot = true
