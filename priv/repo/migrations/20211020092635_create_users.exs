defmodule Remotex.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :points, :integer, null: false, default: 0

      timestamps(type: :utc_datetime_usec)
    end
  end
end
