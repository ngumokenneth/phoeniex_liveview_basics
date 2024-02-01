defmodule LiveviewBasics.Repo do
  use Ecto.Repo,
    otp_app: :liveview_basics,
    adapter: Ecto.Adapters.Postgres
end
