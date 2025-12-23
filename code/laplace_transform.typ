#import "@preview/lovelace:0.3.0": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"

#set document(
  title: [Laplace Transform Notes],
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
#let LL(x) = $cal(L){#x}$
#let LLI(x) = $cal(L)^(-1){#x}$

= What's the Point?
Differential equations are annoying to solve. Piecewise/discontinuous functions are also annoying. The Laplace transform is here to save the day!

= Definition

#solution("Definitions", [
  The _Laplace transform_ is an operation that takes a function of a real variable (usually $t$) as input and outputs a function of a complex variable $s$. If $f(t)$ is our original function, $F(s)$ is its transform.

  $ LL(f(t))(s) = F(s) =^("def") integral_0^oo f(t) e^(-s t) d t $

  There is a slight caveat. The above integral may not converge. We will ignore this for now.

])

#problem("Example 1", [
  Calculate $LL(e^(a t))$.

  $ LL(e^(a t)) &= integral_0^oo e^(a t) e^(-s t) d t \
  &= 1/(s-a)
  $

  This is not exactly correct. The integral converges only when $Re(s) > a$. But we will wave our hands and simply say $ LL(e^(a t))(s) = 1/(s-a) "for" s != a $
])

= Properties of the Laplace Transform
== Linearity

#solution("Linearity", [
  The Laplace transform is linear!
  $ LL(a f + b g) = a LL(f) + b LL(g) $
  which follows from the linearity of integrals.
])

== Existence

#solution("Existence Theorem", [
  A function $f$ is of _exponential order_ if $|f(t)| <= M e^(c t)$ for some positive $M$ and $c$. 

  If $f$ is continuous and of exponential order with constant $c$, then $LL(f)$ exists for all $s>c$. Proof follows by comparison.
])

== Unique and Invertible

#solution("Existence Theorem", [
  Two integrable functions have the same Laplace transform if they differ on a set of Lebesgue measure zero. For example, if two functions are different at only finitely many points, they have the same Laplace transform.

  We will define an inverse operation $ LLI(F(s))  = f(t) $
])

= Some Useful Laplace Transforms

#problem("Table of transforms", [
  Assume $f$ is sufficiently nice.
$ LL(e^(a t)) &= 1/(s-a) "for" s != a\ 
  LL(sin a t) &= a/(s^2+a^2)\
  LL(cos a t) &= s/(s^2 + a^2)\
  LL(t^n) &= Gamma(n+1)/s^(n+1)\
  LL(u(t-a)) &= e^(-a s)/s "where" u "is the Heaviside step function"\
  LL(delta(t-a)) &= e^(-a s)\
  LL(u(t-a)f(t-a)) &= e^(-a s)F(s)\
  LL(f(t)) &= 1/(1-e^(-s p)) integral_0^p e^(-s tau) f(tau) d tau "where" p "is the period"\
  LL(f'(t)) &= s F(s) -f(0)\
  LL(f''(t)) &= s^2 F(s) - s f(0) - f'(0)\
  LL(f^((n))(t)) &= s^n F(s) - s^(n-1) f(0) - dots.c - s f^((n-2))(0) - f^((n-1))(0)\
  LL(integral_0^tau f(tau) d tau) &= F(s)/s\
  LL(e^(-a t)f(t)) &= F(s-a) "(the shift property)"\
  LL(f*g) &= F(s) G(s)
  $
])

= Misc Notes
$ LL(g) -> "use by parts" $
$ LL(integral_0^t) -> "change order of integration, otherwise convulution" $

$ (f*g)(t) =^("def") integral_(-oo)^oo f(tau) g(t-tau) d tau $

$ LL(f*g) = F(s) G(s) $

Set $G = 1$ (the step function) and the result follows.

This holds for nested integrals! $ LL(integral^n) = F(s)/s^n $. This is true by Cauchy's repeated integration formula, and then convolution theorem.