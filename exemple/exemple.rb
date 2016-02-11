require "es_easy_query"
# Search using the query defined in queries/subject_search_v1.rb
EsEasyQuery.use(:subject_search_v1).search(match: "test")

# changing the index to execute the query again
EsEasyQuery.use(:subject_search_v1).index(:my_new_super_index).search(match: "test")

# will output a curl compatbible string
EsEasyQuery.use(:subject_search_v1).to_url(match: "test")


# Using a composted query is just as easy
EsEasyQuery.use(:compsed_query).search(match: "test", lang_id: "")
