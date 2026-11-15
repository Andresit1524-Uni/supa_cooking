#import "utils.typ": *
#show: style

#align(center)[
  #title()
  *Integrantes:* Hayran Andrés López, Daniel Alejandro Durán, Andrés Eduardo Sierra, Jeison Steven Guio, David Santiago Muñoz.

  #divider()
]

= Descripción del problema
// TODO: Diagrama UML pendiente; por ahora no se va a utilizar.

Los videojuegos son un gran mercado que está en constante crecimiento a nivel mundial. Esto se debe a las grandes experiencias que ofrecen: acción, aventura, mundo abierto y un muy largo etcétera. Estas aventuras no pueden existir sin nosotros, los programadores.

Cuando desarrollamos cualquier software nos podemos encontrar con una variedad de dificultades técnicas. Las máquinas donde se ejecutan los programas no tienen recursos ilimitados, y esta es la razón por la que debemos tener muy en cuenta lo aprendido en estructuras de datos para optimizar y aprovechar al máximo el rendimiento que ofrece la máquina a la hora de jugar. Para ser más específicos, vamos a utilizar distintos flujos de datos, de manera eficiente, con el objetivo de implementar las siguientes funciones:

+ Atención a clientes: las solicitudes ingresan secuencialmente y requieren tiempos de espera particulares.
+ Armado de platillos: construcción paso a paso de los alimentos por capas, donde el último ingrediente colocado es el primero que se puede retirar si hay un error.
+ Control de inventario e historial de recetas: búsqueda rápida de combinaciones válidas y comprobación de disponibilidad de ingredientes.
+ Módulo de lavado de vajilla.

= Entornos de desarrollo y ejecución
Cuando comenzamos a desarrollar nos encontramos con un gran problema que detenía todo el proceso al utilizar `GDScript`, pues este lenguaje no permite usar clases genéricas. Por este motivo hicimos uso de los siguientes lenguajes y entornos.

== Lenguajes
=== GDScript
Es el lenguaje nativo que utiliza `Godot Engine`.

=== C\#
Hicimos uso de C\# con el objetivo de crear las estructuras de datos utilizadas en `Supa Cooking`. Este código se implementó dentro del juego creando un plugin con todas las estructuras. Los archivos se encuentran en `addons/data_structures`.

=== Typst
Es el lenguaje utilizado para el desarrollo de documentos y con el que está hecho el documento actual. Este lenguaje es más intuitivo de usar que `LaTeX` y, como grupo, lo preferimos.

== Entornos
=== Visual Studio Code
Se utilizó para programar todo el código. Es el estándar y tiene muchas facilidades que aceleran el trabajo.

=== Godot Engine `.NET` v4.7.2
Es un motor bastante liviano, amigable con el usuario y portable. Estos motivos, además de que varias personas ya tenían experiencia utilizándolo, fueron lo que nos llevó a elegirlo. Se utilizó la versión `.NET` para poder implementar C\# y resolver el problema mencionado anteriormente.

= Diseño e implementación
Las estructuras de datos usadas en el juego, todas implementadas manualmente (sin librerías), son:
// TODO: Diagrama UML pendiente; por ahora no se va a utilizar.

- *Arreglo dinámico* (`DynamicArray`): base reutilizable; crece al llenarse y da acceso por índice.
  + *Pila y cola*: con el objetivo de asimilar el funcionamiento que tienen las estructuras de datos incluidas en Godot al expandirse automáticamente, heredamos esta clase en `Queue` y `Stack`.
- *Pila* (`Stack`): se guardan ingredientes en pilas (LIFO).
  + Desarrollo del inventario.
- *Cola* (`Queue`): la cola de pedidos se atiende en orden (FIFO). Se diseña como una *cola circular*, de modo que encolar y desencolar no requieran trasladar los elementos del arreglo.
  - Aún no implementada.

= Análisis de complejidad

== Arreglos dinámicos, pilas y colas
Los arreglos dinámicos son arreglos cuyo tamaño puede crecer de manera indefinida, permitiendo acceder a los elementos de manera aleatoria (por índice) y reasignarse automáticamente cuando se llenan.

Eliminar o añadir un elemento en una posición diferente a la última requiere trasladar el resto de elementos hacia adelante o hacia atrás, lo cual hace que su complejidad sea $O(n)$. El resto de operaciones al final o de consulta directa pueden hacerse de manera inmediata y, por ende, con $O(1)$.

La cola se diseña como una *cola circular*: usa dos índices (frente y final) que avanzan de manera cíclica sobre el arreglo. Gracias a esto, `enqueue` y `dequeue` no trasladan elementos y se ejecutan en tiempo constante $O(1)$.

La complejidad teórica de sus operaciones es la siguiente:

#figure(
  caption: [Complejidad teórica de pila, cola circular y arreglo dinámico.],
)[
  #table(
    columns: 4,
    [*Operación*], [*Pila*], [*Cola (circular)*], [*Complejidad*],
    `pushFront`, `-`, `-`, $O(n)$,
    `pushBack`, `push`, `enqueue`, $O(1)$,
    `popFront`, `-`, `dequeue`, $O(1)$,
    `popBack`, `pop`, `-`, $O(1)$,
    `delete`, `delete`, `delete`, $O(n)$,
    `isEmpty`, `isEmpty`, `isEmpty`, $O(1)$,
    `size`, `size`, `size`, $O(1)$,
    `front`, `-`, `front`, $O(1)$,
    `back`, `peek`, `-`, $O(1)$,
  )
]

Al ser circular, la cola evita el $O(n)$ que tendría un arreglo llenado de inicio a fin, donde `dequeue` obligaría a desplazar todos los elementos restantes.

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

#benchmark-table-plot("../../test_results/dynamic_array_benchmarks.csv")

== Pilas
Las pilas exhiben un excelente rendimiento para todas las operaciones. `Push` y `Pop` actúan al final del arreglo y `Peek` es una consulta directa, todas constantes.

#benchmark-table-plot("../../test_results/stack_benchmarks.csv")

== Colas
La cola circular mantiene `Enqueue` y `Peek` constantes. Una vez se complete la implementación circular, `Dequeue` también será constante al no trasladar elementos. Los datos actuales corresponden a la cola basada en el arreglo dinámico simple, donde `Dequeue` todavía crece de forma lineal; se actualizarán al terminar la versión circular.

#benchmark-table-plot("../../test_results/queue_benchmarks.csv")


= Discusión y análisis comparativo
Los resultados empíricos coinciden con la complejidad teórica: las operaciones al final del arreglo (`push`, `pop`, `enqueue`, `peek`) se mantienen planas al crecer $n$, mientras que `AddFirst` en el arreglo dinámico crece de forma lineal por el traslado de elementos. La cola circular está pensada precisamente para que `dequeue` no sufra ese traslado y se mantenga constante.

== ¿Cuándo es mejor cada estructura?
Las pilas y colas basadas en arreglos dinámicos se usan cuando el rendimiento es importante y el patrón de acceso es LIFO o FIFO. Para la cola, el arreglo circular es la mejor opción, pues evita el traslado de elementos en cada `dequeue`.

Los arreglos dinámicos aprovechan la memoria contigua y el acceso por índice, pero las reasignaciones generan picos de procesamiento al crecer.

= Justificación de la solución óptima
Esta solución es óptima porque, al usar estas estructuras, obtenemos un buen rendimiento que, como se ve en las gráficas, no escala demasiado en ninguna estructura, teniendo en cuenta que no manejaremos una gran cantidad de datos. El objetivo, más que todo, es contar con estructuras que, manteniendo este estilo de funcionamiento y cambiando su tamaño, respondan en un tiempo corto.

= Video demostrativo
// TODO: Enlace al video (clonar desde GitHub y ejecutar), máximo 8 minutos.
// Formato: #link("URL")[Ver demostración]

= Conclusiones
// TODO: Evaluar resultados y reflexionar sobre optimizaciones posibles
// (p. ej. completar la cola circular) y decisiones técnicas tomadas.
Hemos podido implementar parcialmente las estructuras de datos en el videojuego, y observamos que a la hora de jugar se obtiene una buena experiencia. Seguimos trabajando para implementar las estructuras en otras partes del juego y poder resolver los problemas pendientes para la siguiente entrega. Nuestro avance por ahora es prometedor y tenemos una visión clara de cómo continuar.

= Referencias
#set enum(numbering: "[1]")

+ Godot Engine, "Godot Engine documentation (stable)," 2026. [En línea]. Disponible: #link("https://docs.godotengine.org/en/stable/").
+ Godot Engine, "C\# scripting," _Godot Engine documentation (4.x)_, 2026. [En línea]. Disponible: #link("https://docs.godotengine.org/es/4.x/tutorials/scripting/c_sharp/index.html").
+ Microsoft, "C\# documentation," 2026. [En línea]. Disponible: #link("https://learn.microsoft.com/en-us/dotnet/csharp/").
+ Typst, "Page setup guide," _Typst documentation_, 2026. [En línea]. Disponible: #link("https://typst.app/docs/guides/page-setup/").
