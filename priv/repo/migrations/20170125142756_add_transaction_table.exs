defmodule Telematicap1.Repo.Migrations.AddTransactionTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :value, :decimal
      add :description, :string
      add :wallet_id, :string
      add :type, :string

      timestamps()
    end
  end
end
