#import "@preview/lovelace:0.3.0": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"
#import "@preview/diverential:0.2.0": *

#set document(
  title: [MA11003: Advanced Calculus],
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
#let subhead(x) = [*#text(red.darken(60%))[#x]*]
#let claim() = [*#text(red.darken(100%))[Claim.]*]
#let proof() = [_#text(red.darken(100%))[Proof.]_]
#let ep() = $epsilon$

= Introduction
My typeset notes to our MA11003: Advanced Calculus course, taught in the Autumn Semester, 2025. For a more complete set of notes I will refer you to #underline(link("https://garggopal2001.github.io/cse_material")[CSE2020]). I am told _Advanced Engineering Mathematics_ by Kreyszig is also good. The headings are the same as in the syllabus. Proofs of theorems were not part of the course, but I will give a few that I find are interesting enough.

= Differential Calculus

== Continuity Theorems
I don't want to go too deep into analysis; this is an introductory engineering course! I will note that these proofs depend on a critical property of the reals, called _completeness_. Proofs of these given without first exploring the least upper bound property and sequences are quite uninspiring. 

#solution("IVP and EVT", [
  #subhead("Intermediate Value Theorem") #label("IVT"): If $f$ is continuous on $[a, b]$, then for all $m in (f(a), f(b))$, there exists $l in (a,b)$ such that $f(l) = m$. Alternatively, $f$ maps intervals to intervals.

  #subhead("Extreme Value Theorem")#label("EVT"): A continuous function on a closed set attains a maximum and minimum.
])

== Mean Value Theorems

#solution("Rolle's, Cauchy's, Lagrange's and Taylor's Theorems", [
  #subhead("Rolle's Theorem")#label("Rolle"): If $f$ is continuous on $[a, b]$ and differentiable on $(a,b)$, with $f(a) = f(b)$ then there exists $c in (a,b)$ such that $f'(c) = 0$.

  #subhead("Lagrange's Mean Value Theorem (MVT)")#label("MVT"): If $f$ is continuous on $[a, b]$ and differentiable on $(a,b)$, then there exists $c in (a,b)$ such that $ f'(c) = (f(b)-f(a))/(b-a). $

  #subhead("Cauchy's Mean Value Theorem (CMVT)")#label("CMVT"): If $f, g$ are continuous on $[a, b]$ and differentiable on $(a,b)$, then there exists $c in (a,b)$ such that $ f'(c) = (f(b)-f(a))/(g(b)-g(a)). $

 

  #subhead("Taylor's Theorem")#label("Taylor"): If $f$ is differentiable $n+1$ times on $(a,x)$, with $f^((n))$ continuous on $[a, x]$ then there exists $text(#red, bold(c)) in (a,b)$ such that 
  $ f(x) = underbrace(sum_(i=0)^k (f^((i))(a))/(i!) (x-a)^i, "Taylor Polynomial") + underbrace((f^((n+1))(text(#red, bold(c))))/((n+1)!) (x-a)^(n+1), "Remainder Term") $
])

These are called _mean value theorems_ since they relate to averages. Taylor's theorem is a polynomial version of MVT, hence included here. These theorems have geometrical interpretations. For instance MVT says that there is a tangent parallel to the secant connecting $f(a)$ and $f(b)$.

#problem(subhead(link(label("Rolle"))[Rolle's Theorem]) , [

  We initially have the intuition that the curve "flattens" whenever $f' = 0$. But this is false: consider $f(x) = |x|^3$ at $x = 0$. However notice that minima and maxima do have the property we want. So we propose the following:

  #claim() Let $c$ be a point such that $display(f(c) = max_(a <= x <= b) (f(x)))$. Then $f'(c) = 0$.

  #proof() By the definition of the derivative, $ f'(c) = underbrace(lim_(h -> 0^+) (f(c+h)-f(c))/h, <=0) = underbrace(lim_(h -> 0^-) (f(c+h)-f(c))/h, >=0)
  $
  The numerator is always negative by maximality of $f(c)$. Since $f'(c) <=0 "and" f'(c) >= 0, f'(c) = 0$. A similar claim may be shown for the minima of $f$.  

  Now we would like to apply #subhead(link(label("EVT"))[EVT]). However the function could attain its extrema on the endpoints. To deal with this, pick an $x$ such that $f(x) != 0$. If no such $x$ exists then the theorem is trivially true. 

  $f$ will have an extremum at $c$ by #subhead(link(label("EVT"))[EVT]) in $(a,b)$ (since $f(x) != 0$, we are guaranteed to hit either a minima or a maxima). Now by our claim, the proof is finished. 

])

#problem(subhead(link(label("MVT"))[Mean Value Theorem]) , [
  
  A more comprehensive discussion of the MVT may be found #underline(link("https://www.dpmms.cam.ac.uk/~wtg10/meanvalue.html")[here]).

  The idea is to try to use what we already know to prove the MVT.  

  $ f'(c) = (f(b) - f(a)) / (b-a) <==> f'(c) - (f(b) - f(a)) / (b-a) = 0 $

  So we will consider $g(x) = f(x) - x (f(b) - f(a)) / (b-a)$. I will leave it as an exercise to verify #subhead(link(label("Rolle"))[Rolle's theorem]) on $g$, and to similarly prove #subhead(link(label("CMVT"))[CMVT]).
])

#problem(subhead(link(label("Taylor"))[Taylor's Theorem (REDO)]) , [
  Vaguely speaking, Taylor's theorem is a polynomial mean value theorem. Rearranging MVT we get $f(x+h) = f(x) + h f'(x + t h)$ for some $t in (0,1)$.

  Consider a polynomial $p$ of degree $n+1$ that satisfies:
  - $p^((i))(x) = f^((i))(x)$ for $i = 0, 1, dots, n$
  - $p(x+h) = f(x+h)$
  Consider $g(x) = f(x) - p(x)$. Now $g^((i))(x) = 0$ for $i = 0, 1, dots, n$ and $g(x+h) = 0$. Now by repeated application of Rolle's, $g^((n+1))(x+t h) = 0 => f^((n+1))(x + t h) = "constant"$. 
])

#solved("Example 1", [
  Using #subhead(link(label("CMVT"))[CMVT]), show that $sin x < x$ on $(0, pi/2)$.

  #hline
  $ (sin x )/ x =^("CMVT") cos c < 1 $
])

#solved("Example 2", [
  Using #subhead(link(label("Taylor"))[Taylor's theorem]), calculate $e^0.1$ to $1%$ accuracy.

  #hline
  Using $c < 0.1$,
  $ 1 < e^0.1 = 1 + 0.1 + c^2 / 2 <= 1.015. $
])

If we can analyse the remainder term, we can analyse the error in our approximation.

== Functions of Many Variables

We will not dive too deep into metric spaces and open sets and such. 

#solution("Neighborhoods", [
  We will define the distance between two points the usual way:
  $ d((x_1, y_1), (x_2, y_2)) = sqrt((x_1 - x_2)^2 + (y_1 - y_2)^2) $
  $ d(x_1, x_2) = |x_1 - x_2| $

  The $epsilon$ neighborhood of a point $(a, b)$ is the set of all points that satisfy $d((x, y), (a, b)) <= ep()$.

  The deleted neighborhood of a point does not include the point itself
])

#solution("Limits", [
We say
  $ lim_((x_0, y_0) -> (x, y)) f(x, y) = L $
  if for all $delta>0$ there exists $ep() > 0$ such that $|f(x,y) - L| < ep()$ whenever $sqrt((x - x_0)^2 + (y - y_0)^2) < delta$, that is, any point in the deleted $delta$ neighborhood of $(x_0,y_0)$ gets mapped onto the interval $(L - ep(), L + ep())$.
])

= Integral Calculus

#solution("Improper Integrals", [
We define
  $ integral_0^oo f(x) d x=^"def" lim_(a -> oo) integral_0^a f(x) d x $provided that the limit exists. Similarly, if $f$ is not defined at a point $c$, then
  $ integral_a^b f(x) d x = lim_(i -> c^-) integral_a^i f(x) d x + lim_(j -> c^+) integral_j^b f(x) d x $
  We say that an integral converges if the limit exists.
])

== Tests for Convergence

#solution("Improper Integrals", [
  #subhead("Comparison Test")#label("ct"):
  Suppose $f$ and $g$ are integrable. Suppose $0 <= f(x) <= g(x)$ over an interval $I$. Then 
  $ integral_I g "converges" => integral_I f "converges" $

  #subhead("Limit Comparison Test")#label("lct"):
  Suppose $f$ and $g$ are integrable. Suppose $f(x), g(x) >= 0$ over an interval $[a, oo]$. Let $display(lim_(x -> oo) f(x)/g(x) = c)$

  - If $c$ is finite: $ integral_a^oo g "converges" <==> integral_a^oo f "converges" $ $ integral_a^oo g "diverges" <==> integral_a^oo f "diverges". $
  - If $c = 0$, $ integral_a^oo g "converges" => integral_a^oo f "converges". $

  #subhead("Absolute Convergence")#label("ab"):
   $ integral_I |f| "converges" ==> integral_I f "converges". $

  #subhead("Dirichlet's Test")#label("dt"):
  Suppose $f$ and $g$ are integrable. Let
  + $f(x)$ be decreasing and $lim_(x-> oo) f(x) = 0$.
  + $g(x)$ be continuous and $integral_a^y g(x)d x$ be bounded for all $y > a$.
  Then $ integral_a^oo f(x) g(x) d x "converges". $
])

== Beta and Gamma Functions

#solution("Gamma Function", [
  $ Gamma(n) = integral_0^oo x^(n-1) e^(-x) d x $
  Get used to the $n-1$. Some properties:
  + $Gamma(1) = 1$
  + $Gamma(n+1) = n Gamma(n)$
  + $Gamma(n+1) = n!$
  + $Gamma(z)Gamma(1-z) = pi/sin(pi z)$
])

#solution("Beta Function", [
  $ beta(m, n) = integral_0^1 x^(n-1) (1-x)^(m-1) d x $
  Again, get used to the $-1$'s. Some properties:
  + $beta(m,n) = beta(n,m)$
  + $ beta(m,n)= 2 integral_0^(pi/2) sin^(2m-1)(t) cos^(2n-1)(t) d t $
  + $ beta(m, n) = integral_0^oo x^(m-1)/((1+x)^(m+n)) d x $
  + $ beta(m,n) = (Gamma(m) Gamma(n)) / Gamma(m+n) $
])
== Feynman's Trick and Leibniz's Rule

#solution("Leibniz Rule", [
  Let $ phi(x) = integral_(a(x))^(b(x)) f(x, t) d t. $ Then
  $ (d phi)/(d x) = f(x, b(x)) b'(x) - f(x, a(x)) a'(x) + underbrace(integral_(a(x))^(b(x)) dvp(f(x, t),x) d t, "Feynman's Trick" ) $
])

== The Jacobian
#solution("The Jacobian", [
  $x=phi(u,v)$ $y = psi(u, v)$
  $ J = mat(dvp(x,u), dvp(x,v); dvp(y,u), dvp(y,v)) $
])
= Vector Calculus