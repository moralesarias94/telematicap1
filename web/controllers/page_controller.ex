defmodule Telematicap1.PageController do
  use Telematicap1.Web, :controller
  alias Telematicap1.Wallet
  alias Telematicap1.Transaction
  import Ecto.Query

  def index(conn, params) do
    wallet = nil
    wallet_id = nil
    case Map.fetch(params, "wallet") do
      {:ok, wallet_id} -> 
          wallet_id = wallet_id
          wallet = Repo.get(Wallet, wallet_id)
          query = from(t in Transaction, [where: t.wallet_id == ^wallet_id])
          all_transactions = Repo.all(query)
      :error -> all_transactions = []
    end
    user = conn.assigns.current_user;
    wallet_changeset = Wallet.changeset(%Wallet{}, %{})
    transaction_changeset = Transaction.changeset(%Transaction{}, %{})
    if(user) do 
      query = from(w in Wallet, [where: w.user_id == ^user.id])
      all_wallets = Repo.all(query)
    end
    render conn, "index.html", wallet_changeset: wallet_changeset, transaction_changeset: transaction_changeset, all_wallets: all_wallets, all_transactions: all_transactions, wallet: wallet, walletid: wallet_id, current_user: user
  end

  def create_wallet(conn, %{"wallet" => wallet}) do
    user = conn.assigns.current_user;
    %{"name" => name, "balance"=> balance} = wallet
    changeset = Wallet.changeset(%Wallet{}, %{user_id: user.id, name: name, balance: balance})
    case Repo.insert(changeset) do
        {:ok, wallet} -> redirect conn, to: "/"
        {:error, changeset} -> render conn, "new.html", changeset: changeset
    end

  end

  def delete_transaction(conn, %{"id_transaction" => id_transaction } = params) do
    transaction = Repo.get!(Transaction, id_transaction)
    wallet = Repo.get!(Wallet, transaction.wallet_id)
    balance = wallet.balance
    if(transaction.type == "deposit") do
      balance = balance - transaction.value
    else
      balance = balance + transaction.value
    end
    
    wallet = Ecto.Changeset.change wallet, balance: balance
    case Repo.update wallet do
      {:ok, struct}       ->      
        Repo.delete!(transaction)
        render conn, "delete.json", id: id_transaction
      {:error, changeset} -> 
        Repo.delete!(transaction)
        render conn, "delete.json", id: nil
    end        

  end
end
