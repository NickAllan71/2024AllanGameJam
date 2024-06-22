class_name Block
extends StaticBody2D

func die():
	call_deferred("queue_free");
