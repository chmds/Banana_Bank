ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BananaBank.Repo, :manual)

Mox.defmock(BananaBank.ViaCep.ClientMock, for: BananaBank.ViaCep.ClientBehaviour)
Application.put_env(:banana_bank, :via_cep_client, BananaBank.ViaCep.Client)
