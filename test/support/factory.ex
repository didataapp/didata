defmodule Didata.Factory do
  @moduledoc """
    This is the  'Didata.Factory` module. Used for generating factories for test.
    More information at https://hexdocs.pm/ex_machina/ExMachina.html

    Examples:

    # Create factory

      def user_factory do
        %MyApp.User{
          name: "Jane Smith",
          role: sequence(:role, ["admin", "user", "other"]),
        }
      end

    Use factory:
      attrs = %{name: "John Doe"} # attrs is optional. Also accepts a keyword list.
      build(:user, attrs)
  """

  use ExMachina.Ecto, repo: Didata.Repo

  alias Didata.Studies.{Area, Objective}

  def objective_factory do
    %Objective{
      name: "ENEM"
    }
  end

  def area_factory do
    %Area{
      name: "Matematica e suas Tecnologias",
      number: 2,
      objective: build(:objective)
    }
  end
end
