defmodule GGWP.Community.Blocklist do
  use Ecto.Schema
  import Ecto.Changeset

  alias GGWP.Community.{Profile, BlocklistEntry}

  schema "blocklists" do
    belongs_to :owner, Profile
    has_many :blocklist_entries, BlocklistEntry

    timestamps()
  end

  @doc false
  def changeset(blocklist, attrs) do
    blocklist
    |> cast(attrs, [])
    |> validate_required([])
  end
end
