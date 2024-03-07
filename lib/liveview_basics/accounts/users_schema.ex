defmodule LiveviewBasics.Accounts.UsersSchema do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :name, :string
    field :password, :string
    field :email, :string
  end

  def changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint([:email])
  end

  def registration_changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/@/)
  end

  def login_changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :password, :name])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/@/)
  end

  @moduledoc """
  A brief overview of Ecto.Schema.
   => Ecto.Schema is used to map external data into elixir structs. The data source could be from a user entered through a form, fetched data from a database or an API.

   => To acces the schema functionality one defines 'use.Ecto.schema' after the module definition. This will do a couple of thing:
        (1) Import Ecto.schema macros schema/1 & embedded_schema/2.
        (2) Register default values for the module i.e @primary_key & timestamps_opts
        (3) Define reflection functions __Schema__/1 & __Changeset__/1

  => Schemas are defined using the schema/1 macro or embedded_schema/1.
  => schema/1 takes the database table_name as the first argument
  => Within the schema definition the field macro is used to define the column name as an atom and the data_type of the coulum

  EXAMPLE-:

  schema "user" do
    field :name, :string
    field :age, :integer
    field :city, :string
  end

  SCHEMA ATTRIBUTES
  -----------------
  => These are module attributes defined to configure the defined schema. They're usually set after
    use Ecto.Schema definition and before the schema/2 definition.
    Example: @primary_key -> The @primary_key expects a tuple {field_name, type, opts} ==
              i.e @primary_key {:id, :binary_id, autogenerate: true}

              NOTE: Schema attributes can be set with a macro that can be used within the application.
              EXAMPLE:

              defmodule MyApp.schema do
                defmacro __using__(_) do
                  quote do
                    use Ecto.Schema
                    @primary_key {:id, :binary_id, :autogenerate: true}
                    @foreign_key_type :binary_id
                  end
                end
              end

    PRIMARY KEYS
    -----------
    => One can define primary keys as :id & :binary_id as they are the only forms supported by Ecto
    => :id is used for integer datatypes while :binary_id is used for binary data formats.
        when :autogenerate is defined with a primary key, it means the db will be responsible for generating the primary key.

    => Primary keys can be defined in 2 ways:
              (1) - setting @primary_key module attribute and defining primary_key: true as option for field/3 in the schema definition. Using this method automatically sets has_many & has_one reference

              (2) - setting composite primary_keys. This is done by setting primary_key: true, for the fields in the schema. This also goes along with setting @primary_key: false to disable generation of more primary keys

    THE MAP TYPE
    ------------

    This allows storage of data as an Elixr map. The keys are best stored as strings.


  """
end
