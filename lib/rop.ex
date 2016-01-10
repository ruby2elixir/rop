# https://gist.github.com/zabirauf/17ced02bdf9829b6956e
# https://github.com/remiq/railway-oriented-programming-elixir

defmodule Rop do
  defmacro __using__(_) do
    quote do
      import Rop
    end
  end


  @doc ~s"""
  Extracts the value from a tagged tuple like {:ok, value}
  Raises the value from a tagged tuple like {:error, value}
  Raise the arguments else

  For example:
      iex> ok({:ok, 1})
      1

      iex> ok({:error, "some"})
      ** (RuntimeError) some

      iex> ok({:anything, "some"})
      ** (ArgumentError) raise/1 expects an alias, string or exception as the first argument, got: {:anything, "some"}
  """
  def ok({:ok, x}), do: x
  def ok({:error, x}), do: raise x
  def ok(x), do: raise x


  @doc ~s"""
    No need to stop pipelining in case of an error somewhere in the middle
  """
  defmacro left >>> right do
    quote do
      (fn ->
        case unquote(left) do
          {:ok, x} -> x |> unquote(right)
          {:error, _} = expr -> expr
        end
      end).()
    end
  end

  @doc ~s"""
    Wraps a simple function to return a tagged tuple with `:ok` to comply to the protocol `{:ok, result}`
  """
  defmacro bind(args, func) do
    quote do
      (fn ->
        result = unquote(args) |> unquote(func)
        {:ok, result}
      end).()
    end
  end

  @doc ~s"""
    Wraps raising functions to return a tagged tuple `{:error, ErrorMessage}` to comply with the protocol
  """
  defmacro try_catch(args, func) do
    quote do
      (fn ->
        try do
          unquote(args) |> unquote(func)
        rescue
          e -> {:error, e}
        end
      end).()
    end
  end



  @doc ~s"""
    Like a similar Unix utility it does some work and returns the input.
    See [tee (command), Unix](https://en.wikipedia.org/wiki/Tee_(command)).
  """
  defmacro tee(args, func) do
    quote do
      (fn ->
        unquote(args) |> unquote(func)
        {:ok, unquote(args)}
      end).()
    end
  end
end
