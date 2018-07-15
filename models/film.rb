require_relative("../db/sql_runner")
require_relative('screening')

class Film

attr_reader :id
attr_accessor :title, :price

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @price = options['price'].to_i
end

def save()
  sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
  values = [@title, @price]
  film = SqlRunner.run(sql, values).first
  @id = film['id'].to_i
end

def self.delete_all()
  sql="DELETE FROM films"
  SqlRunner.run(sql)
end

def update()
  sql="UPDATE films SET (title, price) = ($1, $2)
  WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql="DELETE FROM films WHERE id=$1"
  values=[@id]
  SqlRunner.run(sql, values)
end

def customers_seeing_film()
  sql="SELECT customers.* FROM customers INNER JOIN tickets ON customers.id= tickets.customer_id
  WHERE film_id = $1"
  values=[@id]
  customers=SqlRunner.run(sql, values)
  result=customers.map { |customer| Customer.new(customer)}
end

def screening_time()
  sql = "SELECT * FROM screenings WHERE film_id = $1"
  values = [@id]
  screening = SqlRunner.run(sql, values).first
  return Screening.new(screening)
end

def most_popular_showtime_by_film()
  sql ='SELECT * FROM tickets WHERE film_id = $1 ORDER BY screening_id'
  values=[@id]
  screenings_by_film = SqlRunner.run(sql, values)
  popular_screening = screenings_by_film.uniq.max_by{|screen|screenings_by_film.count(screen)}
  return Screening.new(popular_screening) #returns the most frequent value only
end

# array.max_by { |i| array.count(i) }
end #end of class
