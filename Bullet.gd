extends Area2D
class_name Bullet

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

func start(_position, _direction: Vector2):	
	self.position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed

func _process(delta):
	position += velocity * delta
	
func explode():
	velocity = Vector2()
	$Sprite.hide()
	$Explosion.show()
	$Explosion.play("smoke")

func _on_Bullet_body_shape_entered(body_id, body, body_shape, area_shape):
	explode()
	if body.has_method("take_damage"):
		body.take_damage(damage)

func _on_Lifetime_timeout():
	explode()


func _on_Explosion_animation_finished():
	queue_free()
