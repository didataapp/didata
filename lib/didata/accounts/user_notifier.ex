defmodule Didata.Accounts.UserNotifier do
  @moduledoc false

  import Bamboo.Email
  alias Didata.Mailer

  @sender_email Application.get_env(:didata, :sender_email)

  defp deliver(to, subject, body) do
    new_email(
      to: to,
      from: @sender_email,
      subject: subject,
      html_body: body
    )
    |> Mailer.deliver_later()

    {:ok, %{to: to, subject: subject, body: body}}
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(
      user.email,
      "Bem vindo ao Didata! Confirme Seu Email",
      """
      <p>Olá #{user.email}.</p>
      <p>Você pode confirmar seu email visitando o endereço abaixo</p>
      <p><a href="#{url}">#{url}</a></p>
      <p>Se você não criou uma conta conosco, por favor ignore essa mensagem.</p>
      """
    )
  end

  @doc """
  Deliver instructions to reset password account.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(
      user.email,
      "Redefinição de Senha",
      """
      <p>Olá #{user.email}.
      <p>Você pode redefinir sua senha visitando o endereço abaixo</p>
      <p><a href="#{url}">#{url}</a></p>
      <p>Se você não solicitou essa mudança, por favor ignore essa mensagem.</p>
      """
    )
  end

  @doc """
  Deliver instructions to update your e-mail.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(
      user.email,
      "Atualização de email",
      """
      <p>Olá #{user.email}.</p>
      <p>Você pode mudar seu email visitando o endereço abaixo:</p>
      <p><a href="#{url}">#{url}</a></p>
      <p>Se você não solicitou essa mudança, por favor ignore essa mensagem.</p>
      """
    )
  end
end
