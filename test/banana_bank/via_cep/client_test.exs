defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/2" do
    test "Successfully returns cep info", %{bypass: bypass} do
      cep = "29560000"

      body = ~s({
        "bairro":"Conjunto Habitacional Júlio de Mesquita Filho",
        "cep":"18053-220",
        "complemento":"",
        "ddd":"15",
        "estado":"São Paulo",
        "gia":"6695",
        "ibge":"3552205",
        "localidade":"Sorocaba",
        "logradouro":"Rua Alberto Rodrigues Geraldes",
        "regiao":"Sudeste",
        "siafi":"7145",
        "uf":"SP",
        "unidade":""
      })

      expected_response =
        {:ok,
        %{
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
        }}

      Bypass.expect(bypass, "GET", "/ws/#{cep}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
