defmodule Telematicap1.Repo.Migrations.AlterTransactionRelation do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      add :wallet_id, references(:wallets, on_delete: :delete_all)
    end
  end
end
