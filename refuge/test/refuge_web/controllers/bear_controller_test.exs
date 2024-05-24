defmodule RefugeWeb.BearControllerTest do
  use RefugeWeb.ConnCase

  import Refuge.WildthingsFixtures

  @create_attrs %{hibernating: true, name: "some name", type: "some type"}
  @update_attrs %{hibernating: false, name: "some updated name", type: "some updated type"}
  @invalid_attrs %{hibernating: nil, name: nil, type: nil}

  describe "index" do
    test "lists all bears", %{conn: conn} do
      conn = get(conn, ~p"/bears")
      assert html_response(conn, 200) =~ "Listing Bears"
    end
  end

  describe "new bear" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/bears/new")
      assert html_response(conn, 200) =~ "New Bear"
    end
  end

  describe "create bear" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/bears", bear: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/bears/#{id}"

      conn = get(conn, ~p"/bears/#{id}")
      assert html_response(conn, 200) =~ "Bear #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/bears", bear: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Bear"
    end
  end

  describe "edit bear" do
    setup [:create_bear]

    test "renders form for editing chosen bear", %{conn: conn, bear: bear} do
      conn = get(conn, ~p"/bears/#{bear}/edit")
      assert html_response(conn, 200) =~ "Edit Bear"
    end
  end

  describe "update bear" do
    setup [:create_bear]

    test "redirects when data is valid", %{conn: conn, bear: bear} do
      conn = put(conn, ~p"/bears/#{bear}", bear: @update_attrs)
      assert redirected_to(conn) == ~p"/bears/#{bear}"

      conn = get(conn, ~p"/bears/#{bear}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, bear: bear} do
      conn = put(conn, ~p"/bears/#{bear}", bear: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Bear"
    end
  end

  describe "delete bear" do
    setup [:create_bear]

    test "deletes chosen bear", %{conn: conn, bear: bear} do
      conn = delete(conn, ~p"/bears/#{bear}")
      assert redirected_to(conn) == ~p"/bears"

      assert_error_sent 404, fn ->
        get(conn, ~p"/bears/#{bear}")
      end
    end
  end

  defp create_bear(_) do
    bear = bear_fixture()
    %{bear: bear}
  end
end
