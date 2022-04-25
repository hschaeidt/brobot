defmodule GGWP.Repo.Migrations.CreateBlocklistEntries do
  use Ecto.Migration

  def change do
    create table(:blocklist_entries) do
      add :reason, :string
      add :expires_at, :naive_datetime
      add :profile_id, references(:profiles, on_delete: :delete_all), null: false
      add :moderator_id, references(:profiles, on_delete: :delete_all)
      add :blocklist_id, references(:blocklists, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:blocklist_entries, [:profile_id])
    create index(:blocklist_entries, [:moderator_id])
    create index(:blocklist_entries, [:blocklist_id])
    create unique_index(:blocklist_entries, [:profile_id, :blocklist_id])
  end
end
