## Almacena una pila de objetos y ofrece sus métodos esenciales de manipulación. No confundir con la
## estructura de datos del mismo nombre.
class_name FoodStack


## Tamaño máximo
const MAX_SIZE = 10


## Contenido del stack
var type := FoodData.Ingredients.NONE
## Cantidad de elementos
var count: int = 0


## Indica si está lleno
func is_full() -> bool:
    return count == MAX_SIZE


## Transfiere una cantidad dada de elementos y retorna la cuenta de los que fueron transferidos
func push(new_type: FoodData.Ingredients, value: int) -> int:
    # Nuevos elementos
    if not type:
        type = new_type
        count = value
        return value

    if new_type != type:
        push_warning("[FoodStack] Tipos incompatibles")
        return 0

    # Desbordamiento
    if count + value > MAX_SIZE:
        var original_count := count
        count = MAX_SIZE
        return original_count

    count += value
    return value


## Pide una cantidad dada de elementos y retorna la cantidad realmente devuelta
func pop(value: int) -> int:
    # Faltantes
    if count - value < 0:
        var original_count := count
        count = 0
        type = FoodData.Ingredients.NONE
        return original_count

    count -= value

    # Vacío
    if not count:
        type = FoodData.Ingredients.NONE

    return value
