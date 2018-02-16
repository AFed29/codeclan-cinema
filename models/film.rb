require_relative('../db/sql_runner.rb')

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_f
  end

  def save()
    sql = "INSERT INTO films (title, price)
      VALUES ($1, $2)
      RETURNING *;"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first()
    @id = film['id']
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
