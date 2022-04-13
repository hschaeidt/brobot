defmodule GGWP.Accounts.Profile do
  use Ecto.Schema

  schema "profiles" do
    field :uid, :string
    field :provider, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :nickname, :string
    belongs_to :user, GGWP.Accounts.User

    timestamps()
  end
end
