# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Remotex.Repo.insert!(%Remotex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Logger

alias Remotex.Repo
alias Remotex.Schemas.User

Enum.each([:ecto, :postgrex], &Application.ensure_all_started/1)
_pid = Repo.start_link()

Logger.configure(level: :info)

datetime = DateTime.utc_now()
chunck = trunc(65535 / 2)

Logger.info("== Running seeds script")

{time, _} =
  :timer.tc(fn ->
    1..1_000_000
    |> Enum.map(fn _ -> %{inserted_at: datetime, updated_at: datetime} end)
    |> Enum.chunk_every(chunck)
    |> Enum.each(fn rows ->
      Ecto.Multi.new()
      |> Ecto.Multi.insert_all(:insert_all, User, rows)
      |> Repo.transaction()
    end)
  end)

Logger.info("== Executed seeds script in #{inspect(div(time, 100_000) / 10)}s")
