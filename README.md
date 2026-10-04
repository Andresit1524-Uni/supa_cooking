# Supa' Cooking
Este es nuestro proyecto final para estructuras de datos 2026-2: Un juego de cocina, implementado en Godot y enfocado en la implementación práctica de platos varios.

> [!NOTE]
>
> Integrantes del proyecto:
>
> - Hayran Andrés López
> - Daniel Alejandro Durán
> - Andrés Eduardo Sierra
> - Jeison Steven Guio
> - David Muñoz Muñoz

## Diseño

```mermaid
mindmap
    root((Proyecto))
        Desarrollo
            Godot Engine
            GDScript
        Lógica
            Escenas y nodos
            Estructuras de datos
                Pilas
                Colas
                Grafos
                Hashmaps
            Puntaje y objetivos
                Entrega de platos
                Atención al cliente
                Eficiencia
                Precios
        Intefaz
            Botones
            Entrada de teclado y mouse
        Gráficos
            Personajes
            Escenario
            Artículos
```

## Flujo de funcionamiento

```mermaid
sequenceDiagram
    actor Jugador
    participant Mostrador
    participant Inventario
    participant Cocina
    participant Lavaplatos

    Jugador ->> Mostrador: Inicia la jornada
    Mostrador ->> Jugador: Debes atender clientes
    Jugador ->> Inventario: Gestiona el inventario con tus ingredientes
    Mostrador ->> Jugador: Se genera una orden y se inserta en la cola de pedidos
    Jugador ->> Mostrador: Se extrae el pedido al frente de la cola
    Jugador ->> Cocina: Se busca la receta en el árbol de recetas para comparar la secuencia
    Jugador ->> Cocina: Por cada ingrediente seleccionado, se añade a la pila de armado
    Jugador ->> Cocina: Cocina el plato con los ingredientes correctos
    Jugador ->> Mostrador: Entrega el plato
    Mostrador ->> Lavaplatos: El plato se añade solo al acabarse
    Jugador ->> Lavaplatos: Lava los platos al final del día
```
