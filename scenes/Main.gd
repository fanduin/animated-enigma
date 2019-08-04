extends Node2D

onready var tilemap = $Navigation2D/TileMap

enum TILES{
	FLOWER = 0,
	STONE = 1,
	TREE = 2,
	FENCE_TL = 3,
	FENCE_L = 4,
	FENCE_BL = 5,
	FENCE_T = 6,
	GRASS = 7, 
	ENCE_B = 8,
	FENCE_TR = 9,
	FENCE_R = 10,
	FENCE_BR = 11}

export (int) var world_width : = 100
export (int) var world_height : = 100

func _ready():
	randomize()
	generate()

func generate():
	var tile_type = TILES.GRASS
	
	for y in range(world_height):
		for x in range(world_width):
			tilemap.set_cell(x, y, tile_type)