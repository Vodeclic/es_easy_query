class ComposedQuery <  EsEasyQuery::Query::Base
  import :subject_search_v1

  def query
    {
      query: {
        filtered: {
          query: {
            subject_search_v1.query
          },
          filter: {
            term: {
              lang_id: params[:lang_id]
            }
          }
        }
      }
    }
  end
end
