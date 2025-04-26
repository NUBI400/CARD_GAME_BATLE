extends Sprite2D

func _process(delta):
	texture = get_parent().get_node("SubViewport").get_texture()
