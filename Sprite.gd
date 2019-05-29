extends Sprite

export (PackedScene) var scene;

func _ready():
	pass

func _physics_process(delta):
	$Position2D.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		var dir = Vector2(1, 0).rotated($Position2D.global_rotation).normalized()
		var pos = $Position2D/Sprite.global_position
		var b = scene.instance()
		get_parent().add_child(b)
		b.start(pos, dir)
		
