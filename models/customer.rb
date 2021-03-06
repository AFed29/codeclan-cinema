require_relative('../db/sql_runner.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_f
  end

  def remove_money(amount)
    @funds -= amount
    update()
  end

  def buy_ticket(screening)
    film = screening.return_film()
    if Ticket.create_ticket(@id, screening) != nil
      remove_money(film.price)
    else
      return p "Sorry the film is full"
    end
  end

  def number_of_tickets()
    sql = "SELECT * FROM tickets
           WHERE customer_id = $1;"
    values = [@id]
    return SqlRunner.run(sql, values).count()
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
           VALUES ($1, $2 )
           RETURNING *;"
    values = [@name, @funds]
    customer  = SqlRunner.run(sql, values).first()
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name,funds)
           = ($1, $2)
           WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE from customers
           WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT *
           FROM films
           INNER JOIN tickets
           ON films.id = tickets.film_id
           WHERE tickets.customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film) }
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    return customers.map { |customer| Customer.new(customer) }
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

end
