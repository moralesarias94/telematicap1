defmodule Telematicap1.Repo.Migrations.ChangeTransaction do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      modify :value, :integer

    end
  end

end
