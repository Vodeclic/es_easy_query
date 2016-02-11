require "es_easy_query/version"
require "es_easy_query/query/base"
require "es_easy_query/executor"

module EsEasyQuery
  # where all your Elastcisearch queries are stored inside your application
  # Default to app/es_queries
  mattr_accessor :queries_path
  @@queries_path = "app/es_queries"

  # find the given query and wrap it inside a aexcutor
  def self.use(query)
    query.to_s.camelize.safe_constantize unless Rails.configuration.eager_load
    query_klass = Query::Base.find(query)
    QueryExecutor.new(query_klass)
  end

  def self.client
    Elasticsearch::Client.new
  end
end

require "es_easy_query/railtie" if defined?(Rails)
