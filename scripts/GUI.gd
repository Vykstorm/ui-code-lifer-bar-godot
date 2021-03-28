extends MarginContainer

onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $Bars/LifeBar/TextureProgress
onready var tween = $Tween
onready var player = $"../Characters/Player"
onready var enemy = $"../Characters/Enemy"


var animated_health

func _ready():
	animated_health = player.max_health
	bar.max_value = player.max_health

func _process(_delta):
	bar.value = animated_health
	number_label.text = str(floor(animated_health))

func update_health(new_value):
	number_label.text = str(new_value)
	tween.interpolate_property(self, "animated_health", bar.value, new_value, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if not tween.is_active():
		tween.start()


func _on_player_health_changed(health):
	update_health(health)


func _on_Player_died():
	tween.interpolate_property(self, "modulate:a", 1, 0, 1)
	if not tween.is_active():
		tween.start()
