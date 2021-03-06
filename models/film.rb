require_relative('../db/sql_runner.rb')

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_f
  end

  def screenings()
    sql = "SELECT * FROM screenings
           WHERE film_id = $1;"
    values = [@id]
    screenings = SqlRunner.run(sql, values)
    return screenings.map { |screening| Screening.new(screening) }
  end

  def save()
    sql = "INSERT INTO films (title, price)
           VALUES ($1, $2)
           RETURNING *;"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first()
    @id = film['id']
  end

  def update()
    sql = "UPDATE films SET (title, price)
           = ($1, $2)
           WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE from films
           WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT *
           FROM customers
           INNER JOIN tickets
           ON customers.id = tickets.customer_id
           WHERE tickets.film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer) }
  end

  def self.all()
    sql = "SELECT * FROM films;"
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film) }
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

end
