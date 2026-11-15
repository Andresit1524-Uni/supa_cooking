#import "utils.typ": *
#show: style

#align(center)[
  #title()
  *Integrantes:* Hayran Andrés López, Daniel Alejandro Durán, Andrés Eduardo Sierra, Jeison Steven Guio, David Santiago Muñoz.

  #divider()
]

= Descripción del problema
// TODO: Describir en detalle el problema que resuelve Supa Cooking
// (gestión de pedidos, alacena e inventario de una cocina) y por qué
// exige las estructuras de datos usadas.

Los videojuegos son gran mercado que esta en constante crecimiento a nivel mundial. Esto debido a las grandes experiencias que nos ofrecen: acción, aventura, mundo abierto y un muy largo etc. Estas aventuras no pueden existir sin nosotros, los programadores.

Cuado estamos desarrollando cualquier software nos podemos a encontrar variedad de dificultades tecnicas. Las maquinas donde se ejecutan los programas no tienen recursos ilimitados. Y esta es la razón por la que nosotros tenemos que tener muy en cuenta lo aprendido en estructuras de datos para optimizar y aprovechar al maximo el rendimiento que nos ofrece la maquina a la hora de jugar. Para ser mas especificos vamos a utilizar distintos flujos de datos, de manera eficiente, con el objetivo de implementar las siguientes funciones:

+ Atención a clientes: las solicitudes ingresan secuencialmente y requieren tiempos de espera particulares.
+ Armado de platillos: construcción paso a paso de alimentos por capas, en donde el último ingrediente colocado es el primero que se puede retirar si hay un error.
+ Control de inventario e historial de recetas: búsqueda rápida de combinaciones válidas y comprobación de disponibilidad de ingredientes.
+ El programa implementa un módulo de lavado de vajilla.
= Entornos de desarrollo y ejecución
// TODO: Motor Godot, lenguajes (C# y GDScript), versión del motor,
// sistema operativo y herramientas de medición y graficación (Typst + lilaq).
Cuando comenzamos a desarrollar nos encontramos con un gran problema que nos detenia todo el proceso al utilizar `GDDscript` pues este lenguaje no nos permite usar clases genericas. Por este motivo nosotros hicimos uso de las siguientes herramientas lenguajes y entornos.
== Lenguajes
=== GddScript
Este lenguaje es el lenguaje nativo que utiliza `Godot engine`
=== C\#
Hicimos uso de C\# con el objetivo de crear las estructuras de datos utilizadas en `Supa Cooking`. Este codigo se implemento dentro del juego creando un plugin con todas las estructuras. Los archivos se encuentran en `addons/data_structures`.
=== Typst
Es el lenguaje utilizado para el desarrollo de documentos y que se esta implementando en el documento actual. Este lenguaje es mas intuitivo de usar que `LaTeX` y como grupo lo preferimos.
== Entornos
=== Visual Studio Code
Se utilizo para programar todo el codigo, es el standart y tiene muchas facilidades que aceleran el trabajo.
=== Godot Engine `.NET` v4.7.2
Es un motor de godot bastante liviano, amigable con el usuario y portable. Estos motivos ademas de que varias personas ya tenian experiencia utilizando este motor fue lo que nos llevo a elegirlo.
Se utilizo la version `.NET` para poder implementrar C\# y resolver el problema anteriormente mencionado.
= Diseño e implementación
Las estructuras de datos usadas en el juego, todas implementadas manualmente (sin librerías), son:
// TODO: Explicar dónde se aplica cada estructura en el juego:
// Pendientes varias implementaciones por lo que
- *Arreglo dinámico* (`DynamicArray`): base reutilizable; crece al llenarse y da acceso por índice.
  - *Pila y colas*: con el objetivo de asimilar el funcionamiento que tienen las estructuras de datos incluidas en GODOT al expandirse automaticamente heredamos ensta clase en `Queque` y `Stack`

- *Pila* (`Stack`): Se guardan ingredientes en pilas (LIFO). Se uso en el desarrollo del inventario.

- *Cola* (`Queue`): La cola de pedidos se atiende en orden (FIFO). Por ahora no lo hemos implementado



= Análisis de complejidad

== Arreglos dinámicos, pilas y colas
Los arreglos dinámicos son arreglos cuyo tamaño puede crecer de manera indefinida, permitiendo acceder a elementos de manera aleatoria (por índice) y reasignarse automáticamente cuando se llenan.

Eliminar o añadir un elemento en una posición diferente a la última requiere trasladar el resto de elementos hacia adelante o hacia atrás, lo cual hace que su complejidad sea de $O(n)$. El resto de operaciones al final o de consulta directa pueden hacerse de manera inmediata y por ende con $O(1)$.

La complejidad teórica de sus operaciones es la siguiente:

#figure(
  caption: [Complejidad teórica de pila, cola y arreglo dinámico.],
)[
  #table(
    columns: 4,
    [*Operación*], [*Pila*], [*Cola*], [*Complejidad*],
    `pushFront`, `-`, `-`, $O(n)$,
    `pushBack`, `push`, `enqueue`, $O(1)$,
    `popFront`, `-`, `dequeue`, $O(n)$,
    `popBack`, `pop`, `-`, $O(1)$,
    `delete`, `delete`, `delete`, $O(n)$,
    `isEmpty`, `isEmpty`, `isEmpty`, $O(1)$,
    `size`, `size`, `size`, $O(1)$,
    `front`, `-`, `front`, $O(1)$,
    `back`, `peek`, `-`, $O(1)$,
  )
]

= Reporte de pruebas y resultados empíricos
Para analizar el comportamiento real de estos métodos utilizaremos medidas de tiempo de alta precisión. El esquema de medición es el siguiente:

- Mediremos el rendimiento con 10, 100, 1000, ..., hasta $10^5$ operaciones.
- Esta medición es por cada método de cada estructura implementada, en un promedio de varios intentos.
- Haremos una tabla de tiempos y una gráfica por cada estructura de datos.
- Las gráficas serán en escala logarítmica para evidenciar todas las escalas adecuadamente.
- Los tiempos se reportan en *milisegundos*.

Los datos están registrados en archivos CSV independientes dentro de `data/`.

== Arreglos dinámicos
El arreglo dinámico es la base de las pilas y colas. `AddLast` y `RemoveLast` son constantes porque operan al final sin traslados, mientras que `AddFirst` es lineal: insertar al frente obliga a desplazar todos los elementos. `Search` recorre el arreglo, también lineal.

#benchmark-table-plot("../../data/dynamic_array_benchmarks.csv")

== Pilas
Las pilas exhiben un buen rendimiento para todas las operaciones. `Push` y `Pop` actúan al final del arreglo y `Peek` es una consulta directa, todas constantes.

#benchmark-table-plot("../../data/stack_benchmarks.csv")

== Colas
Las colas pierden rendimiento en `Dequeue` porque implica sacar un elemento del principio y trasladar los demás, degradándose a $O(n)$. `Enqueue` y `Peek` siguen siendo constantes.

#benchmark-table-plot("../../data/queue_benchmarks.csv")

#pagebreak()

= Discusión y análisis comparativo
Los resultados empíricos coinciden con la complejidad teórica: las operaciones al final del arreglo (`push`, `pop`, `enqueue`, `peek`) se mantienen planas al crecer $n$, mientras que `AddFirst` en el arreglo dinámico y `dequeue` en la cola crecen de forma lineal por el traslado de elementos.


== ¿Cuándo es mejor cada estructura?
Las pilas y colas de arreglos dinámicos se usan cuando el rendimiento es más importante y el patrón de acceso es LIFO o FIFO. Un arreglo dinámico circular sería la mejor opción para una cola, pero no fue implementado.

Los arreglos dinámicos aprovechan la memoria contigua y el acceso por índice, pero las reasignaciones generan picos de procesamiento al crecer.

= Justificación de la solución óptima
// TODO: Argumentar por qué pila + cola + arreglo dinámico es la solución
// más óptima para el flujo del juego (pedidos FIFO, ingredientes LIFO),
// apoyándose en las complejidades y gráficas anteriores.
Esta solución es optima ya que al usar estas estructuras tenemos un buen rendimiento que como podemos ver en las graficas no escala mucho en ninguna estructura teniendo en cuenta que no vamos a manejar una gran cantidad de datos. EL objetivo mas que todo es que tengamos una estructura que, manteniendo este estilo de funcionamiento cambiando su tamaño, responda en un tiempo no muy largo.

= Video demostrativo
// TODO: Enlace al video (clonar desde GitHub y ejecutar), máximo 8 minutos.
// Formato: #link("URL")[Ver demostración]


= Conclusiones
// TODO: Evaluar resultados y reflexionar sobre optimizaciones posibles
// (p. ej. completar la cola circular) y decisiones técnicas tomadas.
Hemos podido implementar las estructuras de datos en el videojuego parcialmente. Y realmente podemos observar un uso que a la hora de jugar podremos tener una buena experiencia. Seguimos trabajando para implementar las estructuras en otras partes del juego y poder resolver los problemas para la siguiente entrega. Pero nuestro avance por ahora es prometedor y tenemos una vision clara de como avanzar.

= Referencias
// TODO: Referencias bibliográficas en el formato que use el curso.
https://docs.godotengine.org/en/stable/
https://docs.godotengine.org/es/4.x/tutorials/scripting/c_sharp/index.html
https://learn.microsoft.com/en-us/dotnet/csharp/
https://typst.app/docs/guides/page-setup/
