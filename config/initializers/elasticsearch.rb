# config/initializers/elasticsearch.rb
Searchkick.client = Elasticsearch::Client.new(url: 'http://elasticsearch:9200', log: true)
