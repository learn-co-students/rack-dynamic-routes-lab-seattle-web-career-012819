class Application

    def call(env)
        resp = Rack::Response.new 
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            item = @@items.find {|x| x.name == item_name}
            if item 
                resp.write "#{item.price}"
            else 
                resp.status = 400 
                resp.write "Item not found"
            end 
        else 
            resp.status = 404
            resp.write "Route not found"
        end 
        resp.finish
    end 

    def print_item(item)
        if item
            return "#{item.price}"
        else 
            "Item not found"
        end
    end 

end 


# class Application
 
#     @@items = ["Apples","Carrots","Pears"]
   
#     def call(env)
#       resp = Rack::Response.new
#       req = Rack::Request.new(env)
   
#       if req.path.match(/items/)
#         @@items.each do |item|
#           resp.write "#{item}\n"
#         end
#       else
#         resp.write "Path Not Found"
#       end
   
#       resp.finish
#     end
#   end
  
