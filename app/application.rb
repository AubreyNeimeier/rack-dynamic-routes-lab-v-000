require 'pry'
class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    binding.pry

    if req.path=="/items"
      item = req.path.split("/items/").last
      if @@items.include? (item)
        item_obj = @@items.find {|x| x.name == item}
        resp.write "#{item_obj.price}"
      else
        resp.write "That item does not exist"
        resp.status = 400
      end

    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
