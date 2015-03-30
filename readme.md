Fluentify
===

Fluentify is a way to easily make fluent interfaces where the methods can be called in any order.

Installation
---

Via npm: place `fluentify` in the `dependencies` your package.json or run:

````
npm install fluentify
````

Alternatively grab `dist/fluentify.js`. There are no dependencies.

Examples
---

Say you wanted a fluent interface that looks like this:

````coffee
modify(justCats)
  .inStream(animalStream)
  .using(meow)
````

You also don't care which order the methods are called:

````coffee
modify(justCats)
  .using(meow)
  .inStream(animalStream)
````

You can make this work in coffeescript:

````coffee
actualFunction = (predicate, stream, func) ->
  # Your code here

modify = (predicate) ->
  using: (func) ->
    inStream: (stream) ->
      actualFunction(predicate, stream, func)
  inStream: (stream) ->
    using: (func) ->
      actualFunction(predicate, stream, func)
````

However, this gets tedious, especially with more methods. With Fluentify it's easy:

````coffee
modify = fluentify 'inStream', 'using', (predicate, {inStream: [stream], using: [func]}) ->
  # Your code here
````

---

More in depth, made up example:

````coffee
foo(1, 2, 3)
  .bar('a', 'b', 'c')
  .baz('x', 'y', 'z')
````

Would be created using:

````coffee
foo = fluentify 'bar', 'baz', (one, two, three, {
    bar: [ayy, bee, cee]
    baz: [ex, why, zee]}) ->
  # Your code here
````

Fluentify takes a number of method names and a callback. When all the methods have been called, the callback is executed with the
initial arguments being the arguments of the first call, followed by a hash mapping method names to arguments they were called
with. We use coffeescript's nifty destructuring syntax to achieve this.

Immutability
---

You can share partially applied fluent apis safely. Lets use this (contrived) builder example:

````coffee
class Employee
  constructor: (@name, @age, @salary) ->

employeeBuilder = fluentify 'name', 'email', 'age', ({
    name: [name]
    age: [age]
    salary: [salary]}) ->
  return new Customer(name, age, salary)
````

We can now create a template employee with a fixed salary that we can assign names and ages to:

````coffee
tenXDev = employeeBuilder().salary(200000)

dave = tenXDev.name('dave').age(27)
john = tenXDev.age(29).name('john')
````

Hacking
---

Look inside the `Gulpfile` for the various tasks. To get started with autocompilation-and-tests-on-save run:

````
npm install --save-dev
./gulp watch
````

Credits
---

[Joe Lea](https://github.com/joelea) for the original coffeescript fluent interface concept and bouncing off ideas for automating
 the pattern.
