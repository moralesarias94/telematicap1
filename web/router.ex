defmodule Telematicap1.Router do
  use Telematicap1.Web, :router
  use Passport
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Telematicap1 do
    pipe_through :browser # Use the default browser stack
    get "/login", SessionController, :new
    post "/session", SessionController, :create
    get "/logout", SessionController, :delete
    get "/join", RegistrationController, :new
    post "/register", RegistrationController, :create
    get "/passwords/new", PasswordController, :new
    post "/passwords", PasswordController, :reset
    post "/index/create_wallet", PageController, :create_wallet
    get "/", PageController, :index
    get "/:wallet", PageController, :index
    delete "transaction/:id_transaction", PageController, :delete_transaction
  end

  # Other scopes may use custom stacks.
  # scope "/api", Telematicap1 do
  #   pipe_through :api
  # end
end
