Mixin = require 'mixto'

getDelegate = (object, delegateName) ->
  delegate = object[delegateName]
  if typeof delegate is 'function'
    delegate.call(object)
  else
    delegate

module.exports =
class Delegator extends Mixin
  @delegates: (args...) ->
    delegateName = args[args.length - 1].to
    propertyNames = args[0...-1]
    for propertyName in propertyNames
      do (propertyName) =>
        Object.defineProperty @prototype, propertyName,
          get: ->
            delegate = getDelegate(this, delegateName)
            if typeof delegate?[propertyName] is 'function'
              (args...) => delegate?[propertyName](args...)
            else
              delegate?[propertyName]
          set: (value) ->
            delegate = getDelegate(this, delegateName)
            delegate?[propertyName] = value
