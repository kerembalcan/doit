defmodule DoitWeb.Util.ChangesetValidatorUtil do

  def translate_error(e = {_msg, _opts}) do
    Farmbackup.ErrorHelpers.translate_error(e)
  end

  def translate_error(msg), do: msg

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

end