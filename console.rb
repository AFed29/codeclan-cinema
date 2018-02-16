require('pry-byebug')

require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')

Ticket.delete_all()
Customer.delete_all()
Screening.delete_all()
Film.delete_all()


customer1 = Customer.new({
  'name' => 'Jake',
  'funds' => 25.00
})
customer2 = Customer.new({
  'name' => 'Charles',
  'funds' => 42.30
})
customer1.save()
customer2.save()

film1 = Film.new({
  'title' => 'Die Hard',
  'price' => 7.75
})
film2 = Film.new({
  'title' => 'Die Hard 2',
  'price' => 6.50
})
film1.save()
film2.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
})
ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id
})
ticket3 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id
})
ticket1.save()
ticket2.save()
ticket3.save()

screening1 = Screening.new({
  'start_time' => '20:15',
  'film_id' => film1.id
})
screening1.save()

binding.pry

nil
