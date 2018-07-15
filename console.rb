require_relative('models/film')
require_relative('models/customer')
require_relative('models/ticket')

require('pry-byebug')

# Customer.delete_all()
# Film.delete_all()
# Ticket.delete_all()
# Screening.delete_all()


customer1=Customer.new({'name' => 'Anna Maria', 'funds'=> 40})
customer2=Customer.new({'name' => 'Jose Antonio', 'funds'=> 20})
customer3=Customer.new({'name' => 'Alejandra', 'funds'=> 100})
customer1.save()
customer2.save()
customer3.save()
customer1.name="Marianna Sabina"
# customer1.update
# customer1.delete

#
film1=Film.new({'title'=>'Coco', 'price'=>11})
film2=Film.new({'title'=>'Mulan', 'price'=>12})
film3=Film.new({'title'=>'Lion King', 'price'=>15})
film4=Film.new({'title'=>'Finding Nemo', 'price'=>21})
film5=Film.new({'title'=>'Alien', 'price'=>31})
film1.save()
film2.save()
film3.save()
film4.save()
film5.save()
film5.title="Beautiful Mind"
film5.update()
# film1.delete()
#
screening1=Screening.new({'show_time' => '22:10', 'film_id'=> film1.id})
screening2=Screening.new({'show_time' => '20:10', 'film_id'=> film2.id})
screening3=Screening.new({'show_time' => '19:10', 'film_id'=> film3.id})
screening4=Screening.new({'show_time' => '21:10', 'film_id'=> film4.id})
screening1.save()
screening2.save()
screening3.save()
screening4.save()
#
# #
ticket1=Ticket.new({'customer_id'=>customer1.id, 'film_id'=> film1.id, 'screening_id' => screening1.id})
ticket2=Ticket.new({'customer_id'=>customer1.id, 'film_id'=> film1.id, 'screening_id' => screening1.id})
ticket3=Ticket.new({'customer_id'=>customer3.id, 'film_id'=> film1.id, 'screening_id' => screening1.id})
ticket4=Ticket.new({'customer_id'=>customer3.id, 'film_id'=> film3.id, 'screening_id' => screening4.id})
ticket5=Ticket.new({'customer_id'=>customer2.id, 'film_id'=> film4.id, 'screening_id' => screening1.id})
ticket6=Ticket.new({'customer_id'=>customer2.id, 'film_id'=> film5.id, 'screening_id' => screening2.id})
ticket7=Ticket.new({'customer_id'=>customer2.id, 'film_id'=> film1.id, 'screening_id' => screening3.id})
ticket8=Ticket.new({'customer_id'=>customer3.id, 'film_id'=> film3.id, 'screening_id' => screening4.id})
ticket9=Ticket.new({'customer_id'=>customer3.id, 'film_id'=> film2.id, 'screening_id' => screening1.id})
ticket10=Ticket.new({'customer_id'=>customer2.id, 'film_id'=> film3.id, 'screening_id' => screening2.id})
ticket11=Ticket.new({'customer_id'=>customer1.id, 'film_id'=> film5.id, 'screening_id' => screening3.id})
ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()
ticket7.save()
ticket8.save()
ticket9.save()
ticket10.save()
ticket11.save()

# p ticket1.show_films()
# p ticket2.show_customers()
# p customer2.tickets_bought()
# p film1.customers_seeing_film()
# p customer1.remaining_funds()
# p film1
p film1.most_popular_showtime_by_film()

# binding.pry
# nil


# SELECT * FROM tickets INNER JOIN screenings ON screenings.id = tickets.screening_id WHERE screening_id =
# ORDER BY show_time ASC
