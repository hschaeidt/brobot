defmodule GGWP.Community.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  alias GGWP.Accounts.User
  alias GGWP.Community.{Blocklist, BlocklistEntry}

  schema "profiles" do
    field :external_id, :string
    field :provider, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :nickname, :string

    belongs_to :user, User
    has_one :blocklist, Blocklist, foreign_key: :owner_id

    has_many :blocklist_entries, BlocklistEntry, foreign_key: :profile_id
    has_many :moderator_blocklist_entries, BlocklistEntry, foreign_key: :moderator_id

    timestamps()
  end

  def changeset(profile, params \\ %{}) do
    profile
    |> cast(params, [:external_id, :provider])
    |> validate_required([:external_id, :provider])
  end
end
