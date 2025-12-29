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

In the first few drafts of this I intended it to be a reference but it has taken control and transformed into more of an expository one. Largely inspired by Kevin Zhou and Evan Chen's notes.

*TODO*: cover/title page. citations! fix colors (pick a palette?)

= Introduction

In our first semester we learnt a bit of _operational calculus_ where we declared $d/(d t) = D$ and then manipulated $D$ algebraically. For instance $ 1/D = D^(-1) = integral $
$ D/(D-a) = 1/(1-a/D) = sum a^n D^(-n) = e^(a t) $
and other such atrocities. Oliver Heaviside, who developed operational calculus, faced criticism for this lack of rigor, to which he replied, _'Shall I refuse my dinner because I do not fully understand the process of digestion?'_ Here we seek to understand the process of digestion.

The _Laplace transform_ will attempt to set this on a rigorous foundation. Instead of differentiation being treated as multiplication by $D$, the Laplace transform will convert differentiation in time to multiplication in the $s$ plane.

Like how logarithms convert multiplication to addition, and exponentiation to multiplication, the Laplace transform converts differentiation to multiplication and integration to division.

Another nice thing about the Laplace transform is that it deals with initial conditions and some discontinuous functions.

= History

The Laplace transform is named after Pierre-Simon Laplace, a French mathematician. 

TODO: cut?

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
  LL(ln t) &= (ln s + gamma)/s\
  LL(u(t-a)) &= e^(-a s)/s "where" u "is the Heaviside step function"\
  LL(delta(t-a)) &= e^(-a s)\
  LL(u(t-a)f(t-a)) &= e^(-a s)F(s)\
  LL(f(t)) &= 1/(1-e^(-s p)) integral_0^p e^(-s tau) f(tau) d tau "where" p "is the period"\
  LL(f'(t)) &= s F(s) -f(0)\
  LL(f''(t)) &= s^2 F(s) - s f(0) - f'(0)\
  LL(f^((n))(t)) &= s^n F(s) - s^(n-1) f(0) - dots.c - s f^((n-2))(0) - f^((n-1))(0)\
  LL(integral_0^tau f(tau) d tau) &= F(s)/s\
  LL(e^(a t)f(t)) &= F(s-a) "(the shift property)"\
  LL(f*g) &= F(s) G(s)\
  LL(t f(t)) &= -F'(s)\
  LL(f(t)/t) &= integral_s^oo F(s') d s'
  
  $
])

#solution("Initial and Final Value Theorems", [
  *Initial Value Theorem*: $ lim_(s -> oo) s F(s) = f(0^+) $
  Proof:
  $ lim_(s -> oo) s integral_0^oo e^(-s t) f(t) d t &=^(t -> t/s ) lim_(s -> oo)integral_0^oo  e^(-t) f(t/s) d t =   integral_0^oo lim_(s -> oo)  e^(-t) f(t/s) d t = f(0^+) $
Alternatively,
  $ LL(f'(t)) = s F(s) - f(0^+) $
  $ lim_(s -> oo) => "LHS = 0" => s F(s) - f(0^+) = 0 $
  Exercise: what exactly does $s->oo$ mean if $s$ is complex?

  *Final Value Theorem*:
  $ lim_(s -> 0) s F(s) = f(oo) $
  Note that this holds when all roots of the denominator of $s F(s)$ are negative.
])

= Misc Notes

$ LL(f') -> "use by parts" $
$ LL(integral_0^t) -> "change order of integration, otherwise convulution" $

$ (f*g)(t) =^("def") integral_(-oo)^oo f(tau) g(t-tau) d tau $

$ LL(f*g) = F(s) G(s) $

Set $G = 1$ (the step function) and the result follows.

This holds for nested integrals! $ LL(integral^n) = F(s)/s^n $
This is true by Cauchy's repeated integration formula, and then convolution theorem.

Feynman's trick! $ LL(t f(t)) = -F'(s) $
This generalizes into $t^n f(t)$.

We want to prove $LL(f(t)/t) &= integral_s^oo F(s') d s'$. We will use the same Feynman's trick, again!

$ Q(s') &= integral_0^oo e^(-s t) f(t)/t d t\
(d Q)/(d s') &= - integral_0^oo e^(-s t) f(t) d t = F(s)\
integral d Q &= - integral F(s') d s'
$

Now we want to set appropriate bounds for the above integral. One of the bounds should be $s$, the variable we want. What should the other one be? $0$ doesn't work, the next thing we try is $oo$, since that makes the exponential term zero.
$ integral_s^oo d Q &= - integral_s^oo F(s') d s'\
  Q(s) &= integral_s^oo F(s') d s'
$

Now let's try $LL(ln t)$.

$ integral_0^oo e^(-s t) ln t d t &= lim_(n -> oo) integral_0^(n/s) (1 - (s t)/n)^n ln t d t\
&= lim_(n -> oo) -n/s integral_0^1 x^n ln(n(1-x)/s) d x\
&= lim_(n -> oo) -n/s (integral_0^1 x^n ln(1-x) d x+ integral_0^1 x^n ln (n/s) d x)\
&= lim_(n -> oo) -n/s (-integral_0^1 x^n sum_(j=1)^oo x^j/j d x + ln(n/s) 1/(n+1) )\
&= lim_(n -> oo) -n/s ( -sum_(j=1)^oo integral_0^1 x^(j+n)/j d x + ln(n/s) 1/(n+1) )\
&= lim_(n -> oo) -n/s ( -sum_(j=1)^oo 1/j(j+n+1) + ln(n/s) 1/(n+1) )\
$

Now let us look at that infinite sum
$ sum_(j=1)^oo 1/j(j+n+1) &= 1/(n+1) sum_(j=1)^oo (1/j - 1/(j+n+1))\
&= 1/(n+1) sum_(j=1)^(n+1) 1/j\
&= H_(n+1)/(n+1) $

For large $n$, $H_n ~ ln(n) + gamma$. Using this, 
$ LL(ln t) &= lim_(n -> oo) -n/s ( -sum_(j=1)^oo 1/j(j+n+1) + ln(n/s) 1/(n+1) )\ 
&= lim_(n -> oo) n/s (ln(n/s)-ln(n) - gamma)/(n+1)\
&= #rect()[$ (ln s + gamma)/s $]

$

Alternate method:
$ LL(t^n) &= Gamma(n+1)/(s^(n+1))\
d/(d n) integral_0^oo e^(-s t) t^n d t &= d/(d n) Gamma(n+1)/(s^(n+1))\
d/(d n) integral_0^oo e^(-s t) t^(n) ln t d t &= (s^(n+1) Gamma'(n+1) - Gamma(n+1)s^(n+1) ln s)/s^(2n+2)\
$

Set $n=0$ and compute to get the result. However $Gamma'(1)$ is a little tricky to get, and needs the same series expansion as above.
