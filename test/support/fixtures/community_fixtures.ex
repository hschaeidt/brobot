defmodule GGWP.CommunityFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GGWP.Community` context.
  """

  def valid_profile_external_id, do: "#{System.unique_integer()}"
  def valid_profile_provider, do: "twitch"
  def valid_profile_first_name, do: "John"
  def valid_profile_last_name, do: "Doe"
  def valid_profile_nickname, do: "profile#{System.unique_integer()}"

  def valid_profile_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      external_id: valid_profile_external_id(),
      provider: valid_profile_provider()
    })
  end

  def full_profile_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      external_id: valid_profile_external_id(),
      provider: valid_profile_provider(),
      email: GGWP.AccountsFixtures.unique_user_email(),
      first_name: valid_profile_first_name(),
      last_name: valid_profile_last_name(),
      nickname: valid_profile_nickname()
    })
  end

  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> valid_profile_attributes()
      |> GGWP.Community.create_profile()

    profile
  end

  @doc """
  Generate a blocklist.
  """
  def blocklist_fixture(owner_profile) do
    {:ok, blocklist} = GGWP.Community.create_blocklist(owner_profile)

    blocklist
  end

  @doc """
  Generate a blocklist_entry.
  """
  def blocklist_entry_fixture(attrs \\ %{}) do
    {:ok, blocklist_entry} =
      attrs
      |> Enum.into(%{
        expires_at: ~N[2022-04-24 11:17:00],
        reason: "some reason"
      })
      |> GGWP.Community.create_blocklist_entry()

    blocklist_entry
  end
end
