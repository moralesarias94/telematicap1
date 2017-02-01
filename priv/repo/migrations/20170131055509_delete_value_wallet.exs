defmodule Telematicap1.Repo.Migrations.DeleteValueWallet do
  use Ecto.Migration

  def change do
    alter table(:wallets) do
      remove :value
    end
  end
end
