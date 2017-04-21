# Promises

## Background

### Dealing with asynchronous code via callbacks

``` Javascript
// Synchronous
function getUser(name) {
  var sql = 'SELECT * FROM users WHERE name=?';
  var user = query(sql, name); // <- blocking
  if (!user) throw new Error('no user!');
  return user;
}

// Asynchronous with callbacks
function getUser(name, callback) {
  var sql = 'SELECT * FROM users WHERE name=?';
  query(sql, name, function(error, user) { // <- common pattern with callbacks where first argument is error, second argument is the result
    if(error) {
      callback(error);
    } else if(!user) {
      callback(new Error('no user!'))  ;
    } else {
      callback(null, user);
    }
  })
}
```
- Dealing with asynchronous processing and attempting to use callbacks to solve this has deprived us of the use of `return`, `throw` and the call stack. Instead, our program's entire flow is based on side effects: one function incidentally calling another one.
- Using a callback for asynchronous code actually means:
  - There is **no return** (as in no one can receive the return value)
  - There is **no throw** (as in no one can catch it because callback executes on a brand new call stack. See [event loop TIL](../js/event-loop.md))
  - There is **no stack**
  - There is **no guarantee** on how callback is invoked
    - Is it invoked more than once? only once? never?
    - Is it invoked with the same arguments all the time? first parameter as an error? the second as the result? but never both?
- Running parallel asynchronous processing is very convoluted
- Running serial asynchronous processing you will encounter the [pyramid of doom](https://medium.com/@wavded/managing-node-js-callback-hell-1fe03ba8baf)
- Functions can basically do three things:
  1. return a value
  2. throw an error
  3. have side effects

## In the Future with Generators
- Generators is a way in the future to do asynchronous processing (look into this more later)
  - `yield` keyword to pause execution
  - `.next()` method to continue execution

## For now with Promises

- A promise is a software abstraction/another API that makes working with asynchronous operations easier
  - It is an object that represents the eventual results of an operation (generally asynchronous)
- Gives back `return`, `throw` and the stack which allows us to write asynchronous code like synchronous code. See examples below:

```Javascript
getUser('mjackson', function(error, user) {
  //...
});

// becomes

getUser('mjackson')
  .then(function(user) {
    //...
  })
  .catch(function(error) {
    //...
  });
```

```Javascript
var user = getUser('mjackson');
if (!user) throw new Error('no user!');
var name = user.name;

// becomes

getUser('mjackson').then(function(user) {
  if (!user) throw new Error('no user!');
  return user.name;
});
```


```Javascript
try {
  deliverTweetTo(tweet, 'mjackson');
} catch (error) {
  handleError(error);
}

// becomes

deliverTweetTo(tweet, 'mjackson')
  .then(undefined, handleError);
```

```Javascript
try {
  var user = getUser('mjackson');
} catch (error) {
  throw new Error('ERROR: ' + error.message);
}

// becomes

getUser('mjackson');.then(undefined, function(error) {
  throw new Error('ERROR: ' + error.message);
});
```

## Common mistakes
- Rookie mistake #1: the promisey pyramid of doom
- Rookie mistake #2: WTF, how do I use forEach() with promises? Use Promise.all()
- Rookie mistake #3: forgetting to add .catch()
- Rookie mistake #4: using "deferred"
- Rookie mistake #5: using side effects instead of returning
- Advanced mistake #1: not knowing about Promise.resolve()
- Advanced mistake #2: catch() isn't exactly like then(null, ...)
- Advanced mistake #3: promises vs promise factories
- Advanced mistake #4: okay, what if I want the result of two promises?
- Advanced mistake #5: promises fall through

## [Anti-patterns](https://github.com/petkaantonov/bluebird/wiki/Promise-anti-patterns#the-deferred-anti-pattern)
- The Deferred anti-pattern
  - Useless "deferred" objects that complicate code for no reason
- `.then(success, fail)` anti-pattern
  - If error thrown from parallel success handler, it is not caught by the error handler. Use `.catch(fail)` instead

## Puzzles
```
Puzzle #1

doSomething().then(function () {
  return doSomethingElse();
}).then(finalHandler);
Answer:

doSomething
|-----------------|
                  doSomethingElse(undefined)
                  |------------------|
                                     finalHandler(resultOfDoSomethingElse)
                                     |------------------|
Puzzle #2

doSomething().then(function () {
  doSomethingElse();
}).then(finalHandler);
Answer:

doSomething
|-----------------|
                  doSomethingElse(undefined)
                  |------------------|
                  finalHandler(undefined)
                  |------------------|
Puzzle #3

doSomething().then(doSomethingElse())
  .then(finalHandler);
Answer:

doSomething
|-----------------|
doSomethingElse(undefined)
|---------------------------------|
                  finalHandler(resultOfDoSomething)
                  |------------------|
Puzzle #4

doSomething().then(doSomethingElse)
  .then(finalHandler);
Answer:

doSomething
|-----------------|
                  doSomethingElse(resultOfDoSomething)
                  |------------------|
                                     finalHandler(resultOfDoSomethingElse)
                                     |------------------|
```


> References
> * 👍 [NewCircle Training | 1 May 2013 - Redemption from Callback Hell](https://www.youtube.com/watch?v=hf1T_AONQJU&feature=youtu.be)
>   * [Oct 14 2012 - You're missing the point of promises](https://blog.domenic.me/youre-missing-the-point-of-promises/)
> * 👍 [PouchDB | 18 May 2015 - We have a problem with promises](https://pouchdb.com/2015/05/18/we-have-a-problem-with-promises.html)
> * 👍 [14 Aug 2015 | Promise anti-patterns](https://github.com/petkaantonov/bluebird/wiki/Promise-anti-patterns#the-deferred-anti-pattern)
> * [MDN - Promise API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)
> * [Promises/A+ spec](https://promisesaplus.com/)
> * 👍 [Promises visualisation](https://bevacqua.github.io/promisees/)
> * 👍 [Sindresorhus' promise modules & useful promise patterns](https://github.com/sindresorhus/promise-fun)
>   * [Pify - Promisify a callback-style function](https://www.npmjs.com/package/pify)
