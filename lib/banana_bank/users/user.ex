defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @requered_params [:name, :password, :email, :cep]

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true # Passa senha, como virtual
    field :password_hash, :string
    field :email, :string
    field :cep, :string

    timestamps() #Usado para criar linhas automaticamente entre as tabelas no bd
  end

  def changeset(user \\ %__MODULE__{}, params) do  # Conjunto de mudanças
    user
    |> cast(params, @requered_params)
    |> validate_required(@requered_params) # Validar os requisitos
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
    |> add_password_hash()
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
      change(changeset, password_hash: Argon2.hash_pwd_salt(password))
  end

  defp add_password_hash(changeset), do: changeset
end
