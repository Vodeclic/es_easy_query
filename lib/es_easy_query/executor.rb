module EsEasyQuery
  # a class to send the raw quary to es and get the results
  class QueryExecutor
    # the Query object to execute
    attr_reader :query_class

    # The index to ru the query again
    attr_internal :_index_name

    delegate :to_json, to: :query

    def initialize(klass)
      @query_class = klass
    end

    def index(index_name)
      instance = self.class.new(query_class)
      instance.send(:_index_name=, index_name)
      instance
    end

    # query the query to execute on elasticsearch
    def search(params = {})
      client.search index: index_name, body: query(params).to_json
    end

    def index_name
      _index_name.presence || query_class.index_name
    end

    def query(params = {})
      query = query_class.new(params)
    end

    def client
      EsEasyQuery.client
    end
  end

end
