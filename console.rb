require('pry-byebug')

require_relative('models/customer.rb')
require_relative('models/film.rb')

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
customer1.save()
customer2.save()

film1 = Film.new({
  'title' => 'Die Hard',
  'price' => 7.75
  })

film1.save()

binding.pry

nil
