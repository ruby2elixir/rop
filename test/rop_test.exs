defmodule RopTest do
  use ExSpec, async: true
  use Rop
  import ExUnit.CaptureIO


  describe ">>> macro" do
    test "returns the piped value in case of happy path" do
      assert (0 |> ok >>> ok >>> ok) == {:ok, 3}
    end

    test "returns the value of first error" do
      assert (0 |> ok >>> error) == {:error, "Error at 1"}
    end

    test "propagates the error" do
      assert (0 |> ok >>> error >>> ok >>> ok) == {:error, "Error at 1"}
    end

    test "propagates the correct error message" do
      assert (0 |> ok >>> ok >>> error >>> error >>> ok) == {:error, "Error at 2"}
    end
  end

  describe "try_catch macro" do
    test "catches raised errors, if something breaks" do
      assert (:raise |> try_catch(arithmetic_error)) == {:error, %ArithmeticError{}}
    end

    test "returns the value otherwise" do
      assert (:pass |> try_catch(arithmetic_error)) == 1
    end
  end

  describe "tee" do
    test "passes the arguments through after executing them in the function" do
      a = (fn ->
        0 |> simple_inc |> simple_inc |> tee(simple_sideeffect)
      end)

      assert a.() == {:ok, 2}
    end

    test "is calles the sideeffect in the function" do
      a = (fn ->
        0 |> simple_inc |> simple_inc |> tee(simple_sideeffect)
      end)
      assert capture_io(a) == "2\n"
    end
  end

  defp simple_sideeffect(a) do
    IO.inspect a
    # return unrelated to passed in arguments value
    :unrelated
  end

  def simple_inc(cnt) do
    cnt + 1
  end

  defp ok(cnt) do
    {:ok, cnt + 1}
  end

  defp error(cnt) do
    {:error, "Error at #{cnt}"}
  end

  defp arithmetic_error(:pass) do
    1
  end

  defp arithmetic_error(:raise) do
    1 / 0
  end
end
