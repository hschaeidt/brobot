defmodule GGWP.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :uid, :string, null: false
      add :provider, :string, null: false
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :nickname, :string
      add :user_id, references(:users), null: false
      timestamps()
    end

    create unique_index(:profiles, [:user_id])
  end
end
