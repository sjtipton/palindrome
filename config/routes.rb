Palindrome::Application.routes.draw do

  root to: "home#splash"

  scope path: "/learning-resources", controller: "learning_resources" do
    get "/" => :index
  end
end
