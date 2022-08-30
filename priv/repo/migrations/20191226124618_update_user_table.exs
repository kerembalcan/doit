defmodule Doit.Repo.Migrations.UpdateUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:is_deleted, :boolean, default: false)
      add(:password_hash, :string)
    end
  end
end
