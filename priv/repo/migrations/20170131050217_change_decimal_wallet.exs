defmodule Telematicap1.Repo.Migrations.ChangeDecimalWallet do
  use Ecto.Migration

  def change do
    alter table(:wallets) do
      modify :balance, :integer

    end
  end
end
