SELECT tasks.*,
       completions.created_at as last_completed_at,
       completions.id as completion_id
FROM tasks
LEFT OUTER JOIN completions
  ON tasks.id = completions.task_id
LEFT OUTER JOIN completions cmpl
  ON completions.task_id = cmpl.task_id
  AND completions.created_at < cmpl.created_at
WHERE cmpl.id IS NULL;
