defmodule GGWP.Community.BlocklistEntry do
  use Ecto.Schema
  import Ecto.Changeset

  alias GGWP.Community.{Profile, Blocklist}

  schema "blocklist_entries" do
    field :expires_at, :naive_datetime
    field :reason, :string

    belongs_to :profile, Profile
    belongs_to :moderator, Profile
    belongs_to :blocklist, Blocklist

    timestamps()
  end

  @doc false
  def changeset(blocklist_entry, attrs) do
    blocklist_entry
    |> cast(attrs, [:reason, :expires_at])
    |> validate_required([:reason, :expires_at])
  end
end
