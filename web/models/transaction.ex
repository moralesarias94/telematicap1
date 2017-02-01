defmodule Telematicap1.Transaction do
  use Telematicap1.Web, :model

  schema "transactions" do
    field :value, :integer
    field :description, :string
    field :type, :string
    belongs_to :wallet, Telematicap1.Wallet
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:value, :description, :type, :wallet_id])
    |> validate_required([:value, :description, :type, :wallet_id])
  end

end