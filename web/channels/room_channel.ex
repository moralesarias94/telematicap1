defmodule Telematicap1.RoomChannel do
  use Phoenix.Channel
  alias Telematicap1.Transaction
  alias Telematicap1.Wallet
  alias Telematicap1.{Repo}
  alias Ecto
  intercept ["new_transaction"]
  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_transaction", %{"body" => body}, socket) do
    
    IO.puts "Recibido el mensaje"
    IO.inspect(body)
    %{"desc" => desc, "value" => value, "type" => type, "wallet_id" => wallet_id} = body
    changeset = Transaction.changeset(%Transaction{},%{description: desc, value: value, wallet_id: wallet_id, type: type})

    case Repo.insert(changeset) do
        {:ok, transaction} ->     
                wallet = Repo.get!(Wallet, wallet_id)
                balance = wallet.balance
                IO.inspect(transaction.value)
                IO.puts("Socket info")
                IO.inspect(socket)
                if(transaction.type == "deposit") do
                  balance = balance + transaction.value
                else
                  balance = balance - transaction.value
                end
                wallet = Ecto.Changeset.change wallet, balance: balance
                case Repo.update wallet do
                  {:ok, struct}       -> 
                    body = Map.put(body, :balance, balance)
                    body = Map.put(body, :id, transaction.id) # Updated with success
                  {:error, changeset} -> # Something went wrong
                end        
                push socket, "new_transaction", %{body: body}
                {:noreply, socket}
        {:error, changeset} -> {:noreply, socket}
    end

  end

  def handle_out("new_transaction", payload, socket) do
    IO.puts("Handle out")
    push socket, "new_transaction", payload
    {:noreply, socket}
  end
end