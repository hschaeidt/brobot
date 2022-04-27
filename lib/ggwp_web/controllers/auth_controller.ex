defmodule GGWPWeb.AuthController do
  use GGWPWeb, :controller

  alias GGWP.Accounts
  alias GGWPWeb.UserAuth

  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    IO.puts("""
    #{inspect(fails)}
    """)

    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/auth/twitch")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.puts("""
    Response from Twitch OAuth:
    #{inspect(auth)}
    """)

    user =
      case Accounts.get_user_by_profile_external_id(auth.uid) do
        nil ->
          {:ok, {user, _profile}} =
            Accounts.register_user_with_profile(
              %{
                email: auth.info.email,
                password: :crypto.strong_rand_bytes(32) |> Base.encode64() |> binary_part(0, 32)
              },
              %{
                uid: auth.uid,
                provider: "#{auth.provider}",
                email: auth.info.email,
                first_name: auth.info.first_name,
                last_name: auth.info.last_name,
                nickname: auth.info.nickname
              }
            )

          user

        user ->
          user
      end

    UserAuth.log_in_user(conn, user)
  end
end
