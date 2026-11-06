## [BaseState] es una clase base para almacenar los estados de una SFM.
##
## Los estados pueden implementar métodos como [method start] y [method update] de forma
## análoga al ciclo de vida de un nodo convencional. Todos los métodos son opcionales
@abstract class_name BaseState extends Node


## Nodo a controlar
var controlled_node: Node


## Indica a la máquina de estados que se mueva hacia otro estado.
## Escribe el classname del siguiente estado como un tipo
@warning_ignore("unused_signal")
signal to_state(next_state: Script)


## Se ejecuta al principio del estado
func start() -> void:
	pass


## Se ejecuta en cada frame
@warning_ignore("unused_parameter")
func update(delta: float) -> void:
	pass


## Se ejecuta en cada paso de físicas
@warning_ignore("unused_parameter")
func physics_update(delta: float) -> void:
	pass


## Se ejecuta al salir del estado y antes de empezar el siguiente
func exit() -> void:
	pass
