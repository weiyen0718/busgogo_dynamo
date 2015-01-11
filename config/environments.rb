configure :development, :test do
ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
end
#set :database, 'sqlite3:db/dev.db'
#set :show_exceptions, true

configure :production do
db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')
ActiveRecord::Base.establish_connection(
:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
:host => db.host,
:username => db.user,
:password => db.password,
:database => db.path[1..-1],
:encoding => 'utf8'
)
end