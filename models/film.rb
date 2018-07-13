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


end #end of class
