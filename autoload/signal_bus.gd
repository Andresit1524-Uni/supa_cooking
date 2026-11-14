## Autoload para almacenar señales
extends Node


@warning_ignore("unused_signal")

## Se emite cuando el inventario actualiza sus stacks
signal inventory_updated(stacks: Array[Inventory.Stack])
