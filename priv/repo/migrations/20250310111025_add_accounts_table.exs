defmodule BananaBank.Repo.Migrations.AddAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :balance, :decimal
      add :user_id, references(:users)

      timestamps()
    end

    # Cria uma regra onde a tabela accounts, vai receber na coluna balance e checa se o número é >=0
    create constraint(:accounts, :balance_must_be_positive, check: "balance >= 0")
  end
end
