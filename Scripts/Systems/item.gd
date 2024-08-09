extends Node
class_name Item

@export var interaction_text: String = "Press [E] to interact"

func on_interact():
	# Função a ser sobrescrita pelos itens que herdam esta classe
	pass
