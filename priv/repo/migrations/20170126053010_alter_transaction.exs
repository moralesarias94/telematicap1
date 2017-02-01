defmodule Telematicap1.Repo.Migrations.AlterTransaction do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      remove :wallet_id
    end
  end
end
