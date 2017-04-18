# Explanation of `this` in Javascript

> ## TL;DR
> Ask yourself:
> - How is the function invoked?
>
> For an arrow function ask yourself:
> - What is this where the arrow function is defined?

## Overview
Javascript has 4 function invocation types:

1. function invocation: `alert('Hello World!')`
2. method invocation: `console.log('Hello World!')`
3. constructor invocation: `new RegExp('\\d')`
4. indirect invocation: `alert.call(undefined, 'Hello World!')`

Each invocation type defines the context in its own way, so `this` behaves slightly differently in each way.

## Function invocation
- In non-strict mode, `this` is the global object determined by the execution content. E.g. In a browser, it is the `window` object
- In strict mode, `this` is `undefined`

```Javascript
function nonStrictSum(a, b) {  
  // non-strict mode
  console.log(this === window); // => true
  return a + b;
}
function strictSum(a, b) {  
  'use strict';
  // strict mode is enabled
  console.log(this === undefined); // => true
  return a + b;
}
// nonStrictSum() is invoked as a function in non-strict mode
// this in nonStrictSum() is the window object
nonStrictSum(5, 6); // => 11  
// strictSum() is invoked as a function in strict mode
// this in strictSum() is undefined
strictSum(8, 12); // => 20  
```

**Be careful of inner functions using `this` and being executed via Function invocation**

> They should be replaced with indirect invocations

```Javascript
var numbers = {  
   numberA: 5,
   numberB: 10,
   sum: function() {
     console.log(this === numbers); // => true
     function calculate() {
       // this is window or undefined in strict mode
       console.log(this === numbers); // => false
       return this.numberA + this.numberB;
     }
     return calculate();
     // Should use .call() method to modify the context
     //return calculate.call(this);
   }
};
numbers.sum(); // => NaN or throws TypeError in strict mode  
```

## Method invocation

- `this` is the object that owns the method in a method invocation (whether it be a method invocation from an object, from an inherited method from its `prototype` or a method on an object created from a class)
- Method invocation is performed when an expression in a form of [property accessor](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Property_accessors) that evaluates to a function object is followed by an open parenthesis (, a comma separated list of arguments expressions and a close parenthesis ).

**Be careful separating method from its object**
> They should be replaced by creating bound function (`bind`)

```Javascript
var extractedLogInfo = myCat.logInfo;  
setTimeout(extractedLogInfo);  
// Should use .bind() to create a bounded function containing the correct context of `this`
//setTimeout(myCat.logInfo.bind(myCat), 1000);
```

## Constructor invocation

- Constructor invocation is performed when `new` keyword is followed by an expression that evaluates to a function object, an open parenthesis `(`, a comma separated list of arguments expressions and a close parenthesis `)`. . For example: `new RegExp('\\d')`.
- `this` is the newly created object in a constructor invocation

**Be careful and make sure to always use `new` when a constructor call is expected**
> If you want, you can add a validation check of `this instanceof <Class>` and throw an error if this is not true

## Indirect invocation

- A function object has: `.call()` and `.apply()` that are used to invoke the function with a configurable context:
  - The method `.call(thisArg[, arg1[, arg2[, ...]]])` accepts the first argument thisArg as the context of the invocation and a list of arguments arg1, arg2, ... that are passed as arguments to the called function.
  - The method `.apply(thisArg, [arg1, arg2, ...])` accepts the first argument thisArg as the context of the invocation and an array-like object of values \[arg1, arg2, ...\] that are passed as arguments to the called function.
- `this` is the first argument of `.call()` or `.apply()` in an indirect invocation

## Bound function

- A bound function is a function connected with an object. Usually it is created from the original function using `.bind()` method. The original and bound functions share the same code and scope, but different contexts on execution.
- `this` is the first argument of `.bind()` when invoking a bound function
- `.bind()` makes a permanent context link and will always keep it. A bound function cannot change its linked context when using `.call()` or `.apply()` with a different context, or even a rebound doesn't have any effect.

## Arrow function

- Has no `name` property (so not useful for recursion or detaching event handlers)
- Does not provide `arguments` object (however, rest parameters `...args` can be used instead)
- `this` is the enclosing context where the arrow function is defined
- An arrow function is bound with the lexical context once and forever. `this` cannot be modified even if using `.call()`, `.bind()` and `.apply()`

**Be careful defining methods on objects with arrow function (even using prototype)**

```Javascript
function Period (hours, minutes) {  
  this.hours = hours;
  this.minutes = minutes;
}
Period.prototype.format = () => {  
  console.log(this === window); // => true
  return this.hours + ' hours and ' + this.minutes + ' minutes';
};
var walkPeriod = new Period(2, 30);  
walkPeriod.format(); // => 'undefined hours and undefined minutes'  
```
> References
> * [Rainsoft - Gentle explanation of `this` in javascript](https://rainsoft.io/gentle-explanation-of-this-in-javascript/)
