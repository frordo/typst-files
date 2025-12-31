#import "@preview/lovelace:0.3.0": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"

#set document(
  title: [Why is Matrix Multiplication That Way?],
  date: auto,
)
#show title: set text(size: 17pt)
#show title: set align(center)
#title()
#align(center)[#link("https://github.com/frordo")[#smallcaps("Frordo")]]
#let calO(x) = $𝒪(#x)$

#let color_box(title, body) = stack(
  rect(
    width: 100%,
    fill: luma(230),
    stroke: .5pt,
    inset: (x: 10pt, y: 8pt),
    strong(title),
  ),
  rect(width: 100%, stroke: .5pt, inset: 10pt, body),
)

#let problem(title, body) = {
  showybox(
    frame: (
      border-color: red.darken(50%),
      title-color: red.lighten(67%), //6 7
      body-color: red.lighten(87%)
    ),
    title-style: (
      color: black,
      weight: "bold",
      align: left
    ),

    title: title,
    body
  )
}

#let solution(title, body) = {
  showybox(
    frame: (
      border-color: blue.darken(50%),
      title-color: blue.lighten(67%), //6 7
      body-color: blue.lighten(87%)
    ),
    title-style: (
      color: black,
      weight: "bold",
      align: left
    ),

    title: title,
    body
  )
}

#let solved(title, body) = {
  showybox(
    frame: (
      border-color: green.darken(50%),
      title-color: green.lighten(67%), //6 7
      body-color: green.lighten(87%)
    ),
    title-style: (
      color: black,
      align: left
    ),

    title: title,
    body
  )
}

// Matrix where the columns are vectors:
// M = (
//   |     |         |
//   v_1  v_2  ...  v_n
//   |     |         |
// )
#let colvecmat(..vecs, dots: false) = {
  let vecs = vecs.pos()
  let n = vecs.len()
  if n == 0 { return math.mat((), (), ()) }
  if n == 1 { return math.mat(([|],), vecs.first(), ([|],)) }
  let (..vecs, last) = vecs
  math.mat(
    
    ([|],) * (n - 1) + if dots { ([],) } + ([|],),
    (..vecs,) + if dots { ($#sym.dots.h.c$,) } + (last,),
    ([|],) * (n - 1) + if dots { ([],) } + ([|],),
  )
}

// Matrix where the rows are vectors:
// M = (
//   --- v_1 ---
//   --- v_2 ---
//        .
//        .
//        .
//   --- v_n ---
// )
#let rowvecmat(..vecs, dots: false) = {
  let vecs = vecs.pos()
  if vecs == () { return math.mat() }
  let (..vecs, last) = vecs
  math.mat(
    ..vecs.map(x => ($dash.two thin #x thin dash.two$,)),
    ..if dots and vecs != () { (($#sym.dots.v$,),) },
    ($dash.two thin last thin dash.two$,)
  )
}

#let hline = {

line(length: 100%)

  }
#set heading(numbering: "1.")
#outline()
#let limi = $lim_(x -> oo)$
#let limi(x) = $lim_(#x -> oo)$
#let b(x) = $bold(#x)$
#let vec(x) = $bold(arrow(#x))$

= Introduction

When I first learned about matrices, I naively expected them to multiply as follows:

#set math.mat(delim: "(")

$ mat(1, 2; 3, 4) mat(2, 3; 4, 5) = mat(1 dot 2, 2 dot 3; 3 dot 4, 4 dot 5) $

Instead, they multiply like
$ mat(1, 2; 3, 4) mat(2, 3; 4, 5) = mat(1 dot 2 + 2 dot 4, 1 dot 3 + 2 dot 5; 3 dot 2 + 4 dot 4, 3 dot 3 + 4 dot 5) $

Why is that?

= Linear Transformations
A transformation takes a vector as input and outputs a vector. More formally, $T:V->W$ where V and W are vector spaces. A _linear_ transformation $L$ has the following properties:

- $L(a vec(v)) = a L(vec(v))$
- $L(vec(v) + vec(w)) = L(vec(v)) + L(vec(w))$

$ mat(
  delim: "[",
  1, 2, ..., 10;
  2, 2, ..., 10;
  dots.v, dots.v, dots.down, dots.v;
  10, 10, ..., 10;
) $


$ colvecmat(b_1, b_2, b_n, dots: #true) $

#rect($A$, width:4%, fill: red.lighten(70%))

#square(size:30pt, fill:blue.lighten(70%), stroke:0.5pt)[#align(center + horizon)[$A$]]

$ (#square(size:30pt, fill:blue.lighten(70%), stroke:0.5pt)[#align(center + horizon)[$A$]]) $