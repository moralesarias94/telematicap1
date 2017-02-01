defmodule Telematicap1.Repo.Migrations.AddDefaultBalance do
  use Ecto.Migration

  def change do
    alter table(:wallets) do
      add :balance, :decimal, default: 0
    end
  end
end
