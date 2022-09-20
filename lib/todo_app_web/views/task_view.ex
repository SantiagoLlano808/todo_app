defmodule TodoAppWeb.TaskView do
  use TodoAppWeb, :view

  defp now() do
    NaiveDateTime.utc_now() |> NaiveDateTime.to_string()
  end

  defp is_done(true), do: "It's done"
  defp is_done(false), do: "Missing task"
end
