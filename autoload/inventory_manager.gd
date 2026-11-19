## Nodo que almacena el inventario del jugador, y ofrece operaciones básicas para su manejo
class_name Inventory extends Node


## Subclase para gestionar cada stack individual de items
class Stack:
	const MAX_SIZE = 10

	var type := FoodData.Ingredients.NONE
	var count: int = 0

	func _init(new_type: FoodData.Ingredients, new_count: int) -> void:
		type = new_type
		count = new_count

	func is_full() -> bool:
		return count >= MAX_SIZE

	## Inserta la cantidad dada y retorna la cantidad insertada con éxito
	func push(new_type: FoodData.Ingredients, amount: int) -> int:
		if type != FoodData.Ingredients.NONE and type != new_type:
			return 0

		if type == FoodData.Ingredients.NONE:
			type = new_type

		var space := MAX_SIZE - count
		var added := mini(amount, space)
		count += added
		return added

	## Elimina la cantidad dada y retorna la cantidad eliminada con éxito
	func pop(amount: int) -> int:
		if count <= 0:
			return 0

		var removed := mini(amount, count)
		count -= removed
		if count == 0:
			type = FoodData.Ingredients.NONE

		return removed


## Capacidad máxima del inventario (número de slots/stacks)
var max_capacity: int


## Lista de stacks del inventario
var items: Array[Stack] = []


## Inicializa los stacks de los inventarios
func _init_stacks(tilebar: TileBar) -> void:
	if not items.is_empty():
		return
	max_capacity = tilebar.capacity
	for i in max_capacity:
		items.append(Stack.new(FoodData.Ingredients.NONE, 0))


## Añade los elementos dados y retorna la cuenta de cuántos fueron transferidos
func push(type: FoodData.Ingredients, amount: int, tilebar: TileBar) -> int:
	var remaining := amount

	# Intentar stackear en stacks existentes del mismo tipo
	for stack in items:
		if remaining <= 0: break
		if stack.type == type and not stack.is_full():
			remaining -= stack.push(type, remaining)

	# Si sobra, colocar en stacks vacíos
	for stack in items:
		if remaining <= 0: break
		if stack.type == FoodData.Ingredients.NONE:
			remaining -= stack.push(type, remaining)

	var transferred := amount - remaining
	if transferred > 0:
		tilebar._update_bar(items)
	else:
		push_warning("[Inventory] No hubo espacio suficiente")

	return transferred


## Retira los elementos dados y retorna la cuenta de cuántos fueron transferidos
func pop(type: FoodData.Ingredients, amount: int, tilebar: TileBar) -> int:
	var remaining := amount

	# Retirar en orden inverso (LIFO)
	for i in range(items.size() - 1, -1, -1):
		if remaining <= 0: break

		var stack := items[i]
		if stack.type == type:
			remaining -= stack.pop(remaining)

	var transferred := amount - remaining
	if transferred > 0:
		tilebar._update_bar(items)
	else:
		push_warning("[Inventory] No hay elementos que retirar")

	return transferred
