extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var dir = Input.get_axis("ui_left", "ui_right");
	
	position += Vector2(dir * delta * 600, 0);
