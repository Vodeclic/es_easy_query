require "es_easy_query/version"
require "es_easy_query/query/composed"
require "es_easy_query/query/base"
require "es_easy_query/executor"

module EsEasyQuery
  # where all your Elastcisearch queries are stored inside your application
  # Default to app/es_queries
  mattr_accessor :queries_path
  @@queries_path = "app/es_queries"

  # Find the given query by his name and return it ready for execution
  #
  def self.use(query)
    query_klass = find(query)
    QueryExecutor.new(query_klass)
  end

  def self.find(query)
    query.to_s.camelize.safe_constantize #unless Rails.configuration.eager_load
    Query::Base.find(query)
  end

  def self.client
    Elasticsearch::Client.new
  end
end

require "es_easy_query/railtie" if defined?(Rails)
