[
  import_deps: [:ecto_sql],
  inputs: ["*.exs"]
]

def change do
  create table(:accounts) do
    add :name, :string
    add :balance, :decimal, default: 0.0

    timestamps()
  end
end