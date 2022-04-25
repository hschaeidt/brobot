defmodule GGWP.Repo.Migrations.CreateBlocklists do
  use Ecto.Migration

  def change do
    create table(:blocklists) do
      add :owner_id, references(:profiles, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:blocklists, [:owner_id])

    alter table(:profiles) do
      add :blocklist_id, references(:blocklists, on_delete: :delete_all)
    end

    create index(:profiles, [:blocklist_id])
  end
end
