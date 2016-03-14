module EsEasyQuery
  # a class to send the raw quary to es and get the results
  class QueryExecutor
    # the Query object to execute
    attr_reader :query_class

    # size of the result set
    attr_reader :size


    # The index to ru the query again
    attr_internal :_index_name

    delegate :to_json, to: :query

    def initialize(klass)
      @query_class = klass
      @size = nil
      @instrumenter = EsEasyQuery.instrumenter
    end

    def index(index_name)
      instance = self.class.new(query_class)
      instance.instance_variable_set("@size", size) if @size
      instance.send(:_index_name=, index_name)
      instance
    end

    # query the query to execute on elasticsearch
    def search(params = {})
      results = nil
      q = query(params)
      results = client.search index: index_name, body: q.to_json
      instrument :search,  query: q, duration: results["took"], total: results["hits"]["total"], query_name: q.class.query_name
      results
    end

    def size(size)
      instance = self.class.new(query_class)
      instance.send(:_index_name=, index_name)
      instance.instance_variable_set("@size", size)
      instance
    end

    def index_name
      _index_name.presence || query_class.index_name
    end

    def query(params = {})
      query = query_class.new(params)
      query.size = @size if @size
      query
    end

    def client
      EsEasyQuery.client
    end

    protected

    def instrument(name, env = {})
      @instrumenter.instrument("#{name}.es_easy_query", env) do
        yield if block_given?
      end
    end
  end

end
