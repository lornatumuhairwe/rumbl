defmodule Rumbl.Multimedia.Permalink do
  use Ecto.Type
  
  def type, do: :id
  
  def cast(binary) when is_binary(binary) do
    case Integer.parse(binary) do
      {int, _} when int > 0 -> {:ok, int}
      _ -> :error
    end
  end
  
  def cast(integer) when is_integer(integer) do
    {:ok, integer}
  end
  
  def case(_) do
    :error
  end
  
  @spec dump(integer) :: {:ok, integer}
  def dump(integer) when is_integer(integer) do
    {:ok, integer}
  end
  
  def load(integer) when is_integer(integer) do
    {:ok, integer}
  end
end
