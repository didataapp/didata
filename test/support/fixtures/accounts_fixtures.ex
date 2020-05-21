defmodule Didata.AccountsFixtures do
  @moduledoc false

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        password: valid_user_password()
      })
      |> Didata.Accounts.register_user()

    user
  end

  def admin_fixture do
    user_fixture(%{email: "admin@email.com"})
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    Enum.at(String.split(captured.body, "[TOKEN]"), 1)
  end
end
