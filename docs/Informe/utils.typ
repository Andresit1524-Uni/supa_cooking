#import "@preview/lilaq:0.6.0" as lq

#let style(body) = {
  set document(
    title: [Supa Cooking: segunda entrega],
  )

  // Colores
  show link: set text(fill: blue)
  show ref: set text(fill: blue)

  // Fuentes
  set text(lang: "es", font: "Ancizar Sans")
  //show heading: set text(font: "")
  show raw: set text(font: "Google Sans Code NF")
  show math.equation: set text(font: "Erewhon Math")

  body
}

/// Incrusta el diagrama UML. Typst no puede comprobar si el archivo
/// existe, así que `uml-path` debe apuntar al PNG real. Mientras no
/// exista, usa `uml-figure(none)` para dejar un marcador y que el
/// documento compile igualmente.
//#let uml-figure(path) = {
//  if path == none {
//    block(
//      width: 100%,
//      stroke: 0.5pt + luma(60%),
//      inset: 1em,
//      radius: 4pt,
//      align(center)[
//        #text(fill: luma(40%))[
//          Diagrama UML pendiente. \
//          Coloca el PNG y cambia la llamada a `uml-figure("assets/uml.png")`.
//        ]
//      ],
//    )
//  } else {
//    image(path)
//  }
//}

/// Convierte un número con coma decimal (es-CO) a float.
/// Acepta "0,5165" -> 0.5165 y "1.234" -> 1.234
#let parse-num(s) = {
  let t = s.trim().replace(",", ".")
  float(t)
}

/// Par tabla y gráfica para benchmarks.
///
/// El CSV usa `;` como separador y coma decimal. Su orientación es:
/// la primera columna es N (tamaño de entrada) y cada columna restante
/// es una operación medida (en ms). Cada operación se dibuja como una
/// serie sobre los valores de N en escala log-log.
#let benchmark-table-plot(source) = {
  let data = csv(source, delimiter: ";")
  let header = data.at(0).map(it => it.trim())
  let rows = data.slice(1)
  let ncols = header.len()

  // Valores de N (primera columna) para el eje x.
  let ns = rows.map(it => parse-num(it.at(0)))

  set text(size: 6pt)
  set table.cell(inset: 0.5em)

  grid(columns: (1fr, 1.5fr))[
    #table(
      columns: ncols,
      stroke: 0.7pt,
      ..header.map(it => [*#it*]),
      ..rows.map(it => (raw(it.at(0).trim()), ..it.slice(1).map(c => c.trim()))).flatten(),
    )
  ][
    #lq.diagram(
      width: 8cm,
      height: 5cm,
      xscale: "log",
      yscale: "log",
      legend: (position: (100% + .5em, 0%)),
      xlabel: [Número de operaciones],
      ylabel: [Tiempo (ms)],
      // Una serie por cada columna de operación (desde la 2.ª columna).
      ..range(1, ncols).map(col => {
        let label = header.at(col)
        let ys = rows.map(it => calc.max(1e-4, parse-num(it.at(col))))
        return lq.plot(ns, ys, label: label)
      }),
    )
  ]
}
