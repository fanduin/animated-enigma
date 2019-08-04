extends TileMap

onready var player = get_node("../Player")
onready var zombie = get_node("../Zombie")

onready var astar = AStar.new()
onready var half_cell_size = cell_size / 2
onready var traversable_tiles = get_used_cells()
onready var used_rect = get_used_rect()

func _ready():
	set_process(true)
	_add_traversable_tiles(traversable_tiles)
	_connect_traversable_tiles(traversable_tiles)

func _add_traversable_tiles(traversable_tiles):
	for tile in traversable_tiles:
		var id = _get_id_for_point(tile)
		astar.add_point(id, Vector3(tile.x, tile.y, 0))

func _connect_traversable_tiles(traversable_tiles):
	for tile in traversable_tiles:
		var id = _get_id_for_point(tile)
		for x in range(3):
			for y in range(3):
				var target = tile + Vector2(x - 1, y - 1)
				var target_id = _get_id_for_point(target)
				if tile == target or not astar.has_point(target_id):
					continue
				astar.connect_points(id, target_id, true)

func _get_id_for_point(point):
	var x = point.x - used_rect.position.x
	var y = point.y - used_rect.position.y
	
	return x + y * used_rect.size.x

func get_astar_path(start, end):
	var start_tile = world_to_map(start)
	var end_tile = world_to_map(end)

	var start_id = _get_id_for_point(start_tile)
	var end_id = _get_id_for_point(end_tile)

	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return null

	var path_map = astar.get_point_path(start_id, end_id)

	var path_world = []
	for point in path_map:
		var point_world = map_to_world(Vector2(point.x, point.y)) + half_cell_size
		path_world.append(point_world)
	return path_world