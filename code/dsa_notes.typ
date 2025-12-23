#import "@preview/lovelace:0.3.0": *
#import "@preview/showybox:2.0.4": showybox

#set document(
  title: [Data Structures and Algorithms],
  date: auto,
)
#show title: set text(size: 17pt)
#show title: set align(center)
#title()
#align(center)[iactavis]
#let calO(x) = $𝒪(#x)$
#let Omega(x) = $Ω(#x)$
#let Theta(x) = $Θ(#x)$
#set heading(numbering: "I. i. ")

#let definition(title, body) = {
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

#let problem(title, body) = {
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
= Why Study DS&A?

Problem: We have a lot of data. We have a finite amount of computing power, time and memory. We require fairly complicated things from our raw datasets. The question arises--how do we store data? Solution: we develop data structures and associated algorithms to suit our needs.  

= Asymptotic Complexity

We would like to compare of two algorithms, which grows faster? We would like to compare the scalability of two algorithms. We therefore define an upper-bound, lower-bound and both.

#definition("Definition 1", [
Let $f$ and $g$ be functions from $RR_(>=0) -> RR_(>=0)$. We say that $f(x) = calO(g(x))$ if there exist positive $x_0$ and $c$ such that for all $x > x_0$, $f(x) <= c g(x)$. Another way of saying this is $f/g$ is eventually bounded.

An alternative convention is to say $calO(g(x))$ is the set of all functions $hat(f)$ such that $hat(f) = calO(g(x))$. So we may instead say $f in calO(g(x))$.
])

#definition("Definition 2", [
Let $f$ and $g$ be functions from $RR_(>=0) -> RR_(>=0)$. We say that $f(x) = Omega(g(x))$ if there exist positive $x_0$ and $c$ such that for all $x > x_0$, $c g(x) <= f$. $g$ will eventually become a lower bound of $f$.

As before, $f in Omega(g(x))$.
])

#definition("Definition 3", [
If $f = calO(g)$ and $f = Omega(g)$, we say that $f = Theta(g)$.  
])

#definition("Definition 4", [
#align(center)[#table(
  columns: (auto, auto),
  inset: 5pt,
  align: horizon,
  table.header(
    [*Complexity*], [*Name*],
  ),
  $calO(log n)$,[logarithmic],
  $calO(n)$,[linear],
  $calO(n^2)$,[quadratic],
  $calO(n^3)$,[cubic],
  $calO(n^("constant"))$,[polynomial],
  $calO(e^n)$,[exponential],
  $calO(n!)$,[factorial],
)]
])


== Constant Factors 

The $Theta(f)$ system only cares about asymptotic time complexity, but not about actual running time. To give an example, consider $f(x) = 10^100 x $ and $g(x) = x$. Then $f = Theta(g)$ but the running time of $f$ is impractical. So even if an algorithm is better asymptotically, it need not be better in practical use. It only guarantees that it will be better for large datasets. We will see examples of this later.

= Basic Data Structures

= Sorting

#problem("Problem", [
Given a sequence of numbers $A = (a_i)_(i=1)^n$ and a _total ordering_ on $A$, denoted by $<=$, return a permutation of $A$, say $A'$, that satisfies $a_1^' <= a_2^' <= dots.h.c <= a_n^'$.

For example, consider the sequence $(26, 58, 31, 41, 67, 41)$ and the order to be the ascending order. Then the expected output is $(26, 31, 41, 41, 58, 67)$.

A _total ordering_ $<=$ satisfies
+ $a <= a$ (reflexive)
+ if $a <= b$ and $b <= c$ then $a <= c$ (transitive)
+ if $a <= b$ and $b <= a$ then $a = b$ (antisymmetric)
+ $a <= b$ or $b <= a$ (totality)
])

We will usually use numeric or lexographic sorting. 
