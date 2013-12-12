Delegator = require '../src/delegator'

describe "Delegator", ->
  [TestClass, TestSubclass] = []

  beforeEach ->
    class TestClass
      Delegator.includeInto(this)

    class TestSubclass extends TestClass

  describe ".delegatesProperties", ->
    it "can delegate a property to the value of a property on the current object", ->
      TestClass.delegatesProperties 'a', toProperty: 'b'

      object1 = new TestClass
      object1.b = {a: 1}
      expect(object1.a).toBe 1

      object2 = new TestSubclass
      object2.b = {a: 2}
      expect(object2.a).toBe 2

    it "can delegate a property to the result of a method on the current object", ->
      TestClass.delegatesProperties 'a', toMethod: 'getB'
      TestClass::getB = -> @b

      object1 = new TestClass
      object1.b = {a: 1}
      expect(object1.a).toBe 1

      object2 = new TestSubclass
      object2.b = {a: 2}
      expect(object2.a).toBe 2

  describe ".delegatesMethods", ->
    it "can delegate a method to the value of a property on the current object ", ->
      TestClass.delegatesMethods 'a', toProperty: 'b'

      object1 = new TestClass
      object1.b = {a: (v) -> 1 + v}
      expect(object1.a(1)).toBe 2

      object2 = new TestSubclass
      object2.b = {a: (v) -> 1 + 2}
      expect(object2.a(1)).toBe 3

    it "can delegate a method to the result of a method on the current object ", ->
      TestClass.delegatesMethods 'a', toMethod: 'getB'
      TestClass::getB = -> @b

      object1 = new TestClass
      object1.b = {a: (v) -> 1 + v}
      expect(object1.a(1)).toBe 2

      object2 = new TestSubclass
      object2.b = {a: (v) -> 1 + 2}
      expect(object2.a(1)).toBe 3
