## StateMachine es la clase base para una máquina de estados.
##
## Los estados son nodos hijos de tipo [BaseState] que contienen la lógica de cada estado
## y se comunican entre si
@icon("res://addons/state_machine/state_machine_icon.svg")
class_name StateMachine extends Node


@export var controlled_node: Node
@export var default_state: BaseState


var states: Dictionary[Script, BaseState] = {}
var current_state: BaseState


#region Preparación


func _ready() -> void:
	if not controlled_node:
		push_error("[StateMachine] No hay nodo objetivo para controlar")
		return

	if not default_state:
		push_error("[StateMachine] No hay estado inicial")
		return

	# Se conecta a todos los estados adjuntos
	for child: BaseState in get_children():
		if not child.get_script():
			push_error("[StateMachine] El estado %s no tiene un script asignado" % child.name)
			continue

		# Desactiva
		child.set_process(false)
		child.set_physics_process(false)
		child.set_process_input(false)
		child.set_process_unhandled_input(false)

		# Configura
		states[child.get_script()] = child
		child.to_state.connect(change_to_state)
		child.controlled_node = controlled_node

	# Asigna el estado inicial
	current_state = default_state
	_start_current_state()


#endregion


## Ejecuta el fin del ciclo de vida de un estado y cambia al que se indique
func change_to_state(next_state: Script) -> void:
	# Fin del estado actual
	if current_state:
		current_state.set_process_input(false)
		current_state.set_process_unhandled_input(false)
		current_state.exit()

	# Busca el nuevo estado, asigna y ejecuta
	current_state = states.get(next_state)
	if not current_state:
		push_error("[StateMachine] Estado %s no encontrado" % next_state.get_global_name())
		return

	_start_current_state()


#region Ciclo de vida del Estado


func _start_current_state() -> void:
	if not current_state:
		push_error("[StateMachine] Estado %s no encontrado" % current_state.name)
		return

	print("[StateMachine] Cambiando a estado %s" % current_state.name)
	current_state.set_process_input(true)
	current_state.set_process_unhandled_input(true)
	current_state.start()


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


#endregion
