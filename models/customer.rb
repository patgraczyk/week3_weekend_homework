require_relative("../db/sql_runner")

class Customer

attr_reader :id
attr_accessor :name, :funds

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds= options['funds'].to_i
end

def save ()
  sql ="INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
  values=[@name, @funds]
  customer = SqlRunner.run(sql, values).first
  @id = customer['id'].to_i
end

def self.delete_all()
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end

def update()
  sql= "UPDATE customers SET (name, funds) = ($1, $2)
        WHERE id = $3"
  values=[@name, @funds, @id]
  SqlRunner.run(sql, values)
end

def delete( )
  sql = "DELETE FROM customers WHERE id=$1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def tickets_bought()
  sql= "SELECT films.*  FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id= $1"
  values=[@id]
  films = SqlRunner.run(sql, values)
  result = films.map { |film| Film.new (film)  }
  return result
end

def tickets ()
  sql= "SELECT films.price  FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id= $1"
  values=[@id]
  prices= SqlRunner.run(sql, values)
  tickets_data = prices.map { |price| Ticket.new (price)  }
  return tickets_data[0]
end

def remaining_funds()
  tickets = self.tickets()
  tickets_prices = tickets.map{|price| tickets.price}
  return @funds - ticket_price
end



end
