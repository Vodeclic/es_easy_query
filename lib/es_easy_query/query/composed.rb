module EsEasyQuery
  module Query
    module Composed
      extend ActiveSupport::Concern

      module ClassMethods
        def import(queries)
          queries.each do |q|
          end
        end
      end
    end
  end

end
