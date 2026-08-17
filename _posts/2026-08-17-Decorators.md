---
layout: post
title: "Demystifying Decorators: What are they and why do you need them?"
date: 2023-07-23
categories: [Programming]
description: "Debunking misconceptions about decorators and presenting them in a simple-to-understand, lucid manner"
---

# Demystifying Decorators: What are they and why do you need them?

![](https://miro.medium.com/v2/resize:fit:875/1*bLVASuOHihpXDKLo0n9NfA.png)

While starting out with more advanced topics in Python, one frequently encounters a formidable beast called ‘Decorators’. While students usually learn the syntax and how to use the ‘@’ symbol above function definitions before moving on, decorators are much more fundamental to software design than they seem at first.

Decorators are a software ‘Design Pattern’ in OOPS: they are templates used to solve a specific problem in software design. **Now, what is the problem that we would like to solve?** We would like to have objects that fulfil one small, specific function (in keeping with the *Single Responsibility Principle*) and whose functionality can be **extended** without modifying their code (satisfying the *Open-Closed Principle*). We would also like to be able to add multiple functionalities, flexibly, to objects at runtime without affecting other objects from the same class.

## WHY DECORATORS?

**EXAMPLE**: Suppose you go to buy some pizza. The pizza house has lots of toppings, sauces and vegetables, and allows customers to fully customise their pizzas. **We want to design a software that calculates the price of the pizza based on the customer’s choice of ingredients.**

Now, one intuitive approach to this problem would be subclassing. In this approach, we have a root class called Pizza (with a cost() method), and then we add layers of subclasses to it, with each subclass representing a unique variety of pizza that can be concocted from the given menu. Suppose the available menu is as follows:

**CRUST**: More cheese, Less cheese

**TOPPINGS**: Chilli flakes, black pepper, oregano, Sriracha

**VEGGIES**: Onions, tomatoes, black/green olives, smoked beans, pineapple

**NON-VEG**: Grilled chicken, smoked ham

Of course, each individual item has its own price which gets added to a base price.

![](https://miro.medium.com/v2/resize:fit:875/1*2Se0E_Tj0VKKrP9k9hvHDg.png)

The subclassing approach, with just a few subclasses from the second layer shown.

We have two classes, ‘*More cheese*’ and ‘*Less cheese’*, which inherit from the Pizza class, but with their own cost() methods. Further, we will have another layer with added on toppings, which will contain pizzas like ‘*More cheese with chilli flakes and black pepper’*, ‘*More cheese with oregano*’ etc., each with their own cost()s. But we will also need to add in this layer, pizzas like ‘*More cheese with tomatoes and grilled chicken*’ to cater to people who might not want toppings but may want veggies and non-veg.

The third and fourth layers will have pizzas like ‘*Less cheese with Sriracha, onions and black olives*’ and ‘*More cheese with oregano, chilli flakes, onions, tomatoes, and smoked chicken*’ (sounds tasty, by the way!) respectively. If we count the number of subclasses in these two levels in the hierarchy, even after ignoring customers who may want to skip a layer, we get 31 x 30 = 930 and 3 x 930 = 2790 subclasses. So, with this approach:

- The number of subclasses is simply overwhelming, and maintaining the code is going to be a mountain of a task for the developer team. Just writing the cost() methods in each of these classes to overwrite that of their parent class is a huge task. This scenario is called a **Class Explosion.**
- Any modification to the price of any item will send shockwaves throughout the code, as the cost() methods of all the pizzas that contain this item will have to be modified again.
- Similarly, adding an item to a level, say Tomato Sauce to Toppings, is also going to be a big endeavour, as you’ll have to write a whole lot of classes and cost() methods.

***Thus, this approach may be theoretically possible, but is extremely resource-intensive, not at all scalable and thus, NOT USEFUL AT ALL.***

## ENTER DECORATORS.

Decorators are a kind of wrapper for objects. They take the input, add functionality (if needed), pass it to the wrapped object, take output from the object, add functionality (if needed) and output to the environment.

![](https://miro.medium.com/v2/resize:fit:875/1*CTXNQyElJfWmHsGc4qBjbA.png)

The UML diagram for the Decorator Pattern (source: *Wikipedia*)

The ‘*Component*’ class is usually either an interface or an abstract class. ‘*ConcreteComponent*’ represents the instantiable class(es) which inherit(s) from ‘*Component*’.

Now we define a ‘*Decorator*’ class **which also inherits from the ‘*Component*’.** We pass the instance of ‘*ConcreteComponent*’ to be decorated to the Decorator. We want the user to feel as if they are working with the actual object and not the decorator (interacting with decorators instead of the expected object can complicate things from the user’s POV). This is why, in order to make the decorator **transparent**, the decorator inherits from the same class as the ‘*ConcreteComponent*’. Thus, a decorator both ‘is’ a ‘component’ (by virtue of having the same interface as the ‘*ConcreteComponent*’), and also ‘has’ a ‘component’ (the instance that is passed to it).

The decorator contains the same methods as the object (‘*ConcreteComponent’*) and these methods are overridden to forward the method calls to the method of the same name in the ‘*ConcreteComponent’* instance passed to it. The ‘*ConcreteDecorator*’ is a subclass of the decorator class which implements specific add-on functionalities by inheriting from the decorator class.

So, in essence, decorators are like ***transparent wrappers for objects***, in that they add functionality but look and feel like the original object to the outside environment. Since we pass only a specific *instance* of a class to the decorator, other objects from the same class are not affected.

![](https://miro.medium.com/v2/resize:fit:875/1*iCf6AIBPYUMtqW-RwN2Vlw.png)

Another example: the idea for one is taken from *Design Patterns: Elements of Reusable Software by E. Gamma et al.*

In the above example, we create a root class for handling Visual Displays which lets the user draw on the screen with the Draw() method, with a concrete implementation being a text document. Now in the decorator class, the Draw() method is overridden to call the Draw() method of the component that is passed to it. Then we implement this pattern into two ConcreteDecorators, a ScrollDecorator (which adds scroll bars) and a BorderDecorator (which adds a black border).

The other methods of *ConcreteDecorator* are not shown, but we see that the *ConcreteDecorator* Draw() calls its parent’s Draw() (in Python this can be done using super().Draw()) which in turn calls the component’s Draw(). Thus the user need not worry about using different method calls when the object is wrapped in a decorator, and can keep using it as the original TextDoc object. Thus the user can add/remove scrolls and borders whenever necessary.

### Let us return to our pizza example.

Suppose a customer asks for a ‘*More cheese with oregano, onions, and smoked ham’.* You know that a More cheese pizza has a base cost of $10, and oregano, onions and smoked ham cost $1, $6, and $15 respectively. In the decorator approach, we define decorators of all the possible add-on items (Toppings, Veggies and Non-Veg) and have their cost() methods defined as

```python
return self.cost + self.component.cost()
```

![](https://miro.medium.com/v2/resize:fit:875/1*VMrczyGDGb1P9pdypR7uJg.png)

Here, the user (the cashier) enters the pizza name, and it is processed as

```python
pizza = smoked_ham_decorator(onions_decorator(oregano_decorator(more_cheese_object)))
```

Now, the program calls the pizza.cost() method, which invokes the smoked\_ham\_decorator’s cost() method. Now, this decorator thinks that it contains a ‘*Pizza*’ (*ConcreteComponent*) object (because the onion\_decorator, by design, has the *Component (Pizza)* interface, so it behaves as a *Pizza* object). So it calls the self.component.cost() method, which happens to be the onion\_decorator.cost().

Similarly, onion\_decorator.cost() is coded in the same way, and onion\_decorator too thinks that it wraps a *Pizza* object when in reality, it is the oregano\_decorator. These calls go on recursively, till we get to the more\_cheese\_object, which **is** in fact a *Pizza* object*,* and returns more\_cheese\_object.cost() = $10. Thus we get the price as:

**PRICE = $ 15 + ($ 6 + ($ 1 + ($ 10))) = $ 32.**

Thus, decorators help us:

- Add a functionality to an object multiple times. If a customer wants two layers of onions on his Less Cheese pizza, we can just have it decorated as

```python
onion_decorator(onion_decorator(less_cheese_object))
```

- Add the same functionality to multiple objects, adhering to the paradigm of keeping the code **DRY** (Don’t Repeat Yourself).
- Not have objects depend on parameters that they don’t need.

Decorators offer an elegant solution to a number of problems in software design, while supporting flexibility, code reuse and division of labour within the code, making them, in my opinion, fundamental to object-oriented software design. Hopefully, after this introduction to decorators, you’ll understand what’s going on behind the scenes when you write an ‘@’!

*(Migrated from Medium on 17 August 2026)*
