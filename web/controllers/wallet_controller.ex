defmodule Telematicap1.WalletController do
  use Telematicap1.Web, :controller

  alias Telematicap1.Wallet
  alias Telematicap1.Transaction



  def reset_password(conn, %{"user" => %{"email" => email}}) do
    conn
    |> put_flash(:info, "Password reset link has been sent to your email address.")
    |> redirect(to: session_path(conn, :new))
  end
end
