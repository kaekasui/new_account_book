describe 'service githubContributor', () ->

  beforeEach module 'newAccountBook'

  it 'should be registered', inject (githubContributor) ->
    expect(githubContributor).not.toEqual null

  describe 'apiHost variable', () ->
    it 'should exist', inject (githubContributor) ->
      expect(githubContributor.apiHost).not.toEqual null

  describe 'getContributors function', () ->
    it 'should exist', inject (githubContributor) ->
      expect(githubContributor.getContributors).not.toEqual null

    it 'should return data', inject (githubContributor, $httpBackend) ->
      $httpBackend.when('GET',  githubContributor.apiHost + '/contributors?per_page=1').respond 200, [{pprt: 'value'}]
      data = undefined
      githubContributor.getContributors(1).then (fetchedData) ->
        data = fetchedData
      $httpBackend.flush()
      expect(data).toEqual jasmine.any Array
      expect(data.length == 1).toBeTruthy()
      expect(data[0]).toEqual jasmine.any Object

    it 'should define a limit per page as default value', inject (githubContributor, $httpBackend) ->
      $httpBackend.when('GET',  githubContributor.apiHost + '/contributors?per_page=30').respond 200, new Array(30)
      data = undefined
      githubContributor.getContributors().then (fetchedData) ->
        data = fetchedData
      $httpBackend.flush()
      expect(data).toEqual jasmine.any Array
      expect(data.length == 30).toBeTruthy()

    it 'should log a error', inject (githubContributor, $httpBackend, $log) ->
      $httpBackend.when('GET',  githubContributor.apiHost + '/contributors?per_page=1').respond 500
      githubContributor.getContributors 1
      $httpBackend.flush()
      expect($log.error.logs).toEqual jasmine.stringMatching 'XHR Failed for'
