defmodule Servy.Wildthings do

  def list_bears do
    [
      %{id: 1, name: "Darth Vader", type: "Sith", hibernating: true},
      %{id: 2, name: "Luke Skywalker", type: "Jedi", hibernating: false},
      %{id: 3, name: "Yoda", type: "Jedi", hibernating: false},
      %{id: 4, name: "Obi-Wan", type: "Jedi", hibernating: true},
      %{id: 5, name: "Leia", type: "Princesa", hibernating: false},
      %{id: 6, name: "Han Solo", type: "Piloto", hibernating: false},
      %{id: 7, name: "Chewbacca", type: "Copiloto", hibernating: true},
      %{id: 8, name: "C-3PO", type: "Droide", hibernating: false},
      %{id: 9, name: "R2-D2", type: "Droide", hibernating: true},
      %{id: 10, name: "BB-8", type: "Droide", hibernating: false}
    ]
  end

  def get_bear(id) do
    Enum.find(list_bears(), fn bear -> bear.id == id end)
  end
end
