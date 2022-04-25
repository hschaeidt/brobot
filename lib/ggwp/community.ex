defmodule GGWP.Community do
  @moduledoc """
  The Channel context.
  """

  import Ecto.Query, warn: false
  alias GGWP.Repo

  alias GGWP.Community.{Blocklist, BlocklistEntry, Profile}

  def list_profiles do
    Repo.all(Profile)
  end

  def create_profile(user, attrs) do
    Ecto.build_assoc(user, :profiles, attrs)
    |> Repo.insert()
  end

  def create_profile(attrs) do
    %Profile{}
    |> Profile.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of blocklist.

  ## Examples

      iex> list_blocklists()
      [%Blocklist{}, ...]

  """
  def list_blocklists do
    Repo.all(Blocklist)
  end

  @doc """
  Gets a single blocklist.

  Raises `Ecto.NoResultsError` if the Blocklist does not exist.

  ## Examples

      iex> get_blocklist!(123)
      %Blocklist{}

      iex> get_blocklist!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blocklist!(id), do: Repo.get!(Blocklist, id)

  @doc """
  Creates a blocklist.

  ## Examples

      iex> create_blocklist(%{field: value})
      {:ok, %Blocklist{}}

      iex> create_blocklist(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blocklist(owner_profile, attrs \\ %{}) do
    Ecto.build_assoc(owner_profile, :blocklist, attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blocklist.

  ## Examples

      iex> update_blocklist(blocklist, %{field: new_value})
      {:ok, %Blocklist{}}

      iex> update_blocklist(blocklist, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blocklist(%Blocklist{} = blocklist, attrs) do
    blocklist
    |> Blocklist.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blocklist.

  ## Examples

      iex> delete_blocklist(blocklist)
      {:ok, %Blocklist{}}

      iex> delete_blocklist(blocklist)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blocklist(%Blocklist{} = blocklist) do
    Repo.delete(blocklist)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blocklist changes.

  ## Examples

      iex> change_blocklist(blocklist)
      %Ecto.Changeset{data: %Blocklist{}}

  """
  def change_blocklist(%Blocklist{} = blocklist, attrs \\ %{}) do
    Blocklist.changeset(blocklist, attrs)
  end

  @doc """
  Returns the list of blocklist_entries.

  ## Examples

      iex> list_blocklist_entries()
      [%BlocklistEntry{}, ...]

  """
  def list_blocklist_entries do
    Repo.all(BlocklistEntry)
  end

  @doc """
  Gets a single blocklist_entry.

  Raises `Ecto.NoResultsError` if the Blocklist entry does not exist.

  ## Examples

      iex> get_blocklist_entry!(123)
      %BlocklistEntry{}

      iex> get_blocklist_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blocklist_entry!(id), do: Repo.get!(BlocklistEntry, id)

  @doc """
  Creates a blocklist_entry.

  ## Examples

      iex> create_blocklist_entry(%{field: value})
      {:ok, %BlocklistEntry{}}

      iex> create_blocklist_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blocklist_entry(attrs \\ %{}) do
    %BlocklistEntry{}
    |> BlocklistEntry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blocklist_entry.

  ## Examples

      iex> update_blocklist_entry(blocklist_entry, %{field: new_value})
      {:ok, %BlocklistEntry{}}

      iex> update_blocklist_entry(blocklist_entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blocklist_entry(%BlocklistEntry{} = blocklist_entry, attrs) do
    blocklist_entry
    |> BlocklistEntry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blocklist_entry.

  ## Examples

      iex> delete_blocklist_entry(blocklist_entry)
      {:ok, %BlocklistEntry{}}

      iex> delete_blocklist_entry(blocklist_entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blocklist_entry(%BlocklistEntry{} = blocklist_entry) do
    Repo.delete(blocklist_entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blocklist_entry changes.

  ## Examples

      iex> change_blocklist_entry(blocklist_entry)
      %Ecto.Changeset{data: %BlocklistEntry{}}

  """
  def change_blocklist_entry(%BlocklistEntry{} = blocklist_entry, attrs \\ %{}) do
    BlocklistEntry.changeset(blocklist_entry, attrs)
  end
end
