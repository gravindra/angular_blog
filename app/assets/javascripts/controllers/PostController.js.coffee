angular.module('blogApp').controller "PostController", ($scope, $routeParams, $location, Post) ->

  $scope.init = -> 
    @postsService = new Post(serverErrorHandler)
    $scope.posts = @postsService.all()

  $scope.createPost = (title) ->
    @postsService.create title: title, (post) ->
        $location.url("/")

  $scope.deletePost = (post, index) ->
    result = confirm "Are you sure you want to remove this post?" 

    if result
      @postsService.delete post
      $scope.posts.splice index, 1

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")
