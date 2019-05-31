extends KinematicBody2D

signal shoot
signal health_changed
signal death

export (PackedScene) var Bullet
export (int) var max_speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var max_health


var velocity = Vector2()
var can_shoot = true
var alive = true
var health = 0 

func _ready():
	health = max_health
	emit_signal("health_changed", health * 100 / max_health)
	$GunTimer.wait_time = gun_cooldown
	
func take_damage(amount:int):
	health -= amount
	emit_signal("health_changed", health * 100 / max_health)
	if health <= 0:
		explode()
		
func explode():
	$Sprite.hide()
	$Turret.hide()
	$Explosion.show()
	$Explosion.play()
	
	
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
		emit_signal("shoot", Bullet, v, dir)
		$AnimationPlayer.play("muzzle_flash")

func _on_GunTimer_timeout():
	can_shoot = true


func _on_Explosion_animation_finished():
	queue_free()
