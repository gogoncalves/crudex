defmodule Crudex.Accounts do
  @accounts [
    %{
      id: 1,
      name: "João",
      balance: 100.0
    },
    %{
      id: 2,
      name: "Maria",
      balance: 200.0
    }
  ]

  def list_accounts do
    @accounts
  end

  def get_account(id) do
    Enum.find(@accounts, &(&1.id == id))
  end

  def create_account(attrs) do
    new_id = Enum.max_by(@accounts, &(&1.id)).id + 1
    account = Map.put(attrs, :id, new_id)
    @accounts = [@accounts | account]
    {:ok, account}
  end

  def update_account(account) do
    @accounts = Enum.map(@accounts, fn a ->
      if a.id == account.id do
        account
      else
        a
      end
    end)
    {:ok, account}
  end

  def delete_account(id) do
    @accounts = Enum.filter(@accounts, &(&1.id != id))
    :ok
  end
end
