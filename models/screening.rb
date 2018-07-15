require_relative("../db/sql_runner")
require_relative('film')

class Screening

attr_reader :id
attr_accessor :show_time, :film_id, :capacity

def initialize(options)
  @id = options['id'].to_i if options['id']
  @film_id = options['film_id'].to_i
  @show_time = options['show_time']
  @capacity=options['capacity'].to_i
end

def save()
  sql = 'INSERT INTO screenings (show_time, film_id, capacity) VALUES ($1, $2, $3) RETURNING id'
  values=[@show_time, @film_id, @capacity]
  screening = SqlRunner.run(sql, values).first
  @id = screening['id'].to_i
end


def self.delete_all()
  sql='DELETE FROM screenings'
  SqlRunner.run(sql)
end

def film_name()
  sql= "SELECT * FROM films WHERE id = $1"
  values=[@id]
  film = SqlRunner.run(sql, values).first
  return Film.new(film)
end



end #end of class
