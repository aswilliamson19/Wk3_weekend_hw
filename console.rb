require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')

require('pry-byebug')

Customer.delete_all
Ticket.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Amanda', 'funds' => 20})
customer1.save
customer2 = Customer.new({'name' => 'Rachel', 'funds' => 50})
customer2.save
customer3 = Customer.new({'name' => 'Ross', 'funds' => 15})
customer3.save
customer4 = Customer.new({'name' => 'Ben', 'funds' => 60})
customer4.save

film1 = Film.new({'title' => 'Spider-Man: Far From Home', 'price' => 5})
film1.save
film2 = Film.new({'title' => 'The Lion King', 'price' => 10})
film2.save
film3 = Film.new({'title' => 'Toy Story 4', 'price' => 8})
film3.save
film4 = Film.new({'title' => 'Fast & Furious: Hobbs and Shaw', 'price' => 5})
film4.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3.save
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket4.save
ticket5 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film4.id})
ticket5.save
ticket6 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film3.id})
ticket6.save


binding.pry
nil
