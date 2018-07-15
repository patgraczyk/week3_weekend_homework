require_relative("../db/sql_runner")
require_relative('film')
require_relative('customer')
require_relative('screening')


class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id= options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end


  def save()
    sql = 'INSERT INTO tickets (customer_id, film_id, screening_id) VALUES ($1, $2, $3) RETURNING id'
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.delete_all ()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def show_films()
    sql = "SELECT * FROM films WHERE id=$1"
    values=[@film_id]
    film=SqlRunner.run(sql, values).first
    return Film.new(film)
  end

  def show_customers()
    sql = "SELECT * FROM customers WHERE id=$1"
    values=[@customer_id]
    customer=SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  def delete()
    sql = "DELETE * FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


end #end of class
