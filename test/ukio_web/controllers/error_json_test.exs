defmodule UkioWeb.ErrorJSONTest do
  use UkioWeb.ConnCase, async: true

  test "renders 404" do
    assert UkioWeb.JsonRenderers.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert UkioWeb.JsonRenderers.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Server error"}}
  end
  test "renders 401" do
      assert UkioWeb.JsonRenderers.ErrorJSON.render("401.json", %{}) ==
             %{errors: %{detail: "Overlapping booking"}}
  end
end
