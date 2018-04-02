require "sinatra"
require "pg"
require "pry" if development? || test?
require "sinatra/reloader" if development?

set :bind, '0.0.0.0'  # bind to all interfaces

system "psql todo < schema.sql"
system "psql todo < seeder.sql"

def db_connection
  begin
    connection = PG.connect(dbname: "todo")
    yield(connection)
  ensure
    connection.close
  end
end

get "/tasks" do
  @tasks = nil
  #Get your tasks from the database
  binding.pry
  erb :index
end

get "/tasks/:task_name" do
  @task_name = params[:task_name]
  erb :show
end

post "/tasks" do
  # Read the input from the form the user filled out
  task = params["task_name"]

  # Insert new task into the database

  # Send the user back to the home page which shows
  # the list of tasks
  redirect "/tasks"
end
