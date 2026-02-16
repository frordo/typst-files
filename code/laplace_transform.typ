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

= Motivation
How would we come up with the definition of the Laplace transform? We will look into the history of its inventor, Pierre-Simon Laplace. Laplace was studying celestial mechanics, and required probability theory for some of his calculations. In order to count things, he had the idea of _generating functions_. Consider a sequence $a_n$. The generating function of $a_n$ is the following power series, denoted $A(x)$: $ A(x) = a_0 + a_1 x + a_2 x^2 + dots.c = sum_(n=0)^(oo) a_n x^n $ Note that we "transform" a function of $n$ to one of $x$. 

Laplace was also studying difference equations and differential equations at the time, and noticed that difference equations were discrete version of differential equations. So it is perhaps a natural question to ask: is there a continuous version of a generating function? Indeed there is, it is the Laplace transform. Firstly replace $a_n$ with $a(n)$. 
$ A(x) &= sum_(n=0)^oo a(n) x^n\
&= sum_(n=0)^oo a(n) e^(n ln x)\
&=^(s = -ln x) sum_(n=0)^oo a(n) e^(-n s) Delta n $

First we use $e$ instead of $x$ as a base. Since $ln x$ is negative, we replace it by a new variable $-s$. For convergence we would like $0 < x < 1 ==> 0 < s < oo$. Also note that $Delta n$ here is equal to one, since this is a discrete sequence. Now instead consider a function $a(t)$ and let $Delta t -> 0$.
$ A(s) = integral_0^oo a(t) e^(-s t) d t $
which is the Laplace transform.

Now we will see a few properties of generating functions and their Laplace extensions. 
$ text("Sequence") &<--> text("Generating Function")\
(a_0, a_1, dots) &<--> A(x)\
(a_0 + b_0, a_1 + b_1, dots) &<--> A(x) + B(x)\
(0, a_0, a_1, dots) &<--> x A(x)\
(0, 0, dots, "n zeros", a_0, a_1, dots) &<--> x^n A(x)\
(1a_1, 2a_2, 3a_3 dots) &<--> A'(x) $

The second property is linearity. 

The fourth property is shifting. The equivalent laplace property can be seen by letting $ln x = - s$ or $x = e^(-s)$ we get $LL(f(t-a) u(t-a)) = e^(-a s) F(s)$.

The fifth property states that $LL(t f(t)) = -F'(s)$. When taking the derivative there's a negative sign because $x = e^(-s)$.

Derivative in the discrete world are instead finite differences. So $(d f)/(d t)$ would correspond to $(Delta a)/ (Delta n) = a_(n+1) - a_n$. So the sequence $ (a_1 - a_0, a_2 - a_1, dots) <--> ((1-x)A(x) - a_0) / x $
...incomplete. Similarish x/1-x factor comes when integrating (ie summing)

Another way to motivate the convolution theorem is to first see it in generating functions. Let $a_n$ and $b_n$ be two sequences. Then let $C(x) = A(x) B(x)$. Then the coefficients of $c_n$ are given by $ c_n = sum a_k b_(n-k) = a*b. $

Which is a convolution! And similarly $LL(f*g) = F(s)G(s)$.

An example of a difference equation is $a_(n) - a_(n-1) = a_(n-2)$, with $a_0 = 0$ and $a_1 = 1$. A way of solving this equation is to let $A(x)$ be the generating function of $a_n$. So 
$ a_(n) - a_(n-1) &= a_(n-2)\
a_(n) x^n - a_(n-1) x^n &= a_(n-2) x^n\
sum_(n=2)^oo a_(n) x^n - sum_(n=2)^oo a_(n-1) x^n &= sum_(n=2)^oo a_(n-2) x^n\
(A(x) - a_0 - a_1 x) - (x A(x)) &= x^2 A(x)\
A(x) &= x / (1 - x - x^2) $

Now by analyzing A(x), we can find the coefficients of $x^n$ which is $a_n$ by definition. 

to-dos

heaviside's method (D operator)
ref: Princeton companion to math
finish up gen fucntion argument
more to do: https://3x10e8.wordpress.com/wp-content/uploads/2014/01/laplace-transform-motivation.pdf

"laplace transform diagonalizes the derivative operator"??