defmodule Telematicap1.Repo.Migrations.AddWalletTable do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :name, :string
      add :value, :decimal
      add :user_id, :string
      
      timestamps()
    end
  end
end
