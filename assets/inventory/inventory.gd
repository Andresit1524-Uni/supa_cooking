## Nodo que almacena el inventario del jugador, y ofrece operaciones básicas para su manejo
class_name Inventory extends Node


## Se emite cuando el inventario cambia sus elementos
signal inventory_updated(new_items: Array[FoodStack])


## Capacidad máxima del inventario
@export_range(0, 20) var max_capacity: int = 5


## Lista de elementos del inventario
var _items: Array[FoodStack]


## Añade los elementos dados y retorna la cuenta de cuantos fueron transferidos
func push(type: FoodData.Ingredients, value: int) -> int:
    # Buscar el stack que sea del mismo tipo y tenga espacio
    var stack_index := _items.find_custom(func(s: FoodStack):
        return s.is_full() and s.type == type
    )

    # Stack lleno o lista llena
    if stack_index == -1:
        push_warning("[Inventory] No hubo espacio")
        return 0

    # Añade y retorna
    var transfered := _items[stack_index].push(type, value)
    inventory_updated.emit(_items)
    return transfered

## Pide los elementos dados y retorna la cuenta de cuantos fueron transferidos
func pop(type: FoodData.Ingredients, value: int) -> int:
    # Busca el stack que sea del mismo tipo
    var stack_index := _items.find_custom(func(s: FoodStack):
        return s.type == type
    )

    # No hubo stack
    if stack_index == -1:
        push_warning("[Inventory] No hay elementoq que retirar")
        return 0

    # Pide y retorna
    var transfered := _items[stack_index].pop(value)
    inventory_updated.emit((_items))
    return transfered
