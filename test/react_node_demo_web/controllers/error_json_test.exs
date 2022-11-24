defmodule ReactNodeDemoWeb.ErrorJSONTest do
  use ReactNodeDemoWeb.ConnCase, async: true

  test "renders 404" do
    assert ReactNodeDemoWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ReactNodeDemoWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
