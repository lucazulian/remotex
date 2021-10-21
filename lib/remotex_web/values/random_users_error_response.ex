defmodule RemotexWeb.Values.RandomUsersErrorResponse do
  @moduledoc false

  @type t :: %__MODULE__{error: atom()}

  @derive Jason.Encoder
  defstruct [:error]
end
