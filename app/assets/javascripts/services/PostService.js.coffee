angular.module('blogApp').factory 'Post', ($resource, $http) ->
  class Post
    constructor: (errorHandler) ->
      @service = $resource('/posts/:id',
        {id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      # Fix needed for the PATCH method to use application/json content type.
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs, successHandler) ->
      new @service(post: attrs).$save ((post) -> successHandler(post)), @errorHandler      

    delete: (post) ->
      new @service().$delete {id: post.id}, (-> null), @errorHandler

    update: (post, attrs) ->
      new @service(post: attrs).$update {id: post.id}, (-> null), @errorHandler
      
    all: ->
      @service.query((-> null), @errorHandler)

    find: (id, successHandler) ->
      @service.get(id: id, ((post)-> 
        successHandler?(post)
        post), 
       @errorHandler)

