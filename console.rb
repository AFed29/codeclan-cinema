require('pry-byebug')

require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')

Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({
  'name' => 'Jake',
  'funds' => 25.00
})
customer2 = Customer.new({
  'name' => 'Charles',
  'funds' => 42.30
})
customer3 = Customer.new({
  'name' => 'Terry',
  'funds' => 55.40
})
customer4 = Customer.new({
  'name' => 'Raymond',
  'funds' => 250.00
})
customer1.save()
customer2.save()
customer3.save()
customer4.save()

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

screening1 = Screening.new({
  'start_time' => '13:45',
  'film_id' => film2.id
  })
screening2 = Screening.new({
  'start_time' => '16:00',
  'film_id' => film1.id
  })
screening3 = Screening.new({
  'start_time' => '18:00',
  'film_id' => film2.id
  })
screening4 = Screening.new({
  'start_time' => '20:15',
  'film_id' => film1.id
})
screening1.save()
screening2.save()
screening3.save()
screening4.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening1.id
})
ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'screening_id' => screening1.id
})
ticket3 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening2.id
})
      ticket1.save()
      ticket2.save()
      ticket3.save()

binding.pry

nil
