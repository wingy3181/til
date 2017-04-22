# Twelve Ways to Make Code Suck Less

## Overview

- Why should we care about code quality?
  - We can't be agile if our code sucks
  - Code is how we tell our colleagues how we feel about them.
    - Although I think people need to separate themselves from the code and their egos
  - ["Lowering quality lengths development time." - First Law of Programming](http://c2.com/cgi/wiki?FirstLawOfProgramming)
- What's Quality Code?
  - The quality of code is inversely proportional to the effort it takes to understand it.
    - [Reference](http://blog.agiledeveloper.co/2010/05/throughts-through-tweets_15.html)

## The Twelve Ways

- **12.** _Schedule Time to Lower Technical Debt_

  - Need to identify
  - Need to prioritise highest paying interest debt
  - Need to avoid technical bankruptcy by:
    - Handling it a long the way an by scheduling time for it
      > - **Just because you can't pay it all doesn't mean you shouldn't pay nothing off**
      > - **"A freeway packed with cars turns into a parking lot" - _Linda Rising_**
      >   - In regards to scheduling work in a sprint and not overloading it just with work items.
      >     Otherwise no time to innovate as well as lower technical debt
      > - **When people have more slack time, culture develops**
      >   - In reference to the book "Guns, Germs and Steel by Jared Diamond" which talks
      >     about when human civilisation developed from when we were savages hunting for food every day
      >     to when we found about agriculture, we had more spare time instead of hunting every day. this
      >     let us be more creative and innovative and create culture.

- **11.** _Favor High Cohesion_

  - Like things together, unlike things apart
  - Why? Reduces frequency of change

- **10.** _Favor Loose Coupling_

  - Tight coupling makes code:
    - hard to extend
    - hard to test
  - Remove dependencies and invert (Dependency injection)

- **9.** _Program with Intention_

  > [Best code comment:](http://stackoverflow.com/questions/184618/what-is-the-bestcomment-in-source-code-you-have-ever-encountered)
  > ```
  > // When I wrote this, only God and I understood what I was doing
  > // Now, God only knows
  > ```    

  - Use TDD (writing test first) to help program your intention

- **8.** _Avoid Primitive Obsession_

  - Don't go too low level in terms of logic for most things
  - First look at language itself for any libraries/API, then look for widely used and mature external libraries
  - **Imperative code is packed with accidental complexity**
    - **Prefer declarative (what to do) over imperative (how to do)**
    - **A good code should read like a story, not like a puzzle**
    - [functional = declarative + higher order function](http://blog.agiledeveloper.com/2015/08/the-functional-style.html)

- **7.** _Prefer Clear Code over Clever Code_

  > `Programs must be written for people to read, and only incidentally for machines to execute`  - Abelson and Sussman
  >
  > `There are two ways of constructing a software design. One way is to make it so simple that there are obviously no
  >  deficiencies and the other is to make it so complicated that there are no obvious deficiencies` — Tony Hoare

  - **10% of the time, we write ugly code for performance reasons, the other 90% of the time, we write ugly code to be consistent.**
  - **Those who sacrifice quality to get performance may end up getting neither.**



- **6.** _Apply Zinsser's Principle on Writing_

  - From 'On Writing Well' book by William Zinsser
    - Simplicity
    - Clarity
    - Brevity
    - Humanity

- **5.** _Comment Why, not What_

  - Write self-expressive code with meaningful variables and function names and using SLAP
  - **A good code is like a good joke**

- **4.** _Avoid Long Methods—Apply SLAP_

  - **Turns out long is not all about length of code, but levels of abstraction**
  - SLAP = Single Level of Abstraction Principle

- **3.** _Give Good Meaningful Names_

  - **If we can't name a variable or a function appropriately, it may be a sign we've not yet understood its true purpose**

- **2.** _Do Tactical Code Reviews_

  - Needs to be "valuable" or some kind of benefit to people to encourage team to do code reviews properly
  - Use "compliment sandwich" and what can be done better when giving code reviews

- **1.** _Reduce State & State Mutation_

  - Mutability of state and bugs commonly go hand in hand

## Conclusion

> "The first step in becoming a better programmer is to let go of the conviction that we can code it once
> and get it right on the first write." - Venkat Subramaniam
>
> "What is important is not how fast you can write the code but how fast you can help other people read the code" - Venkat Subramaniam

<hr/>
<br/>
<br/>

> References
> * [Devoxx - Twelve Ways to Make Code Suck Less by Venkat Subramaniam | 10 Nov 2016](https://youtu.be/nVZE53IYi4w)
>   * [Slides](https://www.agiledeveloper.com/presentations/twelve_ways_to_make_code_suck_less.pdf)
