alias Didata.Repo

alias Didata.Studies.{
  Area,
  Discipline,
  Objective,
  Topic
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

_topic_1 =
  %Topic{
    name: "conhecimentos numericos",
    discipline_id: matematica.id
  }
  |> Repo.insert!()
