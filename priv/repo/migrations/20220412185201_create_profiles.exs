defmodule GGWP.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :external_id, :string, null: false
      add :provider, :string, null: false
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :nickname, :string
      add :user_id, references(:users)
      timestamps()
    end

    create index(:profiles, [:external_id])
    create index(:profiles, [:provider])
    create unique_index(:profiles, [:user_id])
    create unique_index(:profiles, [:external_id, :provider])
  end
end
