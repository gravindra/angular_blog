angular.module('blogApp').controller "CommentController", ($scope, $sce, $timeout, $routeParams, Comment, Post) ->
  $scope.sortMethod = 'priority'
  $scope.sortableEnabled = true

  $scope.init = () ->
    @commentService = new Comment($routeParams.post_id, serverErrorHandler)
    @postService = new Post(serverErrorHandler)

    $scope.post = @postService.find $routeParams.post_id

  $scope.addComment = ->
    #raisePriorities()
    comment = @commentService.create(body: $scope.commentDescription)
    console.log comment
    $scope.post.comments.unshift(comment)
    $scope.commentDescription = ""

  $scope.deleteComment = (comment) ->
    @commentService.delete(comment)
    $scope.post.comments.splice($scope.post.comments.indexOf(comment), 1)

  $scope.toggleTask = (task) ->
    @taskService.update(task, completed: task.completed)

  $scope.postTitleEdited = (postTitle) ->
    @postService.update(@post, title: postTitle)

  $scope.taskEdited = (task) ->
    @taskService.update(task, description: task.description)

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")

  $scope.to_trusted = (html_code) ->
    return $sce.trustAsHtml(html_code)