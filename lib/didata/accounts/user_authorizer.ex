defimpl Didata.Authorizer, for: Didata.Accounts.User do
  alias Didata.Accounts.User

  @admin_email Application.get_env(:didata, :admin_email)

  def can?(%User{email: @admin_email}, _, _), do: true
  def can?(_, _, _), do: false
end
