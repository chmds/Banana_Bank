defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  alias BananaBank.Users
  alias Users.User

  describe "create/2" do
    test "Usuario criado com sucesso", %{conn: conn} do
      params = %{
        name: "Carlos",
        cep: "12345678",
        email: "carlos@frutas.com.br",
        password: "147258"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)  # Corrigido para :created

      assert %{
        "data" => %{"cep" => "12345678", "email" => "carlos@frutas.com.br", "id" => _id, "name" => "Carlos"},
        "message" => "Usuario criado com sucesso"
      } = response
    end

    test "Parametros invalidos", %{conn: conn} do
      params = %{
        name: nil,
        cep: "123",
        email: "carlos@frutas.com.br",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

        expected_response = %{"erros" => %{"cep" => ["should be 8 character(s)"], "name" => ["can't be blank"]}}

        assert response == expected_response
    end
  end

  describe "delete/2" do
    test "Usuario deletado com sucesso", %{conn: conn} do
      params = %{
        name: "Carlos",
        cep: "12345678",
        email: "carlos@frutas.com.br",
        password: "147258"
      }

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> detele(~p"/api/users/#{id}")
        |> json_response(:ok)

      expected_response = %{"data" => %{"cep" => "12345678", "email" => "carlos@frutas.com.br", "id" => id, "name" => "Carlos"}}

      assert response == expected_response
    end
  end
end
