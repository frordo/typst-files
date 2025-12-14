#import "@preview/lovelace:0.3.0": *
#import "@preview/showybox:2.0.4": showybox


#set document(
  title: [#link("https://cses.fi/problemset/list/")[CSES] Introductory Problems],
  date: auto,
)
#show title: set text(size: 17pt)
#show title: set align(center)
#title()
#align(center)[#link("https://github.com/frordo")[#smallcaps("Frordo")]]
#let calO(x) = $𝒪(#x)$

This is a Typst adaptation of my #link("https://frordo.github.io/posts/CSES-Introductory/")[website]. Watch out for hyperlinks; a lot of things are clickable.

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

#let hline = {

line(length: 100%)

  }
#problem(link("https://cses.fi/problemset/task/1068")[Problem 1], [
Consider an algorithm that takes as input a positive integer $n$. If $n$ is even, the algorithm divides it by two, and if $n$ is odd, the algorithm multiplies it by three and adds one. The algorithm repeats this, until $n$ is one. For example, the sequence for $n=3$ is as follows:
$
3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
$
Your task is to simulate the execution of the algorithm for a given value of $n$.

])

This is fairly straightforward. We will just do as we are told:

#solution("Solution 1", 
[ #pseudocode-list(hooks: .5em)[
  + *while* $n > 1$
    + *if* $n$ is odd
      + $n <- n/2$
    + *else*
      + $n <- 3 n + 1$
]
])

#hline

#problem(link("https://cses.fi/problemset/task/1083")[Problem 2], [
You are given all numbers between $1,2,..., n$ except one. Your task is to find the missing number.


])

My first thought was to loop through the list, storing which values we encounter. But we can do better! Sum the list and compare it with $n(n+1)/2$.

#solution("Solution 2", 
[ #pseudocode-list(hooks: .5em)[
  + $s <- 0$
  + *for* $i$ in _nums_
    + $s <- s + i$
  + *return* $(n(n+1))/2 - s$
]
])

#hline

#problem(link("https://cses.fi/problemset/task/1069")[Problem 3], [
You are given a DNA sequence: a string consisting of characters A, C, G, and T. Your task is to find the longest repetition in the sequence. This is a maximum-length substring containing only one type of character.
])

This is asking us to find the length of the maximal contiguous subsequence. Since only the length is asked, we can simply loop through the list, count the length of each block of letters, and update if necessary.

#solution("Solution 3", 
[ #pseudocode-list(hooks: .5em)[
  + max_length $<- 0$
  + temp $<- 0$
  + *for* $i$ in _len(string)_
    + if string()
  + *return* $(n(n+1))/2 - s$
]
])

#hline