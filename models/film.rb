require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    customer = SqlRunner.run(sql, values)[0];
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

#  To see which customers are booked on a specific film

  def customers_booked
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON customers.id = tickets.customer_id
    WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    return result.map{ |customer| Customer.new(customer)}
  end

# Counts the number of customers are booked on each film
  def number_of_customers_booked
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON customers.id = tickets.customer_id
    WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    return result.map{ |customer| Customer.new(customer)}.count
  end

# Returns the price of a ticket to specific film
  def price
    sql = "SELECT price FROM films WHERE id = $1"
    values = [@id]
    price_data = SqlRunner.run(sql, values)[0]
    return price_data["price"].to_i
  end




end
