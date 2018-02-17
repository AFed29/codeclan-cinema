require_relative('../db/sql_runner.rb')

class Screening
  attr_reader :id
  attr_accessor :start_time, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @start_time = options['start_time']
    @film_id = options['film_id']
  end

  def number_of_tickets()
    sql = "SELECT * FROM tickets
           WHERE screening_id = $1;"
    values = [@id]
    return SqlRunner.run(sql, values).count
  end

  def check_if_screening_is_full
    return true if (number_of_tickets() >= 5)
    return false
  end

  def return_film()
    sql = "SELECT * FROM films
           WHERE id = $1;"
    values = [@film_id]
    film_hash = SqlRunner.run(sql, values).first()
    return Film.new(film_hash)
  end

  def save()
    sql = "INSERT INTO screenings
           (
             start_time,
             film_id
            )
            VALUES
            (
              $1,
              $2
            )
            RETURNING *;"
    values = [@start_time, @film_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id']
  end

  def update()
    sql = "UPDATE screenings
           SET (start_time, film_id)
           = ($1, $2)
           WHERE id = $3;"
    values = [@start_time, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.most_popular_screening_for_film(film)
    ticket_totals = []
    screenings = film.screenings()
    screenings.each do |screening|
      count = screening.number_of_tickets
      ticket_totals.push(
        [screening.start_time, film.title, count]
      )
    end
      result = 0
    ticket_totals.each do |ticket_total|
      result = ticket_total if (ticket_total[2] > result[2])
    end
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end

end
