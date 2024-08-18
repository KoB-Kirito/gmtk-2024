class_name UnitButton
extends TextureButton


func setup(data: UnitData) -> void:
	#TODO: name
	tooltip_text = data.name + "\n" + data.description
	texture_normal = data.texture
	texture_hover = data.texture_hover
	texture_disabled = data.texture_disabled
