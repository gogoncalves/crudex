defmodule Crudex.Repo do
  use Ecto.Repo,
    otp_app: :crudex,
    adapter: Ecto.Adapters.Postgres
end
