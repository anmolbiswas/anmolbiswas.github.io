extends HBoxContainer

@onready var segment_selectoor: OptionButton = $SegmentSelectoor
@onready var severity: SpinBox = $Severity
@onready var remove: Button = $Remove

signal remove_requested(row)

func _ready() -> void:
	segment_selectoor.add_item("RCA Proximal")
	segment_selectoor.add_item("RCA Mid")
	segment_selectoor.add_item("RCA Distal")
	segment_selectoor.add_item("PDA")
	segment_selectoor.add_item("PLB")
	segment_selectoor.add_item("Left Main")
	segment_selectoor.add_item("LAD Proximal")
	segment_selectoor.add_item("LAD Mid")
	segment_selectoor.add_item("LAD Apical")
	segment_selectoor.add_item("1st Diagonal")
	segment_selectoor.add_item("2nd Diagonal")
	segment_selectoor.add_item("LCx Proximal")
	segment_selectoor.add_item("LCx Mid")
	segment_selectoor.add_item("LCx Distal")
	segment_selectoor.add_item("Obtuse Marginal")
	
	remove.pressed.connect(_on_remove_pressed)
	



func _on_remove_pressed():
	remove_requested.emit(self)

func getData():
	return {
		"location" : segment_selectoor.get_item_text(segment_selectoor.selected),
		"severity" : severity.value
	}
