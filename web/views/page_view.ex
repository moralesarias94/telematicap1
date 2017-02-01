defmodule Telematicap1.PageView do
  use Telematicap1.Web, :view

  def render("delete.json", %{id: id}) do
    %{
      id: id
    }
  end
end
