class_name platos extends Node2D

var pila: Array = []

# Insertar un elemento (PUSH)
func push(elemento):
	pila.append(elemento)

# Eliminar y retornar el último elemento (POP)
func pop():
	if is_empty():
		print("La pila está vacía")
		return null

	return pila.pop_back()

# Consultar el último elemento (PEEK)
func peek():
	if is_empty():
		print("La pila está vacía")
		return null

	return pila.back()

# Comprobar si está vacía
func is_empty() -> bool:
	return pila.is_empty()

# Obtener el tamaño de la pila
func size() -> int:
	return pila.size()

# Eliminar todos los elementos
func delete():
	pila.clear()
