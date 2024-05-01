extends Control

@export var card_scene: PackedScene
@export var deck: Button
@onready var hand = $MarginContainer/Hand
@export var card_offset_x: float = 20.0

var tween: Tween

func _on_button_pressed() -> void:
	draw_cards(1)

func draw_cards(number: int) -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
	var from_pos: Vector2 = deck.global_position
	for i in range(number):
		var card = card_scene.instantiate()
		hand.add_child(card)
		card.global_position = from_pos
		
		var final_pos: Vector2 = -(card.size / 2.0) - Vector2(card_offset_x * (number - 1 - i), 0.0)
		final_pos.x += ((card_offset_x * (number-1)) / 2.0)
		
		tween.parallel().tween_property(card, "position", final_pos, 0.3 + (i * 0.075))


func _on_area_2d_area_entered(area: Area2D) -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	print("entered")
	var card: Button = area.get_parent()
	var final_pos: Vector2 = $Area2D.global_position - Vector2(- $Area2D.cards_inside * card.size.x, card.size.y / 2.0) - Vector2($Area2D/CollisionShape2D.shape.size.x/2.0, 0.0)
	
	tween.parallel().tween_property(card, "global_position", final_pos, 0.3 + 0.075)
	$Area2D.cards_inside += 1
	

