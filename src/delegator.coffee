Mixin = require 'mixto'

module.exports =
class Delegator extends Mixin
  @delegatesProperties: (propertyNames..., {toProperty, toMethod}) ->
    for propertyName in propertyNames
      do (propertyName) =>
        Object.defineProperty @prototype, propertyName,
          if toProperty?
            get: ->
              @[toProperty][propertyName]
            set: (value) ->
              @[toProperty][propertyName] = value
          else if toMethod?
            get: ->
              @[toMethod]()[propertyName]
            set: (value) ->
              @[toMethod]()[propertyName] = value
          else
            throw new Error("No delegation target specified")

  @delegatesMethods: (methodNames..., {toProperty, toMethod}) ->
    for methodName in methodNames
      do (methodName) =>
        if toProperty?
          @::[methodName] = (args...) -> @[toProperty][methodName](args...)
        else if toMethod?
          @::[methodName] = (args...) -> @[toMethod]()[methodName](args...)
        else
          throw new Error("No delegation target specified")

  @delegatesProperty: (args...) -> @delegatesProperties(args...)
  @delegatesMethod: (args...) -> @delegatesMethods(args...)
