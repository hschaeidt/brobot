defmodule GGWP.CommunityTest do
  use GGWP.DataCase

  alias GGWP.Community

  describe "profiles" do
    import GGWP.CommunityFixtures

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Community.list_profiles() == [profile]
    end
  end

  describe "blocklists" do
    alias GGWP.Community.Blocklist

    import GGWP.CommunityFixtures

    @invalid_attrs %{}

    test "list_blocklists/0 returns all blocklists" do
      owner = profile_fixture()
      blocklist = blocklist_fixture(owner)
      assert Community.list_blocklists() == [blocklist]
    end

    test "get_blocklist!/1 returns the blocklist with given id" do
      owner = profile_fixture()
      blocklist = blocklist_fixture(owner)
      assert Community.get_blocklist!(blocklist.id) == blocklist
    end

    test "delete_blocklist/1 deletes the blocklist" do
      owner = profile_fixture()
      blocklist = blocklist_fixture(owner)
      assert {:ok, %Blocklist{}} = Community.delete_blocklist(blocklist)
      assert_raise Ecto.NoResultsError, fn -> Community.get_blocklist!(blocklist.id) end
    end
  end

  describe "blocklist_entries" do
    alias GGWP.Community.BlocklistEntry

    import GGWP.CommunityFixtures

    @invalid_attrs %{expires_at: nil, reason: nil}

    test "list_blocklist_entries/0 returns all blocklist_entries" do
      blocklist_entry = blocklist_entry_fixture()
      assert Community.list_blocklist_entries() == [blocklist_entry]
    end

    test "get_blocklist_entry!/1 returns the blocklist_entry with given id" do
      blocklist_entry = blocklist_entry_fixture()
      assert Community.get_blocklist_entry!(blocklist_entry.id) == blocklist_entry
    end

    test "create_blocklist_entry/1 with valid data creates a blocklist_entry" do
      valid_attrs = %{expires_at: ~N[2022-04-24 11:17:00], reason: "some reason"}

      assert {:ok, %BlocklistEntry{} = blocklist_entry} =
               Community.create_blocklist_entry(valid_attrs)

      assert blocklist_entry.expires_at == ~N[2022-04-24 11:17:00]
      assert blocklist_entry.reason == "some reason"
    end

    test "create_blocklist_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Community.create_blocklist_entry(@invalid_attrs)
    end

    test "update_blocklist_entry/2 with valid data updates the blocklist_entry" do
      blocklist_entry = blocklist_entry_fixture()
      update_attrs = %{expires_at: ~N[2022-04-25 11:17:00], reason: "some updated reason"}

      assert {:ok, %BlocklistEntry{} = blocklist_entry} =
               Community.update_blocklist_entry(blocklist_entry, update_attrs)

      assert blocklist_entry.expires_at == ~N[2022-04-25 11:17:00]
      assert blocklist_entry.reason == "some updated reason"
    end

    test "update_blocklist_entry/2 with invalid data returns error changeset" do
      blocklist_entry = blocklist_entry_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Community.update_blocklist_entry(blocklist_entry, @invalid_attrs)

      assert blocklist_entry == Community.get_blocklist_entry!(blocklist_entry.id)
    end

    test "delete_blocklist_entry/1 deletes the blocklist_entry" do
      blocklist_entry = blocklist_entry_fixture()
      assert {:ok, %BlocklistEntry{}} = Community.delete_blocklist_entry(blocklist_entry)

      assert_raise Ecto.NoResultsError, fn ->
        Community.get_blocklist_entry!(blocklist_entry.id)
      end
    end

    test "change_blocklist_entry/1 returns a blocklist_entry changeset" do
      blocklist_entry = blocklist_entry_fixture()
      assert %Ecto.Changeset{} = Community.change_blocklist_entry(blocklist_entry)
    end
  end
end
