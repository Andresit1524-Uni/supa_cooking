## Autoload para almacenar señales
extends Node


@warning_ignore("unused_signal")

## Se emite cuando el inventario actualiza sus stacks
signal inventory_updated(stacks: Array[Inventory.Stack])
## Se emiten cuando se está interactuando con un almacén
signal interact_shelf1()
signal interact_shelf2()
signal interact_fridge()
