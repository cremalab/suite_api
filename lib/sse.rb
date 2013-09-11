class SSE

  attr_reader :io, :response

  def initialize(response)
    response.headers['Content-Type'] = 'text/event-stream'
    @response = response
    @io = response.stream
    @io = io
  end

  def write(object, options = {})
    options.each do |k,v|
      @io.write "#{k}: #{v}\n"
    end
    @io.write "id: 55\n"
    @io.write "data: #{object}\n\n"
  end

  def close
    @io.close
  end

end