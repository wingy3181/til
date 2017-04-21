# Closures

## Overview
> A closure is an inner function that has access to the outer (enclosing) function's variables even after the outer function has executed. In other words, these functions 'remember' the environment in which they were created.

- A closure has access to three scope chains:
  1. its own
  2. outer functions
  3. global

*Example closure*
```JavaScript
function showName (firstName, lastName) { 
  ​var nameIntro = "Your name is ";
  // this inner function has access to the outer function's variables, including the parameter​
  ​function makeFullName () {         
    ​return nameIntro + firstName + " " + lastName;     
  }
  ​
​return makeFullName (); 
} 
​
showName ("Michael", "Jackson"); // Your name is Michael Jackson 
```

- Closures have access to the outer function’s variable (by reference) even after the outer function returns

## Common uses
- Emulating private methods using [module pattern](https://addyosmani.com/resources/essentialjsdesignpatterns/book/#modulepatternjavascript). For example:
  ```Javascript
  var counter = (function() {
    var privateCounter = 0;
    function changeBy(val) {
      privateCounter += val;
    }
    return {
      increment: function() {
        changeBy(1);
      },
      decrement: function() {
        changeBy(-1);
      },
      value: function() {
        return privateCounter;
      }
    };   
  })();

  console.log(counter.value()); // logs 0
  counter.increment();
  counter.increment();
  console.log(counter.value()); // logs 2
  counter.decrement();
  console.log(counter.value()); // logs 1
  ```
- Event handlers that are dynamic and associated with some data. For example:
  ```Javascript
    function makeSizer(size) {
      return function() {
        document.body.style.fontSize = size + 'px';
      };
    }

    var size12 = makeSizer(12);
    var size14 = makeSizer(14);
    var size16 = makeSizer(16);

    document.getElementById('size-12').onclick = size12;
    document.getElementById('size-14').onclick = size14;
    document.getElementById('size-16').onclick = size16;
  ```


## Common mistakes
- Anonymous functions within loops
  - By the time the anonymous function is invoked, the last iteration of the loop has modified the same outer variable reference which is used by all iterations of the loop
  ```Javascript
  function celebrityIDCreator (theCelebrities) {
    var i;
    var uniqueID = 100;
    for (i = 0; i < theCelebrities.length; i++) {
      theCelebrities[i]["id"] = function ()  {
        return uniqueID + i;
      }
    }

    return theCelebrities;
  }
  ​
  ​var actionCelebs = [{name:"Stallone", id:0}, {name:"Cruise", id:0}, {name:"Willis", id:0}];
  ​
  ​var createIdForActionCelebs = celebrityIDCreator (actionCelebs);
  ​
  ​var stalloneID = createIdForActionCelebs [0];  console.log(stalloneID.id()); // 103
  ```
  - This can resolved by:
    1. Using an IIFE (Immediately Invoked Function Expression)
    2. Using `let` instead of `var`
    3. Using a function factory
    (See <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures> for more information)


> References
> * [MDN - Closures](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures)
> * [Understand JavaScript Closures with Ease| Feb 2 2013](http://javascriptissexy.com/understand-javascript-closures-with-ease/)
