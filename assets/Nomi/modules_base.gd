extends Node
class_name modules_base

var module_name : String = "base"

var module_size : Vector3

var workers_cur : int = 0
@export var workerS_max : int = 10

@export var tickNeed : int = 5
var tickCount : int = 0

var foodPerDelivery : int = 0
@export var moneyPerDelivery : int = 0
@export var matPerDelivery : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.2).timeout
	Globals.gameManager.Tick_second.connect(exectueAtTick)


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func exectueAtTick() -> void:
	tickCount += 1
	if tickCount >= tickNeed:
		tickCount = 0
		Globals.playerManager.res_money += moneyPerDelivery
		Globals.playerManager.res_food_produced += foodPerDelivery
		Globals.playerManager.res_materials += matPerDelivery
	pass
