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
#let vec(x) = $bold(accent(#x, arrow))$
#let cl() = [*Claim.*]
#let pf() = [_Proof._]
#let null(x) = $"Null"(#x)$
#let ker(x) = $"Ker"(#x)$
#let col(x) = $"Col"(#x)$
#let ran(x) = $"Ran"(#x)$
#let span(x) = $"span"(#x)$

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

= What is Linear Algebra?
We will not answer this question immediately, except to say that linear algebra is the study of _linear transformations_. Here are some definitions and axioms to remember:

#solution("Definitions", [
  + A vector is an element of a vector space
  + Vectors are denoted by small bold letters, say $vec(v)$ and matrices by capitals, $A$.
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

= Axioms
#problem("Field Axioms", [
  Let $FF$ be a non-empty set. Let $+$ and $times$ be two functions (operations) from $FF -> FF$. $FF$ satisfies
+ $a+b=b+a $
+ $(a+b)+c=a+(b+c)
$  $(a b)vec(v) = a(b vec(v))$
+ There exists $0$ such that $a + 0 = a$
+ There exists $b$ such that $a+b = 0$
+ $(a b)c=a(b c)$
+ There exists $1$ such that $1 times a = a times 1 = a$
+ There exists inverse such that $a^{-1} times a = 1$
+ $a b = b a$
+ $a(b+c) = a b + a c$
])
#problem("Vector Spaces", [
  Let $VV$ be a non-empty set. Let $vec(v), vec(w)$ and $vec(u)$ be arbitrary elements (called _vectors_, represented with a bold typeface and arrow on top) of $VV$, and $a$ and $b$ be scalars belonging to $FF$. $VV$ is called a _vector space_ if it satisfies the following:
+ $vec(v) + vec(w) = vec(w) + vec(v)$. 
+ $vec(v) + (vec(w) + vec(u)) = (vec(v) + vec(w)) + vec(u)$\
  $(a b)vec(v) = a(b vec(v))$
+ There exists $vec(0)$ such that $vec(v) + vec(0) = vec(v)$
+ There exists $vec(w)$ such that $vec(v) + vec(w) = vec(0)$
+ $1 vec(v) = vec(v)$
+ $a(vec(v) + vec(w)) = a vec(v) + a vec(w)$\
  $(a+b)(vec(v)) = a vec(v) + b vec(v)$
])
Note that the operations together with the set make the field. For instance $(RR, +, times)$ is a field. $(RR, +, *)$ where $a*b = 2a b$ is also a field (check this!). Another more familiar example may be the integers modulo a number, $ZZ \/ n ZZ$. Usually we will use the regular multiplication and addition. The elements of a field are called _scalars_

I will sometimes forget the $VV$ and the $FF$. We call $VV$ a vector space over $FF$.
#solved("Properties",[
  #cl() $vec(0)$ is unique.

  #pf() Suppose there are two zeros, $vec(0)_1$ and $vec(0)_2$. Then $ vec(0)_2 = vec(0)_2 + vec(0)_1 = vec(0)_1 + vec(0)_2 = vec(0)_1. $

  #cl() $vec(0)$ is unique.

  #pf() Suppose there are two zeros, $vec(0)_1$ and $vec(0)_2$. Then $ vec(0)_2 = vec(0)_2 + vec(0)_1 = vec(0)_1 + vec(0)_2 = vec(0)_1. $

  #cl() Additive inverses are unique.

  #pf() Suppose there are two inverses to $vec(v)$, $vec(w)_1$ and $vec(w)_2$. Then 
  $ vec(v) + vec(w)_1 = vec(v) + vec(w)_2 $ 
  $ vec(v) + vec(w)_1 + vec(w)_1 = vec(v) + vec(w)_2 + vec(w)_1 $ 
  $ vec(w)_1 = vec(w)_2. $

  #cl() $vec(0) = 0vec(v)$

  #pf() $ 0(vec(v)+vec(v)) = 0(vec(v)) + 0(vec(v)) $
  $ (2)(0)vec(v) = 0vec(v) = 0vec(v) + 0vec(v) $
  Adding the additive inverse (say $vec(w)$) on both sides
  $ 0vec(v) + w = 0vec(v) + 0vec(v)+w $
  $ vec(0) = 0vec(v) $

  #cl() $vec(v) + (-1)vec(v) = 0$
  $ vec(v) + (-1)vec(v) = 1v + (-1)vec(v) = vec(v)(1 -1) = 0vec(v) = vec(0) $
])

#problem("Linear Transformation", [
  Let $VV "and" WW$ be vector spaces. A transformation $T:VV -> WW$ is called _linear_ if:
+ $T(vec(u) + vec(v)) = T(vec(u)) + T(vec(v))$
+ $T(a vec(v)) = a T(vec(v))$ for all $vec(v) in VV$ and all scalars $a in FF$.

])

#problem("Basis, Span and Linear Independence", [

])

//$ colvecmat(b_1, b_2, b_n, dots: #true) $

//#rect($A$, width:4%, fill: red.lighten(70%))

//#square(size:30pt, fill:blue.lighten(70%), stroke:0.5pt)[#align(center + horizon)[$A$]]


//$ (#square(size:30pt, fill:blue.lighten(70%), stroke:0.5pt)[#align(center + horizon)[$A$]]) $

= Matrix Multiplication
== Matrix-Vector
== Matrix
== Inverses
#solution("Inverses", [
  Left Invertible: $A$ is invertible if there exists B such that $B A = I$

  Right Invertible: $A$ is invertible if there exists C such that $A C = I$

  Example: $ mat(0.5, 0.5) mat(1;1) = mat(1, 0; 0, 1) $ 

  Invertible: $A$ is invertible if both $B$ and $C$ exist.

  #cl() If a linear transformation is invertible, then its left and right inverses coincide and are unique. 

  #pf() $ B_1 = B_1 I = B_1 (A B) = (B_1 A) B = I B = B  $
  $ B = B I = B (A C) = (B A)C = I C = C $

  #cl() An invertible matrix is square.
])

= Subspaces
#solution("Subspaces", [
  A _subspace_ of a vector space $VV$ is a non-empty subset of it that is closed under multiplication and addition. $W subset VV$ is a subspace if
  - $vec(w)_1 + vec(w)_2 in W$ for all $vec(w)_1, vec(w)_2 in W$
  - $c vec(w) in W$ for all $vec(w) in W$ and $c in FF$
  Another way to say this is all linear combinations are contained in the subspace. A corollary is that $vec(0) in W$.

  If $X$ and $Y$ are two subspaces, $X inter Y$ is also a subspace.

  $ X+Y =^"def" {vec(v) | vec(v) = vec(x) + vec(y), x in X, y in Y} $
])
#solution("Some Subspaces", [
  Let $A$ be a linear transformation. 

  The _nullspace_ or _kernel_, denoted $null(A) "or" ker(A)$ is the set of all vectors that satisfy $A vec(x)=vec(0)$.

  The _column space_ or _range_, denoted $col(A) "or" ran(A)$ is the set of all linear combinations of the columns of $A$, that is, the set of all vectors  ${vec(w) | vec(w) = A vec(v), vec(v) in A}$.

  The span of a set of vector $L = {vec(v)_1, vec(v)_2, dots}$ is the set of all its linear combinations. That is, $ span(L) = {sum_i a_i vec(v)_i | a_i in FF, vec(v)_i in L} $

  #underline("Exercise"): Prove that these are subspaces. 
  ])

= Solving Linear Systems

$ mat(delim: #none,
a_(11) x_1, +, a_(12) x_2, +, dots.c, +, a_(1n) x_n, =, b_1;
a_(21) x_1, +, a_(22) x_2, +, dots.c, +, a_(2n) x_n, =, b_2;
dots.v,, dots.v,,,, dots.v,,dots.v;
a_(m 1) x_1, +, a_(m 2) x_2, +, dots.c, +, a_(m n) x_n, =, b_m;
) $

We will write this in matrix notation.

$ A vec(x) = vec(b) $

$ A = underbrace(mat(
a_(1 1), a_(1 2), ..., a_(1 n);
a_(2 1), a_(2 2), ..., a_(2 n);
dots.v, dots.v, dots.down, dots.v;
a_(m 1), a_(m 2), ..., a_(m n);
), "Coefficient Matrix") $
$ underbrace(mat(
a_(1 1), a_(1 2), ..., a_(1 n), b_1;
a_(2 1), a_(2 2), ..., a_(2 n), b_2;
dots.v, dots.v, dots.down, dots.v, dots.v;
a_(m 1), a_(m 2), ..., a_(m n), b_m;
augment: #(-1)), "Augmented Matrix") $

We will introduce _row operations_. 