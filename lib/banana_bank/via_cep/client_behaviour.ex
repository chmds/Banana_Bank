defmodule BananaBank.ViaCep.ClientBehaviour do
  @callback call(String.t(), String.t()) :: {:ok, map()} | {:error, atom()}
end
