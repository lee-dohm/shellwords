defmodule Shellwords do
  @moduledoc """
  Functions for manipulating strings according to the word parsing rules of the UNIX Bourne shell.

  **See:** [Shell & Utilities volume of the IEEE Std 1003.1-2008, 2016 Edition][standard]

  [standard]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.html
  """

  @split_pattern ~r/\G\s*(?>([^\s\\\'\"]+)|'([^\']*)'|"((?:[^\"\\]|\\.)*)"|(\\.?)|(\S))(\s|\z)?/m

  @doc """
  Splits a string into an array of tokens in the same way as the UNIX Bourne shell does.

  Returns `{:ok, words}` on success and `{:error, reason}` on failure.

  ## Examples

  ```
  iex> Shellwords.split("here are \\"two words\\"")
  {:ok, ["here", "are", "two words"]}
  ```

  ```
  iex> Shellwords.split("\\"unmatched quote")
  {:error, "Unmatched quote: \\"\\\\\\"unmatched quote\\""}
  ```
  """
  @spec split(String.t()) :: {:ok, [String.t()]} | {:error, String.t()}
  def split(text) when is_binary(text) do
    words =
      @split_pattern
      |> Regex.scan(text)
      |> Enum.map(&handle_split_captures/1)

    if :error in words do
      {:error, "Unmatched quote: #{inspect(text)}"}
    else
      {:ok, words}
    end
  end

  @doc """
  Splits a string into an array of tokens in the same way as the UNIX Bourne shell does.

  Operates in the same fashion as `split/1` but raises an exception when errors are encountered.
  """
  @spec split!(String.t()) :: [String.t()] | no_return
  def split!(text) when is_binary(text) do
    case split(text) do
      {:ok, words} -> words
      {:error, reason} -> raise ArgumentError, reason
    end
  end

  defp handle_split_captures(captures) do
    {word, sq, dq, esc, garbage} = parse_split_captures(captures)

    dq = Regex.replace(~r/\\([$`"\\\n])/, dq, "\\1")
    esc = Regex.replace(~r/\\([$`"\\\n])/, esc, "\\1")

    cond do
      String.length(garbage) > 0 -> :error
      String.length(word) > 0 -> word
      String.length(sq) > 0 -> sq
      String.length(dq) > 0 -> dq
      String.length(esc) > 0 -> esc
    end
  end

  defp parse_split_captures([_whole_match, word, sq, dq, esc, garbage, _sep]) do
    {word, sq, dq, esc, garbage}
  end

  defp parse_split_captures([_whole_match, word, sq, dq, esc, garbage]) do
    {word, sq, dq, esc, garbage}
  end
end
