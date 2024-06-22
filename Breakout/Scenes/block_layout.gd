@tool
extends Node2D

@export var rows: int:
	set(val):
		rows = val;
		position_blocks();
@export var cols: int:
	set(val):
		cols = val;
		position_blocks();

@export var row_gap: int:
	set(val):
		row_gap = val;
		position_blocks();
@export var col_gap: int:
	set(val):
		col_gap = val;
		position_blocks();

const block_scene = preload("res://Scenes/Block/block.tscn");

var prev_rows = 0;
var prev_cols = 0;

var blocks = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	position_blocks();
	
func place_new_block(row, col):
	var new_block = block_scene.instantiate();
	add_child(new_block);
	blocks.append(new_block);
	new_block.position.y = 32 + (col * (64 + col_gap));
	if col % 2 == 0:
		new_block.position.x = 96 + (row * (192 + row_gap));
	else:
		new_block.position.x = 96 + (row_gap + 96 + row * (192 + row_gap));

func position_blocks():
	
	for block in blocks:
		block.queue_free();
		
	blocks = []
		
	for row in rows:
		var cols_this_row = cols / 2;
		if cols % 2 == 0:
			cols_this_row -= (row % 2);
		for col in cols_this_row:
			place_new_block(col, row);
