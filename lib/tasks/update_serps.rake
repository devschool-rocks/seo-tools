desc 'update serps'
task 'serps:update' => :environment do
    RankingService.(
      Domain.all.map(&:value),
      Keyword.all.map(&:value)
    ).map {|result| Ranking.create result }
end
