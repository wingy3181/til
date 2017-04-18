# Methods within versus prototype for constructor functions

## Overview

### *<u>Methods within constructor function</u>*
```Javascript
function Person(name, family) {
    this.name = name;
    this.family = family;
    this.getFull = function () {
        return this.name + " " + this.family;
    };
}
```

#### Pros
- Faster execution time invoking methods as need to check prototype chain to
  find method (However, this is not very significant unless we have a deep prototype
  hierarchy).

#### Cons
- More memory as every new instance created will re-declare and attach the method
  (NOTE: However, this is getting better with V8 engines optimization)

### *<u>Methods within `prototype`</u>*
```Javascript
function Person(name, family) {
    this.name = name;
    this.family = family;
}

Person.prototype.getFull = function() {
    return this.name + " " + this.family;
};
```

#### Pros
- Less memory as `prototype` allows us to define methods to all instances in one location.
  This is because objects coming from the same constructor point to the one common prototype
  object.
- Faster execution time to create objects as no time spent on re-declaring any methods.


## Conclusion

Sometimes a hybrid of both approaches may be required. For example, if we wish not to
publicly expose parameters. See example below, where `records` is not exposed publicly.

```Javascript
function Person(name, family) {
    this.name = name;
    this.family = family;

    var records = [{type: "in", amount: 0}];

    this.addTransaction = function(trans) {
        if(trans.hasOwnProperty("type") && trans.hasOwnProperty("amount")) {
           records.push(trans);
        }
    }

    this.balance = function() {
       var total = 0;

       records.forEach(function(record) {
           if(record.type === "in") {
             total += record.amount;
           }
           else {
             total -= record.amount;
           }
       });

        return total;
    };
};

Person.prototype.getFull = function() {
    return this.name + " " + this.family;
};

Person.prototype.getProfile = function() {
     return this.getFull() + ", total balance: " + this.balance();
};
```

> References
> * [The Code Ship - Methods Within Constructor vs Prototype in Javascript](http://thecodeship.com/web-development/methods-within-constructor-vs-prototype-in-javascript/)
