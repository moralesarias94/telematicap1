defmodule Telematicap1.Wallet do
  use Telematicap1.Web, :model

  schema "wallets" do

    field :name, :string
    field :balance, :integer
    belongs_to :user, Telematicap1.User
    has_many :transactions, Telematicap1.Transaction
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :balance, :user_id])
    |> validate_required([:name, :balance, :user_id])
  end

end
