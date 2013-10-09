Delegator = require '../src/delegator'

describe "Delegator", ->
  [TestClass, a] = []

  beforeEach ->
    class TestClass
      Delegator.includeInto(this)
      getB: -> @b

    a = new TestClass
    a.b = {x: 1, getY: -> 2}

  it "can delegate methods and properties to a field on the current object", ->
    TestClass.delegates 'x', 'getY', to: 'b'

    expect(a.x).toBe 1
    expect(a.getY()).toBe 2

    a.b.x = 3
    expect(a.x).toBe 3

    a.x = 4
    expect(a.b.x).toBe 4

  it "can delegate methods and properties to the result of a method on the current object", ->
    TestClass.delegates 'x', 'getY', to: 'getB'

    expect(a.x).toBe 1
    expect(a.getY()).toBe 2

    a.b.x = 3
    expect(a.x).toBe 3

    a.x = 4
    expect(a.b.x).toBe 4
