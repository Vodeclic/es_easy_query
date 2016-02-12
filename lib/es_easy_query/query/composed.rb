module EsEasyQuery
  module Query
    module Composed
      extend ActiveSupport::Concern

      included do
        class_attribute :imported_queries
      end

      module ClassMethods
        def import(*queries)
          self.imported_queries ||= {}
          queries.each do |q|
            self.imported_queries[q] = EsEasyQuery.find(q)
            define_method q do
              ivar_name = "@_query_#{q}"
              unless instance_variable_get(ivar_name).present?
                instance_variable_set(ivar_name, imported_queries[q].new(params))
              end
              instance_variable_get(ivar_name)
            end
          end
        end
      end
    end
  end

end

