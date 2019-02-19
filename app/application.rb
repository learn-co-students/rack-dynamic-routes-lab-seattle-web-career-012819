require 'pry'
class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    path = req.path.split("/")
    path = path[1..path.length]

    if req.path.match(/testing/)
      
      resp.status = 404
      resp.write("Route not found")

    elsif req.path.match(/items/)

      requested_item = req.path.split("/items/").last
      found_item = @@items.find { |item| item.name == requested_item}

      if found_item.nil?
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write found_item.price
      end
    end
    resp.finish
  end

end