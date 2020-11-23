class ApplicationError < StandardError
  def initialize(message = nil, **kwargs)
    super(message)

    post_initialize(**kwargs)
  end

  private

  def post_initialize
    nil # implement this in subclass to customize message content
  end
end
