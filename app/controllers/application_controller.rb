class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
    render html: "Hello, Antinet!"
  end
  def goodbye
    render html: "Goodbye, Society!"
  end
end
