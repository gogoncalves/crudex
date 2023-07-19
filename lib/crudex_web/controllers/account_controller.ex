defmodule CrudexWeb.AccountController do
  use CrudexWeb, :controller

  alias Crudex.Accounts

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, "index.html", accounts: accounts)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"account" => account_params}) do
    case Accounts.create_account(account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Conta criada com sucesso.")
        |> redirect(to: Routes.account_path(conn, :show, account.id))
      _ ->
        render(conn, "new.html")
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account(String.to_integer(id))

    if account do
      render(conn, "show.html", account: account)
    else
      conn
      |> put_flash(:error, "Conta não encontrada.")
      |> redirect(to: Routes.account_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    account = Accounts.get_account(String.to_integer(id))

    if account do
      render(conn, "edit.html", account: account)
    else
      conn
      |> put_flash(:error, "Conta não encontrada.")
      |> redirect(to: Routes.account_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account(String.to_integer(id))

    if account do
      updated_account = Map.merge(account, account_params)
      case Accounts.update_account(updated_account) do
        {:ok, _} ->
          conn
          |> put_flash(:info, "Conta atualizada com sucesso.")
          |> redirect(to: Routes.account_path(conn, :show, account.id))
        _ ->
          render(conn, "edit.html", account: account)
      end
    else
      conn
      |> put_flash(:error, "Conta não encontrada.")
      |> redirect(to: Routes.account_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    if Accounts.delete_account(String.to_integer(id)) do
      conn
      |> put_flash(:info, "Conta excluída com sucesso.")
      |> redirect(to: Routes.account_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Conta não encontrada.")
      |> redirect(to: Routes.account_path(conn, :index))
    end
  end
end
