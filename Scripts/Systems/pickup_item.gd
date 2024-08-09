extends Item

@export var item_name: String = "Generic Item"

func on_interact():
	print("Picked up: %s" % item_name)
	queue_free() # Remove o item após a interação, por exemplo
