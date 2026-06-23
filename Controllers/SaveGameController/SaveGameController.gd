extends Node

const SAVE_PATH = "user://save_game.tres"

var load_last_saved_stage: bool = false

func save_game(stage_index: int, player_lifes: int):
	var save_resource = SaveGame.new()
	save_resource.lifes = player_lifes
	save_resource.stage_index = stage_index
	ResourceSaver.save(save_resource, SAVE_PATH)

func load_game() -> SaveGame:
	if ResourceLoader.exists(SAVE_PATH):
		var saved_data: SaveGame = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
		return saved_data
		
	return null
	   
func has_saved_game():
	return ResourceLoader.exists(SAVE_PATH)


	
