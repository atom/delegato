##### Atom and all repositories under Atom will be archived on December 15, 2022. Learn more in our [official announcement](https://github.blog/2022-06-08-sunsetting-atom/)
 # delegato [![Build Status](https://travis-ci.org/atom/delegato.png?branch=master)](https://travis-ci.org/atom/delegato)

## Delegate Methods

```coffee
Delegato = require 'delegato'

class Ship
  Delegato.includeInto(this)
  
  @delegatesMethods 'dropAnchor', 'raiseAnchor', toProperty: 'winch'
  @delegatesMethod 'leavePort', toMethod: 'getCaptain'
```

## Delegate Properties

```coffee
class MyClass
  Delegato.includeInto(this)
  
  @delegatesProperty 'steamPressure', toProperty: 'engineRoom'
  @delegatesProperties 'heading', 'speed', toMethod: 'getVelocity'
```
