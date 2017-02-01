defmodule Telematicap1.Repo.Migrations.AlterWalletRelation do
  use Ecto.Migration

  def change do
    alter table(:wallets) do
      add :user_id, references(:users)
    end
  end
end
