extends StaticBody2D
class_name Paddle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var dir = Input.get_axis("ui_left", "ui_right");
	
	position += Vector2(dir * delta * 600, 0);
	position.x = clamp(position.x, 192, 888);
