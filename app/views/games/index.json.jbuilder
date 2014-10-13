json.array!(@games) do |game|
  json.extract! game, :id, :r1letters, :r2letters, :r3letters, :r4letters, :r1cat, :r2cat, :r3cat, :r4cat, :name
  json.url game_url(game, format: :json)
end
