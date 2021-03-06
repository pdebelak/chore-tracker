# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170524114950) do

  create_table "completions", force: :cascade do |t|
    t.integer "task_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_completions_on_task_id"
    t.index ["user_id"], name: "index_completions_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "description"
    t.string "schedule"
    t.integer "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_tasks_on_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "image_url"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_lists", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "list_id"
    t.index ["list_id"], name: "index_users_lists_on_list_id"
    t.index ["user_id"], name: "index_users_lists_on_user_id"
  end


  create_view "task_with_completions",  sql_definition: <<-SQL
      SELECT tasks.*,
         completions.created_at as last_completed_at,
         completions.id as completion_id
  FROM tasks
  LEFT OUTER JOIN completions
    ON tasks.id = completions.task_id
  LEFT OUTER JOIN completions cmpl
    ON completions.task_id = cmpl.task_id
    AND completions.created_at < cmpl.created_at
  WHERE cmpl.id IS NULL
  SQL

end
