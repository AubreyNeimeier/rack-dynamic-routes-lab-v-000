require 'pry'
class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

      item = req.path.split("/items/").last
      item_obj = @@items.find {|x| x.name == item}
      if req.path.match(/items/)
        if @@items.include? (item_obj)
          resp.write "#{item_obj.price}"
        elsif !@@items.include? (item_obj)
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
