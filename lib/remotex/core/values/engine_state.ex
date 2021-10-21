defmodule Remotex.Core.Values.EngineState do
  @moduledoc false

  @random_range 0..100 |> Enum.to_list()

  @type t :: %__MODULE__{
          max_number: integer(),
          queried_at: DateTime.t() | nil
        }

  defstruct [:max_number, :queried_at]

  @spec init :: __MODULE__.t()
  def init do
    %__MODULE__{max_number: Enum.random(@random_range), queried_at: nil}
  end

  @spec new_random(engine_state :: __MODULE__.t()) :: __MODULE__.t()
  def new_random(engine_state) do
    %__MODULE__{engine_state | max_number: Enum.random(@random_range)}
  end

  @spec new_queried_at(engine_state :: __MODULE__.t()) :: __MODULE__.t()
  def new_queried_at(engine_state) do
    %__MODULE__{engine_state | queried_at: DateTime.utc_now()}
  end
end
