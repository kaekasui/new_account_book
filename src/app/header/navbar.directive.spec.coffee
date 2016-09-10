describe 'directive navbar', () ->

  beforeEach ->
    module 'newAccountBook'
    module 'translateMock'

  it 'sample', () ->
    a = 'test'
    b = 'test'
    expect(a).toEqual(b)
