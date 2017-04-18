# Temporal Dead Zone

Temporal Dead Zone is the lines of code that cause an error because you cannot access a variable before it is defined.
This is happens with the new ES6 keywords: `let` and `const` that are no longer hoisted to the top (like `var` does)

```Javascript
console.log(a);
let a = 'A variable'
```

> References
> * [Temporal Dead Zone](http://wesbos.com/temporal-dead-zone/)
