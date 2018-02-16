require_relative('../db/sql_runner.rb')

class Screening
  attr_reader :id
  attr_accessor :screen, :start_time, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @screen = options['screen'].to_i
    @start_time = options['start_time']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO screenings
           (
             screen,
             start_time,
             film_id
            )
            VALUES
            (
              $1,
              $2,
              $3
            )
            RETURNING *"
    values = [@screen, @start_time, @film_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id']
  end

end
