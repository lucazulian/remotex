ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Remotex.Repo, :manual)

Mox.defmock(Remotex.UsersQueryBulkMock, for: Remotex.Core.Behaviours.UsersQueryBulkBehaviour)
Application.put_env(:remotex, :users_strategy_module, Remotex.UsersQueryBulkMock)
