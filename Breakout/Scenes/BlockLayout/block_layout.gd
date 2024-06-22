@tool
extends Node2D

@export var rows: int = 1:
	set(val):
		rows = max(val, 1);
		position_blocks();
@export var cols: int = 1:
	set(val):
		cols = max(val, 1);
		position_blocks();

@export var row_gap: int = 0:
	set(val):
		row_gap = max(val, 0);
		position_blocks();
@export var col_gap: int = 0:
	set(val):
		col_gap = max(val, 0);
		position_blocks();

const block_scene = preload("res://Scenes/Block/block.tscn");
const half_block_scene = preload("res://Scenes/Block/half_block.tscn");

var blocks = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	position_blocks();
	
func place_new_block(row, col, block_type, width, height):
	var new_block = block_type.instantiate();
	if width == 96:
		var anim = new_block.get_child(1) as AnimatedSprite2D;
		if col == 0:
			anim.animation = "left"
		else:
			anim.animation = "right"
	add_child(new_block);
	blocks.append(new_block);
	new_block.position.y = (height / 2) + (row * (64 + col_gap));
	if row % 2 == 0 || col == 0:
		new_block.position.x = (width / 2) + (col * (192 + row_gap));
	else:
		new_block.position.x = (width / 2) + row_gap + 96 + ((col - 1) * (192 + row_gap));

func position_blocks():
	
	for block in blocks:
		block.queue_free();
		
	blocks = []
		
	for row in rows:
		var cols_in_row = cols - 1;
		if row % 2 == 1:
			place_new_block(row, 0, half_block_scene, 96, 64);
			cols_in_row;
			
		for col in cols_in_row:
			place_new_block(row, col + (row % 2), block_scene, 192, 64);
			
		if row % 2 == 0:
			place_new_block(row, cols - 1, half_block_scene, 96, 64);
