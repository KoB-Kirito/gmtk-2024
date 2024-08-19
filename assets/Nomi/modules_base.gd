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
	%GameManager.Tick_second.connect(exectueAtTick)


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func exectueAtTick() -> void:
	tickCount += 1
	if tickCount >= tickNeed:
		tickCount = 0
		$"../GameManager/Player_Manager_1".res_money += moneyPerDelivery
		$"../GameManager/Player_Manager_1".res_food_produced += foodPerDelivery
		$"../GameManager/Player_Manager_1".res_materials += matPerDelivery
	pass
