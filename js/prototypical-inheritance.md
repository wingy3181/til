# Prototypical inheritance

## Overview

- Javascript remains **prototype** based and only has one construct: **objects**
- Objects inherit from other objects
  - A function is a first class citizen and is also an object
  - Objects inherit from each other using the **prototype chain**
    - This can be accessed via the accessors `Object.getPrototypeOf()` and `Object.setPrototypeOf()`
    - This can also be accessed via the non-standard way by using the `__proto__` Javascript property
      of an object
    - When trying to access a property or method of an object, the property will not only be sought
      on the object but on the prototype of the object, the prototype of the prototype, and so on until
      either a property with a matching name is found or the end of the prototype chain is reached.
    - When trying to set a property of method of an object, the property will be created as an own
      property (except when there is an inherited property via a [getter or setter](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Working_with_Objects#Defining_getters_and_setters))
    - Note the difference between `<func>.prototype` which specifies the `[[Prototype]]` to be assigned
      to all instances of objects created by the given function when used as a constructor. Where as
      `<object>.__proto__` is the prototype currently referenced by the object.
- By convention, functions that are meant to be used as constructors are generally capitalized.
- Prototype chains can be created by:
  - Existing objects created through syntax contructs such as `{}` (objects), `[]` (arrays), function,
    etc.
  - Using `prototype` property from a constructor function
  - Using `Object.create`
  - Using `class` keyword
- Use `hasOwnProperty` to check whether an object has a property defined on itself and not
  somewhere on its prototype chain.
- Avoid extension of native prototypes such as `Object` and `Array` (unless backporting features
  of newer Javascript engines)
- Be aware of the length of the prototype chains in your code and break them up if necessary to
  avoid possible performance problems.

> References
> * [Prototypal Inheritance in JavaScript](https://medium.com/@kevincennis/prototypal-inheritance-781bccc97edb)
> * [MDN - Inheritance and the prototype chain](https://developer.mozilla.org/en/docs/Web/JavaScript/Inheritance_and_the_prototype_chain)
