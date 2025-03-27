defmodule BananaBankWeb.Plugs.Auth do
  import Plug.Conn

  alias BananaBankWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    # Se conseguir ler um bearer "token" (Plug... le o header de autorizacao)
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      assign(conn, :user_id, data.user_id)
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(json: BananaBankWeb.ErrorJSON)
        |> Phoenix.Controller.render(:error, status: :unauthorized)
        # Termina conexao e retorna-a, funcao de Plug.Conn
        |> halt()
    end
  end
end
