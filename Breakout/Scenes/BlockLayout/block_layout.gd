@tool
extends Node2D

@export var rows: int:
	set(val):
		rows = max(val, 0);
		position_blocks();
@export var cols: int:
	set(val):
		cols = max(val, 0);
		position_blocks();

@export var row_gap: int:
	set(val):
		row_gap = max(val, 0);
		position_blocks();
@export var col_gap: int:
	set(val):
		col_gap = max(val, 0);
		position_blocks();

const block_scene = preload("res://Scenes/Block/block.tscn");
const half_block_scene = preload("res://Scenes/Block/half_block.tscn");

var prev_rows = 0;
var prev_cols = 0;

var blocks = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	position_blocks();
	
func place_new_block(row, col, block_type, width, height):
	var new_block = block_type.instantiate();
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
		var cols_in_row = cols;
		if row % 2 == 1:
			place_new_block(row, 0, half_block_scene, 96, 64);
			cols_in_row;
			
		for col in cols_in_row:
			place_new_block(row, col + (row % 2), block_scene, 192, 64);
			
		if row % 2 == 0:
			place_new_block(row, cols, half_block_scene, 96, 64);
