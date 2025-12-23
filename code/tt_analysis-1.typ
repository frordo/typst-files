#import "@preview/lovelace:0.3.0": *
#import "@preview/showybox:2.0.4": showybox


#set document(
  title: [Notes and Solutions to Analysis I, Terence Tao],
  date: auto,
)
#show title: set text(size: 17pt)
#show title: set align(center)
#title()
#align(center)[#link("https://github.com/frordo")[#smallcaps("Frordo")]]
#let calO(x) = $𝒪(#x)$

My solutions to Terence Tao's Analysis I. Enjoy!

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

#let hline = {

line(length: 100%)

  }
#set heading(numbering: "1.")
#outline()
#let limi = $lim_(x -> oo)$
#let limi(x) = $lim_(#x -> oo)$

= Why Analysis?
$ limi(x) sin(x) = limi sin (pi + x) = limi(x) -sin(x) $
$ limi(x) sin x = 0 $
$ limi(x) cos x =^(x |-> pi/2 - x) 0 $
$ limi(x) 1 = limi(x) sin^2(x) + cos^2(x) = 0 $
$ #rect([1 = 0]) $

= The Natural Numbers
== The Peano Axioms
#solution("Definitions", [
  + $NN$ denotes the set of natural numbers, that is, $NN = {0, 1, 2, dots.h}$
  + $S$ is the successor function
  + Call $S(0) = 1$, $S(1) = 2$, and so on.

])
#problem("Axioms", [
+ *Axiom 1*: $0$ is a natural number.
+ *Axiom 2*: If $n$ is a natural number, $S(n)$ is a natural number 
+ *Axiom 3*: $0$ is not the successor of any natural number.
+ *Axiom 4*: $S$ is a one-to-one function, that is, $S(x) = S(y) <=> x = y$
+ *Axiom 5* (_Mathematical Induction_): Suppose $P(n)$ is a property of a natural number $n$. Then if $P(0)$ is true, and $P(n) => P(n+1)$, then $P$ is true for all natural numbers.
])

#solved("Problems", [
+ *Axiom 1*: $0$ is a natural number.
+ *Axiom 2*: If $n$ is a natural number, $S(n)$ is a natural number 
+ *Axiom 3*: $0$ is not the successor of any natural number.
+ *Axiom 4*: $S$ is a one-to-one function, that is, $S(x) = S(y) <=> x = y$
+ *Axiom 5* (_Mathematical Induction_): Suppose $P(n)$ is a property of a natural number $n$. Then if $P(0)$ is true, and $P(n) => P(n+1)$, then $P$ is true for all natural numbers.
])