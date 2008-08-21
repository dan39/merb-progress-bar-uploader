class BasefileMigration < ActiveRecord::Migration

  
  
  create_table "articles", :force => true do |t|
    t.string "title"
  end

  create_table "basefiles", :force => true do |t|
    t.string  "title"
    t.string  "content_type",    :limit => 40,  :default => "", :null => false
    t.string  "filename",        :limit => 120, :default => "", :null => false
    t.integer "size",            :limit => 11,  :default => 0,  :null => false
    t.string  "controller_name"
    t.integer "folder_id",       :limit => 11
  end

  create_table "bunnies", :force => true do |t|
    t.string  "title"
    t.string  "content_type",    :limit => 40, :default => "", :null => false
    t.string  "filename",        :limit => 80, :default => "", :null => false
    t.integer "size",            :limit => 11, :default => 0,  :null => false
    t.integer "width",           :limit => 11, :default => 0,  :null => false
    t.integer "height",          :limit => 11, :default => 0,  :null => false
    t.string  "controller_name"
  end

  create_table "controller_name", :force => true do |t|
    t.string "title"
  end

  create_table "folders", :force => true do |t|
    t.string  "title"
    t.integer "parent_id", :limit => 11
  end

  create_table "folderspoo", :force => true do |t|
    t.string   "name"
    t.integer  "is_root",    :limit => 11
    t.integer  "user_id",    :limit => 11
    t.integer  "parent_id",  :limit => 11
    t.datetime "created_at"
  end

  create_table "pockies", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "sessions", :force => true do |t|
    t.text "session_id"
    t.text "data"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id",    :limit => 11
    t.integer  "role_id",    :limit => 11
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
