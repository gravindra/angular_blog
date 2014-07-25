angular.module('blogApp').factory 'Comment', ($resource, $http) ->
  class Comment
    constructor: (postId, errorHandler) ->
      @service = $resource('/posts/:post_id/comments/:id',
        {post_id: postId, id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      # Fix needed for the PATCH method to use application/json content type.
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs) ->
      new @service(comment: attrs).$save ((comment) ->
        attrs.id = comment.id
        attrs.body = comment.comment.body
        ), @errorHandler
      attrs

    delete: (comment) ->
      new @service().$delete {id: comment.id}, (-> null), @errorHandler

    update: (comment, attrs) ->
      new @service(comment: attrs).$update {id: comment.id}, (-> null), @errorHandler

    all: ->
      @service.query((-> null), @errorHandler)
