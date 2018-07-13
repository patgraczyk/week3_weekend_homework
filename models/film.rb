require_relative("../db/sql_runner")

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
  values = [@title, @price ]
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

def customers_seeing_film
  sql="SELECT customers.* FROM customers INNER JOIN tickets ON customers.id= tickets.customer_id
  WHERE film_id = $1"
  values=[@id]
  customers=SqlRunner.run(sql, values)
  result=customers.map { |customer| Customer.new(customer)}
end





# def tickets_bought()
#   sql= "SELECT films.*  FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id= $1"
#   values=[@id]
#   films = SqlRunner.run(sql, values)
#   result = films.map { |film| Film.new (film)  }
#   return result
# end
#


end #end of class
