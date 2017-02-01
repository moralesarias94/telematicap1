defmodule Telematicap1.Repo.Migrations.AlterWallet do
  use Ecto.Migration

  def change do
    alter table(:wallets) do
      remove :user_id
    end
  end
end
