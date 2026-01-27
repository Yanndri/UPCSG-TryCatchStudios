extends Node3D

func reduce_food():
	for child in %Food.get_children():
		if child is MeshInstance3D:
			if child.visible:
				child.visible = false
				print("child: ", child)
				break

func increase_food():
	for child in %Food.get_children():
		if child is MeshInstance3D:
			if not child.visible:
				child.visible = true
				print("child: ", child)
				break

func reduce_water():
	for child in %Water.get_children():
		if child is MeshInstance3D:
			if child.visible:
				child.visible = false
				print("child: ", child)
				break

func increase_water():
	for child in %Water.get_children():
		if child is MeshInstance3D:
			if not child.visible:
				child.visible = true
				print("child: ", child)
				break
