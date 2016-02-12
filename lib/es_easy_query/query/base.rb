module EsEasyQuery

  module Query

    class Base

      # Hold all available query class
      # This need to be cleared when app is reloaded to easy development of new queries
      mattr_accessor :queries
      @@queries = {}

      class_attribute :index_name

      # Hold all params that will be used baseto process the query
      attr_accessor :params

      include EsEasyQuery::Query::Composed

      class NotFoundQuery < StandardError; end

      class << self

        def query_name
          name.underscore
        end

        def inherited(subclass)
          queries[subclass.query_name.to_sym] = subclass
        end

        def find(query_name)
          queries.fetch(query_name.to_sym) {
            raise NotFoundQuery, "No query defined for #{query_name}"
          }
        end

        def use_index(index_name)
          self.index_name = index_name
        end

      end

      def initialize(params = {})
        @params = params
      end

      def query_name
        self.class.query_name
      end

      def index(index_name)
        self.index_name = index_name
      end

      # compile the query to a string suitiable to send to es
      def compile
        query.to_json
      end

      alias_method :to_json, :compile

    end


  end

end
