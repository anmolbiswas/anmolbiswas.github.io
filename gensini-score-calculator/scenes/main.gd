extends Control

@onready var add_button: Button = $MarginContainer/VBoxContainer/AddButton
@onready var calc_button: Button = $MarginContainer/VBoxContainer/CalcButton
@onready var result: Label = $MarginContainer/VBoxContainer/Result
@onready var lesion_container: VBoxContainer = $MarginContainer/VBoxContainer/LesionContainer

var lesion_row_scene = preload("res://scenes/LesionRow.tscn")

var multipliers = {
	"RCA Proximal" : 1,
	"RCA Mid" : 1,
	"RCA Distal" : 1,
	"PDA" : 1,
	"PLB" : 0.5,
	"Left Main" : 5,
	"LAD Proximal" : 2.5,
	"LAD Mid" : 1.5,
	"LAD Apical" : 1,
	"1st Diagonal" : 1,
	"2nd Diagonal" : 0.5,
	"LCx Proximal" : 2.5,
	"LCx Mid" : 1,
	"LCx Distal" : 1,
	"Obtuse Marginal" : 1
}

func _ready() -> void:
	add_button.pressed.connect(add_lesion_row)
	calc_button.pressed.connect(calculate_score)
	add_lesion_row()
	
func add_lesion_row() -> void:
	var row = lesion_row_scene.instantiate()
	lesion_container.add_child(row)
	row.remove_requested.connect(_on_row_remove_requested)

func _on_row_remove_requested(row) -> void:
	row.queue_free()

func get_severity_score(percent):
	if percent <= 25:
		return 1
	elif percent <= 50:
		return 2
	elif  percent <= 75:
		return 4
	elif  percent <= 90:
		return 8
	elif  percent <= 99:
		return 16
	else:
		return 32

func calculate_score():
	var total = 0.0
	for row in lesion_container.get_children():
		var data = row.getData()
		var score = get_severity_score(data["severity"])
		var multiplier = multipliers.get(data["location"],1.0)
		total+= score*multiplier
	result.text = "Total Gesini Score: %d" %total
