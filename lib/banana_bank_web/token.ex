defmodule BananaBankWeb.Token do
  alias BananaBankWeb.Endpoint
  alias Phoenix.Token

  @sign_salt "banana_bank_api"

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token)

  # Caso queira mudar a resposta do error retornado por Token.verify
  # case Token.verify(Endpoint, @sign_salt, token) do#Token.verify retorna {:ok, DADOS} ou {:error, ERRO}
  #   {:ok, data} = result -> result
  #   {:error, _error} = error -> error
end
