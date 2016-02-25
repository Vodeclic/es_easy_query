class SubjectSearchV1 < EsEasyQuery::Query::Base
  use_index :subject

  def query
    {
      query: {
        match_all: {
          text: params[:match]
        }
      }
    }
  end

end
