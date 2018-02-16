require_relative('../db/sql_runner.rb')

class Screening
  attr_reader :id
  attr_accessor :start_time, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @start_time = options['start_time']
    @film_id = options['film_id']
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
            RETURNING *"
    values = [@start_time, @film_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id']
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end

end
