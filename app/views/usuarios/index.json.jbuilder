json.array!(@usuarios) do |usuario|
  json.extract! usuario, :nombre, :apellido, :email, :passwd
  json.url usuario_url(usuario, format: :json)
end
