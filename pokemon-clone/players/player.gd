extends Area2D

@onready var ray = $RayCast2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var TILE_SIZE = 16

var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
			}

var walk_anim = {
	"move_right": "walk_right",
	"move_left": "walk_left",
	"move_up": "walk_up",
	"move_down": "walk_down"
	}
	
var idle_anim = {
	"move_right": "idle_right",
	"move_left": "idle_left",
	"move_up": "idle_up",
	"move_down": "idle_down"
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#position = position.snapped(Vector2.ONE * TILE_SIZE)
	#position += Vector2.ONE * TILE_SIZE/2

func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * TILE_SIZE/2
	ray.force_raycast_update()
	if !ray.is_colliding():
		var new_position = position + (inputs[dir] * TILE_SIZE)
		var tween := create_tween()
		tween.tween_property(self, "position", new_position, 0.4)
		$AnimationPlayer.play(walk_anim[dir])
