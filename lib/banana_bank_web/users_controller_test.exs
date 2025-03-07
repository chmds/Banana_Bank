defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import Mox

  alias BananaBank.Users
  alias Users.User

  setup do
    params = %{
      "name" => "Carlos",
      "cep" => "18053220",
      "email" => "carlos@frutas.com.br",
      "password" => "147258"
    }

    body =  %{
      "bairro" => "Conjunto Habitacional Júlio de Mesquita Filho",
      "cep" => "18053-220",
      "complemento" => "",
      "ddd" => "15",
      "estado" => "São Paulo",
      "gia" => "6695",
      "ibge" => "3552205",
      "localidade" => "Sorocaba",
      "logradouro" => "Rua Alberto Rodrigues Geraldes",
      "regiao" => "Sudeste",
      "siafi" => "7145",
      "uf" => "SP",
      "unidade" => ""
    }

    {:ok, %{user_params: params, body: body}}
  end

  describe "create/2" do
    test "Usuario criado com sucesso", %{conn: conn, body: body, user_params: params} do
      expect(BananaBank.ViaCep.ClientMock, :call, fn "29560000" ->
        {:ok, body}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)  # Corrigido para :created

      assert %{
        "data" => %{"cep" => "18053220", "email" => "carlos@frutas.com.br", "id" => _id, "name" => "Carlos"},
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

      expect(BananaBank.ViaCep.ClientMock, :call, fn "12" ->
        {:ok, ""}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

        expected_response = %{"erros" => %{"cep" => ["should be 8 character(s)"], "name" => ["can't be blank"]}}

        assert response == expected_response
    end
  end

  describe "delete/2" do
    test "Usuario deletado com sucesso", %{conn: conn, body: body, user_params: params} do
      expect(BananaBank.ViaCep.ClientMock, :call, fn "18053220" ->
        {:ok, body}
      end)

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> detele(~p"/api/users/#{id}")
        |> json_response(:ok)

      expected_response = %{"data" => %{"cep" => "18053220", "email" => "carlos@frutas.com.br", "id" => id, "name" => "Carlos"}}

      assert response == expected_response
    end
  end
end
