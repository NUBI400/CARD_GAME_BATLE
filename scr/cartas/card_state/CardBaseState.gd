extends CardState


func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	print("BASE")


func on_gui_input(event: InputEvent) -> void:
	
	if not card_ui.playable or card_ui.disabled:
		return
	
	if event.is_action_pressed("mouse1"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.SELECT)


