#import "@preview/lovelace:0.3.0": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"

#set document(
  title: [Linear Algebra Notes],
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

#let hline = {

line(length: 100%)

  }
#set heading(numbering: "1.")
#outline()
#let limi = $lim_(x -> oo)$
#let limi(x) = $lim_(#x -> oo)$
#let b(x) = $bold(#x)$

= What is Linear Algebra?
We will not answer this question immediately, except to say that linear algebra is the study of _linear transformations_. Here are some definitions and axioms to remember:

#solution("Definitions", [
  + A vector is an element of a vector space
  + Vectors are denoted by small bold letters, say $bold(v)$ and matrices by capitals, $A$.
  + An $m times n$ matrix means $m$ rows and $n$ columns. We will deal with finite matrices.
  + Notation: $A = (a_(j,k))_(j=1,k=1)^(m, n)$. The entries of the matrix $A$ will be denoted $[A]_(i j) $ or $a_(i j)$.
    $ A = mat(
    a_(1 1), a_(1 2), ..., a_(1 n);
    a_(2 1), a_(2 2), ..., a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), ..., a_(m n);
  ) $
  + The transpose is defined by swapping rows and columns. $[A^T]_(i j) = [A]_(i j)$
    $ mat(1, 2, 3; 4, 5, 6;)^T = mat(1,4; 2,5; 3,6;) $
  

])
#problem("Vector Spaces", [
  Let $VV$ be a set. Let $bold(v), bold(w)$ and $bold(u)$ be arbitrary elements of $VV$, and $a$ and $b$ be scalars. $VV$ is called a _vector space_ if it satisfies the following:
+ $+$ and $times$ are functions from $VV times VV -> VV$
+ *Commutative*: $bold(v) + bold(w) = bold(w) + bold(v)$. 
+ *Associative*: $bold(v) + (bold(w) + bold(u)) = (bold(v) + bold(w)) + bold(u)$\
  $(a b)bold(v) = a(b bold(v))$
+ *Additive identity*: There exists $bold(0)$ such that $bold(v) + bold(0) = bold(v)$
+ *Additive Inverse*: There exists $bold(w)$ such that $bold(v) + bold(w) = bold(0)$
+ *Multiplicative Identity*: $1 bold(v) = bold(v)$
+ *Distributive*: $a(bold(v) + bold(w)) = a bold(v) + a bold(w)$\
  $(a+b)(bold(v)) = a bold(v) + b bold(v)$
])

#problem("Linear Transformation", [
  Let $VV "and" WW$ be vector spaces. A transformation $T:VV -> WW$ is called _linear_ if:
+ $T(bold(u) + bold(v)) = T(bold(u)) + T(bold(v))$
+ $T(a bold(v)) = a T(bold(v)) forall bold(v) in VV$ and all scalars $a$.

])

$ mat(
  delim: "[",
  1, 2, ..., 10;
  2, 2, ..., 10;
  dots.v, dots.v, dots.down, dots.v;
  10, 10, ..., 10;
) $

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

$ colvecmat(b_1, b_2, b_n, dots: #true) $

#rect($A$, width:4%, fill: red.lighten(70%))

#square(size:30pt, fill:blue.lighten(70%), stroke:0.5pt)[#align(center + horizon)[$A$]]


//#cetz.canvas({
  //import cetz.draw: *
  //rect((0, 0), (6, 4), fill: red.lighten(40%), name: "rect")
  //content("rect", [$A$])
  //line((-0.5, 0), (-0.5, 4), mark: (symbol: ">", fill: //black), name: "m")
  //content("m", box(fill: white, inset: 5pt)[$m$])
  //line((0, 4.5), (6, 4.5), mark: (symbol: ">", fill: black), //name: "n")
//  content("n", box(fill: white, inset: 5pt)[$n$])
//})

$ (#square(size:30pt, fill:blue.lighten(70%), stroke:0.5pt)[#align(center + horizon)[$A$]]) $