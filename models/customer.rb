require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0];
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE * FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #  Which films a specific customer has booked to see
  def booked_films()
    sql = "SELECT films.* FROM films
           INNER JOIN tickets ON films.id = tickets.film_id
           WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    return result.map{ |film| Film.new(film) }
  end

  #  Shows the number of tickets a specified customer has bought
  def number_of_tickets()
    sql = "SELECT film_id FROM tickets WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    return result.map{ |ticket| Ticket.new(ticket) }.count
  end

  # Customer buying a ticket decreases their funds
  def buy(film)
    @funds -= film.price
    update
  end

  def pay()
    sql = "SELECT films.price FROM films
           INNER JOIN tickets ON tickets.film_id = films.id
           INNER JOIN customers ON tickets.customer_id = customers.id
           WHERE customers.id = $1"
    values = [@id]
    cost_data = SqlRunner.run(sql, values)
    cost_data.values.to_i
    sum = 0
    cost_data.each { |x| sum += x }
    return @funds -= cost_data
  end


end
