defmodule BananaBank.Users.Verify do
  alias BananaBank.Users

  def call(%{"id" => id, "password" => password}) do
    case Users.get(id) do
      {:ok, user} -> verify(user, password)
      # Se ID for valido
      {:error, _} = error -> error
    end
  end

  defp verify(user, password) do
    case Argon2.verify_pass(password, user.password_hash) do
      # Se a senha for valida
      true -> {:ok, user}
      # Se a senha for invalida
      false -> {:error, :unauthorized}
    end
  end
end
