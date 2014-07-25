json.array!(@posts) do |post|
  json.id post.id
  json.title post.title
  json.comments post.comments do |comment|
  	json.id comment.id
  	json.body replace_smilies(comment.body, true)
  	json.post_id comment.post_id
  end
end