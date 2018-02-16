require('pry-byebug')

require_relative('models/customer.rb')

customer1 = Customer.new({
  'name' => 'Jake',
  'funds' => 25.00
  })
customer1.save

binding.pry

nil
