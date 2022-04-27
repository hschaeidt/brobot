defmodule GGWP.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GGWP.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> GGWP.Accounts.register_user()

    user
  end

  def user_with_profile_fixture(user_attrs \\ %{}, profile_attrs \\ %{}) do
    valid_user_attrs = valid_user_attributes(user_attrs)
    valid_profile_attrs = GGWP.CommunityFixtures.full_profile_attributes(profile_attrs)

    {:ok, user} = GGWP.Accounts.register_user_with_profile(valid_user_attrs, valid_profile_attrs)

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
