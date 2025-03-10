defmodule BananaBank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias BananaBank.Users.User

  @required_params [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end
end
