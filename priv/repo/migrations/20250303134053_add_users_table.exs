defmodule BananaBank.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do

    create table("users") do
      add :name, :string, null: false
      add :password_hash, :string, null: false
      add :email, :string, null: false
      add :cep, :string, null: false

      timestamps() #Usado para criar linhas automaticamente entre as tabelas no bd
    end
  end
end
