defmodule RemotexWeb.Values.RandomUser do
  @moduledoc false

  @type t :: %__MODULE__{
          id: integer(),
          points: integer()
        }

  @derive Jason.Encoder
  defstruct [:id, :points]
end
