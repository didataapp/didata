alias Didata.Repo

alias Didata.Studies.{
  Area,
  Discipline,
  Objective,
  Topic,
  Subtopic
}

enem =
  %Objective{name: "ENEM"}
  |> Repo.insert!()

matematica_area =
  %Area{
    name: "Matematica e suas Tecnologias",
    number: 2,
    objective_id: enem.id
  }
  |> Repo.insert!()

matematica =
  %Discipline{
    name: "Matematica",
    area_id: matematica_area.id
  }
  |> Repo.insert!()

numeros =
  %Topic{
    name: "conhecimentos numericos",
    discipline_id: matematica.id
  }
  |> Repo.insert!()

_conjuntos =
  %Subtopic{
    name: "operações em conjuntos numéricos",
    topic: numeros
  }
  |> Repo.insert!()

_desigualdades =
  %Subtopic{
    name: "desigualdades",
    topic: numeros
  }
  |> Repo.insert!()

_contagem =
  %Subtopic{
    name: "princípios de contagem",
    topic: numeros
  }
  |> Repo.insert!()

{:ok, _admin} =
  %{
    email: "admin@email.com",
    password: "admin42"
  }
  |> Didata.Accounts.register_user()

{:ok, _student} =
  %{
    email: "estudante@email.com",
    password: "estudante42"
  }
  |> Didata.Accounts.register_user()
