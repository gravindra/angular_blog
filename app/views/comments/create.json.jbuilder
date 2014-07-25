json.comment do
  json.id @comment.id
  json.body replace_smilies(@comment.body, true)
  json.post_id @comment.post_id
end