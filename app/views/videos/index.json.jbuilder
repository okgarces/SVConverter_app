json.array!(@videos) do |video|
  json.extract! video, :nombre, :usuario_id, :fecha_upload, :mensaje, :estado, :fecha_publicado, :ruta
  json.url video_url(video, format: :json)
end
