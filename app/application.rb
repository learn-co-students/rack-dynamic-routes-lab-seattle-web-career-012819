class Application
  @@items = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # Check for the presence of the only supported path
    if req.path !~ /items/
      resp.status = 404
      resp.write "Route not found"
    else
      # Look for the item
      item_name = req.path.split("/items/").last
      item = @@items.find { |i| i.name == item_name }

      # Use Ruby equivalent of 'try, catch, finally'
      begin
        resp.write "#{item.name} are #{item.price} a pound"
      rescue NoMethodError
        resp.status = 400
        resp.write "Item not found"
      end
    end
    resp.finish
  end
end