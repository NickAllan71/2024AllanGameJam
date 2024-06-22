extends StaticBody2D

var dir = Vector2(1, 1).normalized();
var speed = 600.0;

func colliding_pos():
	var pos = Vector2(position);
	pos.x += sign(dir.x) * 32;
	pos.y += sign(dir.y) * 32;
	return pos;

func _physics_process(delta):
	 
	var col_pos = colliding_pos();
	if (col_pos.x < 0 and dir.x < 0) or (col_pos.x > 1080 and dir.x > 0):
		bounce_x();
		
	if col_pos.y < 0 and dir.y < 0:
		bounce_y();

	var vel = dir * speed * delta;
		
	if position.y > 1738:
		position += vel;
		return;
		
	var col = move_and_collide(vel);
	if col != null:
		var col_norm = col.get_normal();
		var bounced_on_y = false;
		if (col_norm.y < 0 and dir.y > 0) or (col_norm.y > 0 and dir.y < 0):
			bounce_y();
			bounced_on_y = true;
			
		if (col_norm.x < 0 and dir.x > 0) or (col_norm.x > 0 and dir.x < 0):
			bounce_x();
		
		print(col_norm)
			
		if col.get_collider() is Paddle and bounced_on_y:
			var paddle = col.get_collider() as Paddle;
			var offset = position.x - paddle.position.x;
			var angle = ((float(offset) / 300) * (PI / 2));
			dir = Vector2(0, dir.y).normalized().rotated(angle * -sign(dir.y));
			
	
		if col.get_collider() is Block:
			var block = col.get_collider() as Block;
			block.die();
	
func bounce_x():
	dir.x *= -1;
	
func bounce_y():
	dir.y *= -1;
