class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      search_item = req.path.split("/items/").last
      if Item.items[search_item]
        resp.write "The price of #{search_item} is $#{Item.items[search_item]}."
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
